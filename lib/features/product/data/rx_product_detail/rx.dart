// import 'dart:io';

// import 'package:contesta_na_hora/helpers/navigation_service.dart';
// import 'package:contesta_na_hora/widgets/loading_indicators.dart';
// import 'package:flutter/material.dart';
// import 'package:rxdart/rxdart.dart';
// import '../../helpers/all_routes.dart';
// import '../../helpers/navigation_service.dart';
// import '../../screens/contestar_submit_screen.dart';
// import 'api.dart';

import 'package:flutter/material.dart';
import 'package:plix/widgets/loading_indicators.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../helpers/navigation_service.dart';
import 'api.dart';

class GetProductDetailRX {
  final api = GetProductDetailApi();
  Map empty = {};
  final BehaviorSubject _dataFetcher = BehaviorSubject<Map>();

  ValueStream get getProductDetailData => _dataFetcher.stream;

  Future<void> fetchProductDetail(String slug) async {
    try {
      showDialog(
        context: NavigationService.context,
        builder: (context) => loadingIndicatorCircle(context: context),
      );
      Map data = await api.getProductDetail(slug);
      _dataFetcher.sink.add(data);
      NavigationService.goBack;
    } catch (e) {
      _dataFetcher.sink.addError(e);
      NavigationService.goBack;
    }
  }

  void clean() {
    _dataFetcher.sink.add(empty);
  }

  void dispose() {
    _dataFetcher.close();
  }
}
