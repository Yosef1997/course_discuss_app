import 'dart:convert';

import 'package:d_method/d_method.dart';
import 'package:http/http.dart';

import '../config/api.dart';

class TopicSource {
  static Future<bool> create(
    String title,
    String description,
    String images,
    String base64codes,
    String idUser,
  ) async {
    String url = '${Api.topic}/create.php';
    try {
      Response response = await Client().post(Uri.parse(url), body: {
        'title': title,
        'description': description,
        'images': images,
        'base64codes': base64codes,
        'id_user': idUser,
      });
      DMethod.printTitle('Topic Source - create', response.body);
      Map responseBody = jsonDecode(response.body);
      return responseBody['success'];
    } catch (err) {
      DMethod.printTitle('Topic Source - create', err.toString());
      return false;
    }
  }

  static Future<bool> update(
    String id,
    String title,
    String description,
  ) async {
    String url = '${Api.topic}/update.php';
    try {
      Response response = await Client().post(Uri.parse(url), body: {
        'title': title,
        'description': description,
        'id': id,
      });
      DMethod.printTitle('Topic Source - update', response.body);
      Map responseBody = jsonDecode(response.body);
      return responseBody['success'];
    } catch (err) {
      DMethod.printTitle('Topic Source - update', err.toString());
      return false;
    }
  }
}
