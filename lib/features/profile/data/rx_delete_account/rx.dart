import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'package:rxdart/rxdart.dart';

import '../../../../constants/app_constants.dart';
import '../../../../helpers/all_routes.dart';
import '../../../../helpers/navigation_service.dart';
import '../../../../helpers/notification_service.dart';
import '../../../../networks/api_acess.dart';
import '../../../../widgets/loading_indicators.dart';
import 'api.dart';

class DeleteAccountRX {
  final api = DeleteAccountApi();
  final storage = GetStorage();
  Map empty = {};
  final BehaviorSubject _dataFetcher = BehaviorSubject<Map>();
  ValueStream get getDeleteAccountRes => _dataFetcher.stream;
  String message = "";
  Future<void> deleteAccountData() async {
    try {
      showDialog(
        context: NavigationService.context,
        builder: (context) => loadingIndicatorCircle(context: context),
      );
      Map allData = await api.deleteAccount();
      message = allData["message"];
      _dataFetcher.sink.add(allData);
      storage.write(kKeyIsLoggedIn, false);
      storage.erase();
      LocalNotificationService.removeToken();
      deleteTokenRxObj.deleteTokenData();
      NavigationService.goBack;
      NavigationService.navigateTo(Routes.loadingScreen);
    } catch (e) {
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
