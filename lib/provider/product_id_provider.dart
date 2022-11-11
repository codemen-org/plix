import 'package:flutter/material.dart';

class ProductIdProvider extends ChangeNotifier {
  String _id = '';
  String get id => _id;
  changeId(String id) {
    _id = id;
    notifyListeners();
  }
}

class ProductPriceProvider extends ChangeNotifier {
  double _price = 0.0;
  double get price => _price;
  changePrice(double price) {
    _price = price;
    notifyListeners();
  }
}
