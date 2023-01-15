import 'package:course_discuss_app/model/topic.dart';
import 'package:course_discuss_app/source/follow_source.dart';
import 'package:course_discuss_app/source/topic_source.dart';
import 'package:d_info/d_info.dart';
import 'package:flutter/cupertino.dart';

import '../source/user_source.dart';

class CProfile extends ChangeNotifier {
  List<Topic> _topics = [];
  List<Topic> get topics => _topics;
  setTopics(String idUser) async {
    _topics = await TopicSource.readWhereIdUser(idUser);
    notifyListeners();
  }

  Map<String, dynamic> _stat = {
    'topic': 0.0,
    'following': 0.0,
    'follower': 0.0,
  };
  Map<String, dynamic> get stat => _stat;
  setStat(String idUser) async {
    _stat = await UserSource.stat(idUser);
    notifyListeners();
  }

  bool _isFollowing = false;
  bool get isFollowing => _isFollowing;
  checkIsFollowing(String fromIdUser, String toIdUser) async {
    _isFollowing = await FollowSource.checkIsFollowing(fromIdUser, toIdUser);
    notifyListeners();
  }

  setFollow(BuildContext context, String fromIdUser, String toIdUser) {
    if (isFollowing) {
      FollowSource.noFollowing(fromIdUser, toIdUser).then((success) {
        if (success) {
          setStat(toIdUser);
          checkIsFollowing(fromIdUser, toIdUser);
          DInfo.snackBarSuccess(context, 'Success UnFollow');
        } else {
          DInfo.snackBarError(context, 'UnFollow Failed');
        }
      });
    } else {
      FollowSource.following(fromIdUser, toIdUser).then((success) {
        if (success) {
          setStat(toIdUser);
          checkIsFollowing(fromIdUser, toIdUser);
          DInfo.snackBarSuccess(context, 'Success Follow');
        } else {
          DInfo.snackBarError(context, 'Follow Failed');
        }
      });
    }
  }
}
