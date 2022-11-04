import 'dart:convert';

import '../../../../networks/dio/dio.dart';
import '../../../../networks/endpoints.dart';

class GetItemApi {
  Future<Map> fetchItemList() async {
    final response = await getHttp(
      Endpoints.getShopProducts(),
    );

    if (response.statusCode == 200) {
      Map data = json.decode(json.encode(response.data));
      return data;
    }
    Map empty = {};
    return empty;
  }
}
