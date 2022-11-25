import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:plix/constants/app_constants.dart';
import 'package:plix/features/cart/data/rx_get_cart/rx.dart';
import 'package:plix/networks/api_acess.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../helpers/navigation_service.dart';
import '../../../../widgets/loading_indicators.dart';
import 'api.dart';

class PostDeleteCartRX {
  final api = PostDeleteCartApi();
  Map empty = {};
  final BehaviorSubject _dataFetcher = BehaviorSubject<Map>();
  ValueStream get getPostDeleteCartData => _dataFetcher.stream;
  String message = "";
  Future<void> postCartData(String code) async {
    try {
      Map allData = await api.postCart(code);
      message = allData["message"];
      _dataFetcher.sink.add(allData);
      getCartRXObj.getCartData();
    } catch (e) {
      NavigationService.goBack;
      _dataFetcher.sink.addError(e);
      log(e.toString());
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
