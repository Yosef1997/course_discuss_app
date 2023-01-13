import 'dart:convert';

import 'package:d_method/d_method.dart';
import 'package:http/http.dart';

import '../config/api.dart';

class FollowSource {
  static Future<bool> checkIsFollowing(
    String fromIdUser,
    String toIdUser,
  ) async {
    String url = '${Api.user}/check.php';
    try {
      Response response = await Client().post(Uri.parse(url), body: {
        'from_id_user': fromIdUser,
        'to_id_user': toIdUser,
      });
      DMethod.printTitle('Follow Source - checkIsFollowing', response.body);
      Map responseBody = jsonDecode(response.body);
      return responseBody['success'];
    } catch (err) {
      DMethod.printTitle('Follow Source - checkIsFollowing', err.toString());
      return false;
    }
  }

  static Future<bool> following(
    String fromIdUser,
    String toIdUser,
  ) async {
    String url = '${Api.user}/following.php';
    try {
      Response response = await Client().post(Uri.parse(url), body: {
        'from_id_user': fromIdUser,
        'to_id_user': toIdUser,
      });
      DMethod.printTitle('Follow Source - following', response.body);
      Map responseBody = jsonDecode(response.body);
      return responseBody['success'];
    } catch (err) {
      DMethod.printTitle('Follow Source - following', err.toString());
      return false;
    }
  }

  static Future<bool> noFollowing(
    String fromIdUser,
    String toIdUser,
  ) async {
    String url = '${Api.user}/no_following.php';
    try {
      Response response = await Client().post(Uri.parse(url), body: {
        'from_id_user': fromIdUser,
        'to_id_user': toIdUser,
      });
      DMethod.printTitle('Follow Source - noFollowing', response.body);
      Map responseBody = jsonDecode(response.body);
      return responseBody['success'];
    } catch (err) {
      DMethod.printTitle('Follow Source - noFollowing', err.toString());
      return false;
    }
  }
}
