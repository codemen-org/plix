import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:plix/constants/app_constants.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../helpers/navigation_service.dart';
import '../../../../../widgets/loading_indicators.dart';
import 'api.dart';

class GetOrderDetailRX {
  final api = GetOrderDetailApi();
  final storage = GetStorage();
  Map empty = {};
  final BehaviorSubject _dataFetcher = BehaviorSubject<Map>();
  ValueStream get getGetOrderDetailDataRes => _dataFetcher.stream;
  String message = "";
  Future<void> getGetOrderDetailData(String orderID) async {
    try {
      showDialog(
        context: NavigationService.context,
        builder: (context) => loadingIndicatorCircle(context: context),
      );
      Map allData = await api.getOrderDetail(orderID);
      message = allData["message"];
      _dataFetcher.sink.add(allData);
    } catch (e) {
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
