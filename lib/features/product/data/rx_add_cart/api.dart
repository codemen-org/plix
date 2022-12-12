import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../../../networks/dio/dio.dart';
import '/networks/endpoints.dart';

class PostCartApi {
  Future<Map> postCart(
    String restaurantId,
    String foodId,
    String optionId,
    String quantity,
    String specialReq,
    List<int> data,
  ) async {
    String foodAddOnID =
        data.toString().replaceAll("[", "").replaceAll("]", "");
    FormData formData = FormData.fromMap({
      'restaurant_id': restaurantId,
      'restaurant_food_id': foodId,
      'food_option_id': optionId,
      'quantity': quantity,
      'special_request': specialReq,
      'food_addon_id': foodAddOnID
    });

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
