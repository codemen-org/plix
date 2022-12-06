import 'dart:convert';

import '../../../../networks/dio/dio.dart';
import '../../../../networks/endpoints.dart';

class GetCategoriesApi {
  Future<Map> fetchCategoriesList() async {
    final response = await getHttp(
      Endpoints.getShopProductCategory(),
    );

    if (response.statusCode == 200) {
      Map data = json.decode(json.encode(response.data));
      return data;
    }
    Map empty = {};
    return empty;
  }
}
