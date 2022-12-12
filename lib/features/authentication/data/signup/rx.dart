import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../helpers/navigation_service.dart';
import '../../../../../widgets/loading_indicators.dart';
import '/helpers/all_routes.dart';
import 'api.dart';

class GetSignUpRX {
  final api = SignUpApi();
  Map empty = {};
  final BehaviorSubject _dataFetcher = BehaviorSubject<Map>();

  ValueStream get getFileData => _dataFetcher.stream;
  String message = "";
  Future<void> signup(
      {required String firstName,
      required String lastName,
      required String phone,
      required String email,
      required String password,
      required String retypePw}) async {
    try {
      showDialog(
        context: NavigationService.context,
        builder: (context) => loadingIndicatorCircle(context: context),
      );
      Map data = await api.signUp(
          firstName: firstName,
          lastName: lastName,
          phone: phone,
          email: email,
          password: password,
          retypePw: retypePw);
      _dataFetcher.sink.add(data);
      final storage = GetStorage();
      message = data["message"];

      NavigationService.goBack;

      NavigationService.navigateToReplacement(Routes.verifyOtpScreen);
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
