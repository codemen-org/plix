import 'dart:convert';
import 'dart:developer';

import '../../../../../networks/dio/dio.dart';
import '/networks/endpoints.dart';

class VerifyOtpApi {
  Future<Map> verifyOtp({
    required String email,
    required String code,
  }) async {
    Map data = {"email": email, "code": code, "status": "0", "_method": "PUT"};

    final response = await postHttp(Endpoints.postVerify(), data);

    if (response.statusCode == 200) {
      Map data = json.decode(json.encode(response.data));

      return data;
    }

    log(response);

    Map empty = {};
    return empty;
  }
}
