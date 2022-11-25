import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../../../networks/dio/dio.dart';
import '/networks/endpoints.dart';

class PostDeleteCartApi {
  Future<Map> postCart(String code) async {
    FormData formData = FormData.fromMap({'code': code, '_method': 'DELETE'});

    log(formData.fields.toString());

    final response = await postHttp(Endpoints.postCart(), formData);
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
