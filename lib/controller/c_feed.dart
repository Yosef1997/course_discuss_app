import 'package:course_discuss_app/model/topic.dart';
import 'package:course_discuss_app/source/topic_source.dart';
import 'package:flutter/cupertino.dart';

class CFeed extends ChangeNotifier {
  List<Topic> _topics = [];
  List<Topic> get topics => _topics;
  setTopics(String idUser) async {
    _topics = await TopicSource.readFeed(idUser);
    notifyListeners();
  }
}
