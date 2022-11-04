import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../helpers/navigation_service.dart';
import '../../../../../widgets/loading_indicators.dart';
import '/helpers/all_routes.dart';
import 'api.dart';

class VerifyOtpRX {
  final api = VerifyOtpApi();
  Map empty = {};
  final BehaviorSubject _dataFetcher = BehaviorSubject<Map>();

  ValueStream get getFileData => _dataFetcher.stream;
  String message = "";
  Future<void> verifyOtp({
    required String email,
    required String code,
  }) async {
    try {
      showDialog(
        context: NavigationService.context,
        builder: (context) => loadingIndicatorCircle(context: context),
      );
      Map data = await api.verifyOtp(
        email: email,
        code: code,
      );
      _dataFetcher.sink.add(data);
      final storage = GetStorage();
      message = data["message"];

      NavigationService.goBack;
      if (data["success"] == false) {
        throw Exception();
      }
      NavigationService.navigateToReplacement(Routes.logInScreen);
    } catch (e) {
      log(e.toString());
      NavigationService.goBack;
      _dataFetcher.sink.addError(e);
    } finally {
      ScaffoldMessenger.of(NavigationService.context).showSnackBar(SnackBar(
        content: Text(message),
      ));
    }
  }

  void clean() {
    _dataFetcher.sink.add(empty);
  }

  void dispose() {
    _dataFetcher.close();
  }
}
