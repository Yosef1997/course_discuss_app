import 'dart:convert';

import 'package:course_discuss_app/model/comment.dart';
import 'package:course_discuss_app/model/topic.dart';
import 'package:course_discuss_app/model/user.dart';
import 'package:course_discuss_app/source/comment_source.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class CComment extends ChangeNotifier {
  List<Comment> _comments = [];
  List<Comment> get comments => _comments;
  setComments(Topic topic) async {
    _image = '';
    _imageBase64code = '';
    _comments = await CommentSource.read(topic.id);
    setReplyTo(topic.user!);
    notifyListeners();
  }

  User? _replyTo;
  User? get replyTo => _replyTo;
  setReplyTo(User user) {
    _replyTo = user;
    notifyListeners();
  }

  String _image = '';
  String get image => _image;

  String _imageBase64code = '';
  String get imagebase64code => _imageBase64code;

  pickImage(ImageSource source) async {
    XFile? result = await ImagePicker().pickImage(source: source);
    if (result != null) {
      _image = result.name;
      _imageBase64code = base64Encode(await result.readAsBytes());
      notifyListeners();
    }
  }
}
