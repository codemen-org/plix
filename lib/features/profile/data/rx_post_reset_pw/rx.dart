import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../helpers/all_routes.dart';
import '../../../../helpers/navigation_service.dart';
import '../../../../networks/api_acess.dart';
import '../../../../widgets/loading_indicators.dart';
import 'api.dart';

class PostUpdatePWRX {
  final api = PostUpdatePasswordApi();
  late Map empty;
  final BehaviorSubject _dataFetcher = BehaviorSubject<Map>();

  String message = "Something went wrong";

  ValueStream get getPostResetPWRes => _dataFetcher.stream;

  Future<void> postResetPW(String oldPW, String newPW, String retypePW) async {
    try {
      showDialog(
        context: NavigationService.context,
        builder: (context) => loadingIndicatorCircle(context: context),
      );
      Map<String, dynamic> data = {
        "old_password": oldPW,
        "password": newPW,
        "password_confirmation": retypePW,
        "_method": "PUT"
      };
      Map resdata = await api.postUpdatePW(data);

      _dataFetcher.sink.add(resdata);

      message = resdata["message"];
      if (resdata["success"] == false) throw Exception();
      NavigationService.goBeBack;
    } catch (e) {
      log(e.toString());
      _dataFetcher.sink.addError(e);
    } finally {
      NavigationService.goBack;
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
