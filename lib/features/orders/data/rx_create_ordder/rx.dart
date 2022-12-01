import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../helpers/all_routes.dart';
import '../../../../helpers/navigation_service.dart';
import '../../../../widgets/loading_indicators.dart';
import 'api.dart';

class PostCreateOrderRX {
  final api = PostCreateOrderApi();
  late Map empty;
  final BehaviorSubject _dataFetcher = BehaviorSubject<Map>();

  String message = "Something went wrong";

  ValueStream get getPostCreateOrderRes => _dataFetcher.stream;

  Future<void> postCreateOrder(
      {required String deliveryDate, required String timeSllot}) async {
    try {
      showDialog(
        context: NavigationService.context,
        builder: (context) => loadingIndicatorCircle(context: context),
      );
      Map<String, String> data = {
        "delivery_date": deliveryDate,
        "time_slot": timeSllot
      };
      Map resdata = await api.postCreateOrder(data);

      _dataFetcher.sink.add(resdata);

      message = resdata["message"];
      if (resdata["success"] == false) throw Exception();
      int orderId = resdata["data"]["orderCode"];
      log(orderId.toString());

      NavigationService.goBack;
      NavigationService.navigateToWithArgs(
          Routes.paymentScreen, {"orderID": orderId.toString()});
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
