import 'package:plix/features/categories/data/rx_categories/api.dart';
import 'package:rxdart/rxdart.dart';

import 'api.dart';

class GetProfileRX {
  final api = GetProfileApi();
  late Map empty;
  final BehaviorSubject _dataFetcher = BehaviorSubject<Map>();

  ValueStream get getProfileData => _dataFetcher.stream;

  Future<void> fetchProfileData() async {
    try {
      Map data = await api.fetchProfileData();
      _dataFetcher.sink.add(data);
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
