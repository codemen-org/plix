import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';

import '../../../../networks/dio/dio.dart';
import '../../../../networks/endpoints.dart';



class PostDeviceTokenApi {
  Future<Map> postDeviceToken(Map data) async {
    final response = await postHttp(
      Endpoints.postDeviceToken(),
      data,
    );

    if (response.statusCode == 200) {
      Map data = json.decode(json.encode(response.data));
      log(data.toString());
      return data;
    }
    if (kDebugMode) {
      print(response.toString);
    }
    Map empty = {};
    return empty;
  }
}
