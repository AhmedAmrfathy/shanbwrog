import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:shanbwrog/Settings/MySettings.dart';
import 'package:shanbwrog/providers/Auth.dart';
import 'package:shanbwrog/providers/home.dart';
import 'package:shanbwrog/ui/screens/loginScreen.dart';
import 'package:shanbwrog/ui/screens/resetpassword/resetNewPassword.dart';
import 'package:shanbwrog/ui/screens/resetpassword/resetPasswordMail.dart';
import 'package:shanbwrog/ui/screens/spashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
        supportedLocales: [Locale('en', 'US'), Locale('ar')],
        path: 'assets/languages',
        startLocale: Locale('ar'),
        // <-- change the path of the translation files
        child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => HomeProvider(),
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        debugShowCheckedModeBanner: false,
        locale: context.locale,
        builder: (context, widget) => ResponsiveWrapper.builder(
          widget,
          maxWidth: 1200,
          minWidth: 480,
          defaultScale: true,
          breakpoints: [
            ResponsiveBreakpoint.resize(480, name: MOBILE),
            ResponsiveBreakpoint.autoScale(800, name: TABLET),
            ResponsiveBreakpoint.resize(1000, name: DESKTOP),
          ],
          background: Container(color: Color(0xFFF5F5F5)),
        ),
        initialRoute: SplashScreen.ref,
        routes: {
          MyHomePage.ref: (ctx) => MyHomePage(),
          SplashScreen.ref: (ctx) => SplashScreen(),
          LoginScreen.ref: (ctx) => LoginScreen(),
          ResetPasswordMail.ref: (ctx) => ResetPasswordMail(),
          ResetNewPassword.ref: (ctx) => ResetNewPassword()
        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  static const String ref = 'homeref';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            width: 200,
            height: 50,
            color: Colors.green,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  tr('first'),
                  style: TextStyle(fontSize: 28),
                ),
                SizedBox(
                  width: 30,
                ),
                Text(
                  tr('first'),
                  style: TextStyle(fontSize: 19),
                ),
                SizedBox(
                  width: 30,
                ),
                GestureDetector(
                  onTap: () {
                    MySettings.changeLang(Locale('ar'), context);
                  },
                  child: Text(tr('last'), style: TextStyle(fontSize: 15)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
