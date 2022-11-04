import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../networks/dio/dio.dart';
import '../../../../networks/endpoints.dart';

class GetProductDetailApi {
  Future<Map> getProductDetail(String slug) async {
    final response = await getHttp(Endpoints.getProductDetail(slug));

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



    // var headers = {'Accept': 'application/json'};
    // var request = http.MultipartRequest(
    //     'POST', Uri.parse('https://lawyer.codemen.org/api/fines'));
    // request.fields.addAll({
    //   'bill_type': billtype!,
    //   'name': name!,
    //   'email': email!,
    //   'phone': phone!,
    //   'message': message!
    // });
    // request.files
    //     .add(await http.MultipartFile.fromPath('documents', document!.path));
    // request.headers.addAll(headers);

    // http.StreamedResponse response = await request.send();

    // if (response.statusCode == 200) {
    //   Map data =
    //       json.decode(json.encode(await response.stream.bytesToString()));
    //   return data;
    // }
    // Map empty = {};
    // return empty;
