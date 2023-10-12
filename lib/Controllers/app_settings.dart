import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettingsController with ChangeNotifier {
  int _tabIndex = 2;
  bool _isDark = false;
  bool get isDark {
    return _isDark;
  }

  int _previewTime = 30;
  int get previewTime {
    return _previewTime;
  }

  countDownTimerPreview() async {
    Future.delayed(const Duration(seconds: 1)).then((value) {
      if (_previewTime == 0) {
        _previewTime = 30;
      } else {
        _previewTime--;
      }
    });
  }

  bool _displayRoutePath = false;
  bool get displayRoutePath {
    return _displayRoutePath;
  }

  changeDisplayRoutePath(bool value) {
    _displayRoutePath = value;
    notifyListeners();
  }

  bool _enableGps = false;
  bool get enableGps {
    return _enableGps;
  }

  changeGps(bool value) {
    _enableGps = value;
    notifyListeners();
  }

  changeTheme(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDark', value);

    _isDark = value;
    notifyListeners();
  }

  Future<bool> checkTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool pref = prefs.getBool('isDark') ?? false;
    _isDark = pref;
    notifyListeners();
    return pref;
  }

  int get tabIndex {
    return _tabIndex;
  }

  changeTabIndex(int index) {
    _tabIndex = index;
    notifyListeners();
  }
}
