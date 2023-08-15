import 'package:flutter/material.dart';

class DepartmentProvider extends ChangeNotifier {
  int _selectedItemIndex = -1;

  int get selectedItemIndex => _selectedItemIndex;

  void setSelectedItemIndex(int index) {
    _selectedItemIndex = index;
    notifyListeners();
  }
}
