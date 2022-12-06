import 'package:plix/features/categories/data/rx_categoryItem/api.dart';
import 'package:rxdart/rxdart.dart';

class GetProductsByCategoriesRX {
  final api = GetProductsByCategoriesApi();
  late Map empty = {};
  final BehaviorSubject _dataFetcher = BehaviorSubject<Map>();

  ValueStream get getItemByCategoryData => _dataFetcher.stream;

  Future<void> fetchItemByShopCategoryData(String slug) async {
    try {
      Map data = await api.fetchProductsByCategoriesList(slug);
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
