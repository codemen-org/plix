import 'package:plix/features/categories/data/rx_categories/api.dart';
import 'package:rxdart/rxdart.dart';

class GetShopCategoriRX {
  final api = GetCategoriesApi();
  late Map empty;
  final BehaviorSubject _dataFetcher = BehaviorSubject<Map>();

  ValueStream get getCategoryData => _dataFetcher.stream;

  Future<void> fetchShopCategoryData() async {
    try {
      Map data = await api.fetchCategoriesList();
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
