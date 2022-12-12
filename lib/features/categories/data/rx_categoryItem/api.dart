import 'dart:convert';

import '../../../../networks/dio/dio.dart';
import '../../../../networks/endpoints.dart';

class GetProductsByCategoriesApi {
  Future<Map> fetchProductsByCategoriesList(String slug) async {
    final response = await getHttp(
      Endpoints.getAllProductsByCategory(slug),
    );

    if (response.statusCode == 200) {
      Map data = json.decode(json.encode(response.data));
      return data;
    }
    Map empty = {};
    return empty;
  }
}
