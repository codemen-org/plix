import 'dart:convert';

import '../../../../networks/dio/dio.dart';
import '../../../../networks/endpoints.dart';

class GetLogOutApi {
  Future<Map> fetchLogoutData() async {
    final response = await getHttp(
      Endpoints.getLogout(),
    );

    if (response.statusCode == 200) {
      Map data = json.decode(json.encode(response.data));
      return data;
    }
    // print(_response.toString);
    Map empty = {};
    return empty;
  }
}
