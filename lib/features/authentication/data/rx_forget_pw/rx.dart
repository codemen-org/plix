import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../helpers/all_routes.dart';
import '../../../../helpers/navigation_service.dart';
import '../../../../widgets/loading_indicators.dart';
import 'api.dart';

class PostForgertPwRX {
  final api = PostForgetPwApi();
  Map empty = {};
  final BehaviorSubject _dataFetcher = BehaviorSubject<Map>();

  String message = "Something went wrong";
  ValueStream get getFileData => _dataFetcher.stream;
  Future<void> postProductBasicData(String email, String password,
      String password_confirmation, String code) async {
    try {
      showDialog(
        context: NavigationService.context,
        builder: (context) => loadingIndicatorCircle(context: context),
      );

      Map allData =
          await api.postForgetPw(email, password, password_confirmation, code);
      _dataFetcher.sink.add(allData);
      message = allData["message"];
      if (allData["success"] == false) throw Exception();
      NavigationService.goBack;
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
