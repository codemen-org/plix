import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../helpers/all_routes.dart';
import '../../../../helpers/navigation_service.dart';
import '../../../../networks/api_acess.dart';
import '../../../../widgets/loading_indicators.dart';
import 'api.dart';

class PostAddressRX {
  final api = PostAddressApi();
  late Map empty;
  final BehaviorSubject _dataFetcher = BehaviorSubject<Map>();

  String message = "Something went wrong";

  ValueStream get getPostForgetEmailRes => _dataFetcher.stream;

  Future<void> postNewAdderss(
      {required String lat,
      required String long,
      required String address,
      required String country,
      required String postal_code,
      required String state,
      required String city,
      required String address_name,
      required int is_default}) async {
    try {
      showDialog(
        context: NavigationService.context,
        builder: (context) => loadingIndicatorCircle(context: context),
      );
      Map data = {
        'address_name': address_name,
        'is_default': is_default,
        'phone': '',
        'country': country,
        'state': state,
        'city': city,
        'postal_code': postal_code,
        'address': address,
        'latitude': lat,
        'longitude': long
      };

      Map resdata = await api.postSaveAppress(data);

      _dataFetcher.sink.add(resdata);

      message = resdata["message"];
      if (resdata["success"] == false) throw Exception();
      await getAddressRXObj.getAddressData();
      NavigationService.goBack;
      NavigationService.navigateToReplacement(Routes.profileScreen);
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
