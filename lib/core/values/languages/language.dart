import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'from/en-US.dart';
part 'from/fa-IR.dart';

class Languages extends Translations {
  static final RxBool _isPersian = true.obs;

  static bool get isPersian => _isPersian.value;

  static const localizationsDelegates = [
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  static const supportedLocales = [
    Locale('fa', 'IR'),
    Locale('en', 'US'),
  ];

  void changeLanguage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _isPersian.value = !_isPersian.value;
    Get.updateLocale(
      _isPersian.value ? const Locale('fa', 'IR') : const Locale('en', 'US'),
    );
    await prefs.setBool('isPersian', isPersian);
  }

  void getLanguageStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('isPersian')) {
      await prefs.setBool('isPersian', isPersian);
    }
    _isPersian.value = prefs.getBool('isPersian') as bool;
    Get.updateLocale(
      _isPersian.value ? const Locale('fa', 'IR') : const Locale('en', 'US'),
    );
  }

  static String translateDate() {
    final Jalali jdate = Jalali.now();
    final Gregorian mdate = Gregorian.now();
    if (_isPersian.value) {
      return '${dayIR[jdate.weekDay]} ${jdate.day} ${monthIR[jdate.month]}';
    } else {
      return '${dayEN[mdate.weekDay]} ${mdate.day} ${monthEN[mdate.month]}';
    }
  }

  @override
  Map<String, Map<String, String>> get keys => {
        'fa_IR': faIR,
        'en_US': enUS,
      };
}
