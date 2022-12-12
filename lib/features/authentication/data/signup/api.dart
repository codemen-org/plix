import 'dart:convert';
import 'dart:developer';

import '../../../../../networks/dio/dio.dart';
import '/networks/endpoints.dart';

class SignUpApi {
  Future<Map> signUp(
      {required String firstName,
      required String lastName,
      required String phone,
      required String email,
      required String password,
      required String retypePw}) async {
    Map data = {
      "first_name": firstName,
      "last_name": lastName,
      "phone": phone,
      "email": email,
      "password": password,
      "password_confirmation": retypePw,
      "role_id": 2
    };

    final response = await postHttp(Endpoints.postSignUp(), data);

    if (response.statusCode == 200) {
      Map data = json.decode(json.encode(response.data));

      return data;
    }

    log(response);

    Map empty = {};
    return empty;
  }
}
