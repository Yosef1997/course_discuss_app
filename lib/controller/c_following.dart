import 'package:course_discuss_app/model/user.dart';
import 'package:course_discuss_app/source/follow_source.dart';
import 'package:flutter/cupertino.dart';

class CFollowing extends ChangeNotifier {
  List<User> _list = [];
  List<User> get users => _list;
  setList(String idUser) async {
    _list = await FollowSource.readFollowing(idUser);
    notifyListeners();
  }
}
