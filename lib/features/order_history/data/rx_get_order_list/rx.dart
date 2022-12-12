import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:plix/constants/app_constants.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../helpers/navigation_service.dart';
import '../../../../../widgets/loading_indicators.dart';
import 'api.dart';

class GetOrderListRX {
  final api = GetOrderListApi();
  final storage = GetStorage();
  Map empty = {};
  final BehaviorSubject _dataFetcher = BehaviorSubject<Map>();
  ValueStream get getOrderListDataRes => _dataFetcher.stream;
  String message = "";
  Future<void> getOrderListData() async {
    try {
      // showDialog(
      //   context: NavigationService.context,
      //   builder: (context) => loadingIndicatorCircle(context: context),
      // );
      Map allData = await api.getOrderList();
      message = allData["message"];
      _dataFetcher.sink.add(allData);
      //   NavigationService.goBack;
    } catch (e) {
      //  NavigationService.goBack;
      _dataFetcher.sink.addError(e);
    } finally {
      // ScaffoldMessenger.of(NavigationService.context).showSnackBar(SnackBar(
      //   content: Text(message),
      // ));
    }
  }

  void clean() {
    _dataFetcher.sink.add(empty);
  }

  void dispose() {
    _dataFetcher.close();
  }
}
