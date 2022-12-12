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

class PostCartRX {
  final api = PostCartApi();
  final storage = GetStorage();
  Map empty = {};
  final BehaviorSubject _dataFetcher = BehaviorSubject<Map>();
  ValueStream get getPostCartData => _dataFetcher.stream;
  String message = "";
  Future<void> postCartData(String foodId, String optionId, String quantity,
      String specialReq, List<int> foodAddOnID) async {
    try {
      showDialog(
        context: NavigationService.context,
        builder: (context) => loadingIndicatorCircle(context: context),
      );
      int restaurantId = storage.read(kKeyRestaurantID);
      Map allData = await api.postCart(restaurantId.toString(), foodId,
          optionId, quantity, specialReq, foodAddOnID);
      message = allData["message"];
      _dataFetcher.sink.add(allData);
      NavigationService.goBack;
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
