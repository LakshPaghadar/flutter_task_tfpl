import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../../locator/locator.dart';
import 'app_db.dart';

///const local to use in multiple screen
const englishLocal = 'en';
const arabicLocal = 'ar';
const japaneseLocal = 'ja';

class AppLanguage extends ChangeNotifier {
  Locale _appLocale = const Locale('en');

  Locale get appLocal => _appLocale;

  Future<void> changeLanguage(Locale type) async {
    if (_appLocale == type) {
      return;
    }

    _appLocale = type;
    debugPrint('changeLanguage en ${type == const Locale('en')}');
    debugPrint('AppLang = $_appLocale');
    notifyListeners();
  }

  Future<void> fetchLocale() async {
    final String defaultLocale = Platform.localeName;

    debugPrint('Default Language----->$defaultLocale');

    var languageCode = appDB.appLanguage;

    debugPrint('Default Language----->$languageCode');
    //debugPrint('App Db local ----->${appDB.appLanguage}');

    switch (languageCode) {
      case englishLocal:
        _appLocale = const Locale(englishLocal);
        break;
      case arabicLocal:
        _appLocale = const Locale(arabicLocal);
        break;
      case japaneseLocal:
        _appLocale = const Locale(japaneseLocal);
        break;
      default:
        _appLocale = const Locale(englishLocal);
        break;
    }
    debugPrint('AppLang = $_appLocale');
    notifyListeners();
  }
}

var appLanguage = locator<AppLanguage>();
