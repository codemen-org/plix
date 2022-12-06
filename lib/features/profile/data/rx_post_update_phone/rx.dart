import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../helpers/all_routes.dart';
import '../../../../helpers/navigation_service.dart';
import '../../../../networks/api_acess.dart';
import '../../../../widgets/loading_indicators.dart';
import 'api.dart';

class PostUpdatePhoneRX {
  final api = PostUpdatePhoneApi();
  late Map empty;
  final BehaviorSubject _dataFetcher = BehaviorSubject<Map>();

  String message = "Something went wrong";

  ValueStream get getPostForgetEmailRes => _dataFetcher.stream;

  Future<void> postUpdatePhone({String? phone}) async {
    try {
      showDialog(
        context: NavigationService.context,
        builder: (context) => loadingIndicatorCircle(context: context),
      );
      Map<String, dynamic> data = {"phone": phone};
      Map resdata = await api.postUpdatePhone(data);

      _dataFetcher.sink.add(resdata);

      message = resdata["message"];
      if (resdata["success"] == false) throw Exception();
      getProfileRXObj.fetchProfileData();
      NavigationService.goBack;
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
