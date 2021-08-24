import 'package:connectivity/connectivity.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

class MySettings {
  static Future<bool> netWorkWorking() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }

  static void changeLang(Locale locale, BuildContext context) {
    EasyLocalization.of(context)!.setLocale(locale);
  }

  static const Color maincolor = Color.fromRGBO(151, 48, 41, 1);
  static const Color secondarycolor = Color.fromRGBO(179, 37, 101, 1);
  static const Color lightgrey = Color.fromRGBO(243, 246, 250, 1);
  static const Color lightblue = Color.fromRGBO(98, 125, 236, 1);
  static const Color lightpink = Color.fromRGBO(248, 232, 240, 1);



}
