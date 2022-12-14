import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../helpers/navigation_service.dart';
import '../../../../networks/dio/dio.dart';
import '../../../../networks/endpoints.dart';
import '../../../../widgets/loading_indicators.dart';

class DeleteTokenApi {
  Future<Map> deleteToken(Map data) async {
    showDialog(
      context: NavigationService.context,
      builder: (context) => loadingIndicatorCircle(context: context),
    );

    final response = await postHttp(Endpoints.deleteDeviceToken(), data);

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
