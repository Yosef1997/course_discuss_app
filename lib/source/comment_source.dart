import 'dart:convert';

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
}
