import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:async/async.dart';

Future<bool> getSharedTheme() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool theme = prefs.getBool('theme') ?? false;
  print('GetSharedThme : $theme');
  return theme;
}

Future<Null> changeShared(theme) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('theme', theme);
  print('ChangeSharedTheme : $theme');
}

class ThemeChanger with ChangeNotifier {
  ThemeData _themeData;

  Future<Null> init() async {
    _themeData =
        (await getSharedTheme() == true) ? ThemeData.dark() : ThemeData.light();
    notifyListeners();
  }

  ThemeChanger() {
    init();
  }

  getTheme() => _themeData;
  setTheme(ThemeData theme) async {
    _themeData = theme;
    await changeShared(theme == ThemeData.dark());
    notifyListeners();
  }
}
