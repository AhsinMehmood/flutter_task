import 'package:flutter/material.dart';

class AppSettingsController with ChangeNotifier {
  int _tabIndex = 2;
  int get tabIndex {
    return _tabIndex;
  }

  changeTabIndex(int index) {
    _tabIndex = index;
    notifyListeners();
  }
}
