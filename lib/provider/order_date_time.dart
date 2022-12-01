import 'package:flutter/material.dart';

import '../features/cart/model/dateslot.dart';

class DateTimeProvider extends ChangeNotifier {
  String _selectedDate = "";
  DateSlot? _selectedSlot;

  String get selectedDate => _selectedDate;
  DateSlot? get selectedSlot => _selectedSlot;

  changTimeSlot(String date, DateSlot seleSlot) async {
    _selectedDate = date;
    _selectedSlot = seleSlot;
    notifyListeners();
  }
}
