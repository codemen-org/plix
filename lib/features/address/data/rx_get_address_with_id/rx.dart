import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'package:rxdart/rxdart.dart';

import '../../../../helpers/navigation_service.dart';
import '../../../../widgets/loading_indicators.dart';
import 'api.dart';

class GetAddressWithIdRX {
  final api = GetAddressWithIdApi();
  final storage = GetStorage();
  Map empty = {};
  final BehaviorSubject _dataFetcher = BehaviorSubject<Map>();
  ValueStream get getAddresWithIdRes => _dataFetcher.stream;
  String message = "";
  Future<void> getAddressWithIData(int id) async {
    try {
      showDialog(
        context: NavigationService.context,
        builder: (context) => loadingIndicatorCircle(context: context),
      );
      Map allData = await api.getAddressWithId(id);
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
