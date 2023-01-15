import 'package:course_discuss_app/model/topic.dart';
import 'package:course_discuss_app/model/user.dart';
import 'package:course_discuss_app/source/topic_source.dart';
import 'package:course_discuss_app/source/user_source.dart';
import 'package:flutter/cupertino.dart';

class CSearch extends ChangeNotifier {
  List<String> get filters => ['Topic', 'User'];

  String _filter = 'Topic';
  String get filter => _filter;
  set filter(String newFilter) {
    _filter = newFilter;
    notifyListeners();
  }

  search(String searchQuery) {
    if (searchQuery == 'Topic') {
      setTopics(searchQuery);
    } else {
      setTopics(searchQuery);
    }
  }

  List<Topic> _topics = [];
  List<Topic> get topics => _topics;
  setTopics(String searchQuery) async {
    _topics = await TopicSource.search(searchQuery);
    notifyListeners();
  }

  List<User> _users = [];
  List<User> get users => _users;
  setUsers(String searchQuery) async {
    _users = await UserSource.search(searchQuery);
    notifyListeners();
  }
}
