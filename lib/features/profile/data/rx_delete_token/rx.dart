import 'package:get_storage/get_storage.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../constants/app_constants.dart';
import '../../../../helpers/navigation_service.dart';
import 'api.dart';

class DeleteTokenRx {
  final api = DeleteTokenApi();
  Map empty = {};
  final BehaviorSubject _dataFetcher = BehaviorSubject<Map>();

  ValueStream get getTokenDeletedata => _dataFetcher.stream;

  Future<void> deleteTokenData() async {
    final storage = GetStorage();
    String userId = storage.read(kKeyUserID);
    String deviceId = storage.read(kKeyDeviceID);
    try {
      Map data = {"user_id": userId, "device_id": deviceId};
      Map resData = await api.deleteToken(data);
      _dataFetcher.sink.add(resData);
      NavigationService.goBack;
    } catch (e) {
      _dataFetcher.sink.addError(e);
    }
  }

  void clean() {
    _dataFetcher.sink.add(empty);
  }

  void dispose() {
    _dataFetcher.close();
  }
}
