import 'package:rxdart/rxdart.dart';
import 'api.dart';

class GetShopItemRX {
  final api = GetItemApi();
  late Map empty;
  final BehaviorSubject _dataFetcher = BehaviorSubject<Map>();

  ValueStream get getItemData => _dataFetcher.stream;

  Future<void> fetchShopItemData() async {
    try {
      Map data = await api.fetchItemList();
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
