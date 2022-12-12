import 'dart:convert';

import 'package:flutter/foundation.dart';
import '../../../../../networks/dio/dio.dart';
import '/networks/endpoints.dart';

class GetAddressWithIdApi {
  Future<Map> getAddressWithId(int id) async {
    final response = await getHttp(Endpoints.getSingleDeliveryAddress(id));
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
