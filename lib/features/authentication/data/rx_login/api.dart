import 'dart:convert';
import 'dart:developer';

import '../../../../networks/dio/dio.dart';
import '/networks/endpoints.dart';

class LoginApi {
  Future<Map> login(String email, String password) async {
    Map data = {
      "email_phone": email,
      "password": password,
    };

    final response = await postHttp(Endpoints.postlogin(), data);

    if (response.statusCode == 200) {
      Map data = json.decode(json.encode(response.data));

      return data;
    }

    log(response);

    Map empty = {};
    return empty;
  }
}
