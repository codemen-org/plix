import 'dart:convert';

import 'package:flutter/foundation.dart';
import '../../../../../networks/dio/dio.dart';
import '/networks/endpoints.dart';

class GetDefaultAddressApi {
  Future<Map> getDefaultAddress() async {
    final response = await getHttp(Endpoints.getDefaultDelivaryAddress());
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
