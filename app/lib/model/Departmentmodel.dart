import 'package:flutter/material.dart';

class DepartmentModel extends ChangeNotifier {
  int? _selectedDepartmentIndex = 0;

  int? get selectedDepartmentIndex => _selectedDepartmentIndex;

  set selectedDepartmentIndex(int? value) {
    _selectedDepartmentIndex = value;
    notifyListeners();
  }
}
