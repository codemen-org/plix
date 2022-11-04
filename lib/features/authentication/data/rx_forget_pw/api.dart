import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../../../networks/dio/dio.dart';
import '/networks/endpoints.dart';

class PostForgetPwApi {
  Future<Map> postForgetPw(
    String email,
    String password,
    String password_confirmation,
    String token,
  ) async {
    FormData formData = FormData.fromMap({
      'email': email,
      'password': password,
      'password_confirmation': password_confirmation,
      '_method': 'PUT',
      'token': token
    });

    log(formData.fields.toString());

    final response = await postHttp(Endpoints.postResetPassword(), formData);
    if (response.statusCode == 200) {
      Map data = json.decode(json.encode(response.data));
      return data;
    }
    if (kDebugMode) {
      print(response.toString);
    }
    Map empty = {};
    return empty;
  }
}
