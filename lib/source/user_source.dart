import 'dart:convert';

import 'package:course_discuss_app/config/api.dart';
import 'package:d_method/d_method.dart';
import 'package:http/http.dart';

class UserSource {
  static Future<Map> register(String username, String password) async {
    String url = '${Api.user}/register.php';
    try {
      Response response = await Client().post(Uri.parse(url), body: {
        'username': username,
        'password': password,
      });
      DMethod.printTitle('User Source - Register', response.body);
      Map responseBody = jsonDecode(response.body);
      return responseBody;
    } catch (err) {
      DMethod.printTitle('User Source - Register', err.toString());
      return {'success': false};
    }
  }

  static Future<Map> login(String username, String password) async {
    String url = '${Api.user}/login.php';
    try {
      Response response = await Client().post(Uri.parse(url), body: {
        'username': username,
        'password': password,
      });
      DMethod.printTitle('User Source - login', response.body);
      Map responseBody = jsonDecode(response.body);
      return responseBody;
    } catch (err) {
      DMethod.printTitle('User Source - login', err.toString());
      return {'success': false};
    }
  }

  static Future<Map> updateImage(
    String id,
    String oldImage,
    String newImage,
    String newBase64code,
  ) async {
    String url = '${Api.user}/update_image.php';
    try {
      Response response = await Client().post(Uri.parse(url), body: {
        'id': id,
        'old_image': oldImage,
        'new_image': newImage,
        'new_base64code': newBase64code,
      });
      DMethod.printTitle('User Source - updateImage', response.body);
      Map responseBody = jsonDecode(response.body);
      return responseBody;
    } catch (err) {
      DMethod.printTitle('User Source - updateImage', err.toString());
      return {'success': false};
    }
  }

  static Future<Map<String, dynamic>> stat(String idUser) async {
    String url = '${Api.user}/stat.php';
    try {
      Response response = await Client().post(Uri.parse(url), body: {
        'id_user': idUser,
      });
      DMethod.printTitle('User Source - stat', response.body);
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      return responseBody;
    } catch (err) {
      DMethod.printTitle('User Source - stat', err.toString());
      return {
        'topic': 0.0,
        'follower': 0.0,
        'following': 0.0,
      };
    }
  }
}
