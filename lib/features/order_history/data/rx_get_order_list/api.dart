import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../../../../networks/dio/dio.dart';
import '/networks/endpoints.dart';

class GetOrderListApi {
  Future<Map> getOrderList() async {
    final response = await getHttp(Endpoints.getOrderList());
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
