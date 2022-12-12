import 'dart:convert';

import 'package:flutter/foundation.dart';
import '../../../../../networks/dio/dio.dart';
import '/networks/endpoints.dart';

class DeleteAddressWithIdApi {
  Future<Map> deleteAddressWithId(int id) async {
    final response = await deleteHttp(Endpoints.DeleteDeliveryAddress(id));
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
