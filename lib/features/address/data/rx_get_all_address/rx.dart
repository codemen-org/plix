import 'package:get_storage/get_storage.dart';

import 'package:rxdart/rxdart.dart';

import 'api.dart';

class GetAddressRX {
  final api = GetAddressApi();
  final storage = GetStorage();
  Map empty = {};
  final BehaviorSubject _dataFetcher = BehaviorSubject<Map>();
  ValueStream get getCartDataRes => _dataFetcher.stream;
  String message = "";
  Future<void> getAddressData() async {
    try {
      // showDialog(
      //   context: NavigationService.context,
      //   builder: (context) => loadingIndicatorCircle(context: context),
      // );
      Map allData = await api.getAddress();
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
