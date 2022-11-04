import 'package:rxdart/rxdart.dart';
import 'api.dart';

class GetSliderRX {
  final api = GetSliderApi();
  late Map empty;
  final BehaviorSubject _dataFetcher = BehaviorSubject<Map>();

  ValueStream get getSliderData => _dataFetcher.stream;

  Future<void> fetchSlider() async {
    try {
      Map data = await api.getSlider();
      _dataFetcher.sink.add(data);
    } catch (e) {
      // print(e);
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
