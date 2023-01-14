import 'dart:convert';

import 'package:course_discuss_app/model/comment.dart';
import 'package:d_method/d_method.dart';
import 'package:http/http.dart';

import '../config/api.dart';

class CommentSource {
  static Future<bool> create(
    String idTopic,
    String fromIdUser,
    String toIdUser,
    String description,
    String image,
    String base64code,
  ) async {
    String url = '${Api.comment}/create.php';
    try {
      Response response = await Client().post(Uri.parse(url), body: {
        'id_topic': idTopic,
        'from_id_user': fromIdUser,
        'to_id_user': toIdUser,
        'description': description,
        'image': image,
        'base64code': base64code,
      });
      DMethod.printTitle('Comment Source - create', response.body);
      Map responseBody = jsonDecode(response.body);
      return responseBody['success'];
    } catch (err) {
      DMethod.printTitle('Comment Source - create', err.toString());
      return false;
    }
  }

  static Future<bool> delete(
    String id,
    String image,
  ) async {
    String url = '${Api.comment}/delete.php';
    try {
      Response response = await Client().post(Uri.parse(url), body: {
        'id': id,
        'image': image,
      });
      DMethod.printTitle('Comment Source - delete', response.body);
      Map responseBody = jsonDecode(response.body);
      return responseBody['success'];
    } catch (err) {
      DMethod.printTitle('Comment Source - delete', err.toString());
      return false;
    }
  }

  static Future<List<Comment>> read(String idTopic) async {
    String url = '${Api.comment}/read.php';
    try {
      Response response = await Client().post(Uri.parse(url), body: {
        'id_topic': idTopic,
      });
      DMethod.printTitle('Comment Source - read', response.body);
      Map responseBody = jsonDecode(response.body);
      if (responseBody['success']) {
        List list = responseBody['data'];
        return list.map((e) {
          Map<String, dynamic> item = Map<String, dynamic>.from(e);
          return Comment.fromJson(item);
        }).toList();
      }
      return [];
    } catch (err) {
      DMethod.printTitle('Comment Source - read', err.toString());
      return [];
    }
  }
}
