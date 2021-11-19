import 'package:fcm_config/fcm_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:shanbwrog/Settings/MySettings.dart';
import 'package:shanbwrog/models/reservation.dart';
import 'package:shanbwrog/providers/Auth.dart';
import 'package:shanbwrog/providers/home.dart';
import 'package:shanbwrog/providers/profile.dart';
import 'package:shanbwrog/providers/reservations.dart';
import 'package:shanbwrog/providers/search.dart';
import 'package:shanbwrog/providers/serviceprovider/service_provider_offers.dart';
import 'package:shanbwrog/providers/serviceprovider/service_provider_reservations.dart';
import 'package:shanbwrog/providers/serviceprovider/service_provider_services.dart';
import 'package:shanbwrog/providers/settings.dart';
import 'package:shanbwrog/ui/screens/loginScreen.dart';
import 'package:shanbwrog/ui/screens/resetpassword/resetNewPassword.dart';
import 'package:shanbwrog/ui/screens/resetpassword/resetPasswordPhone.dart';
import 'package:shanbwrog/ui/screens/spashScreen.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FCMConfig.instance
      .init(onBackgroundMessage: _firebaseMessagingBackgroundHandler);
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
        ChangeNotifierProxyProvider<AuthProvider, HomeProvider>(
          create: (ctx) => HomeProvider(),
          update: (ctx, auth, home) => home!
            ..update(
                newtoken: auth.userModel == null || auth.userModel.token == null
                    ? ''
                    : auth.userModel.token),
        ),
        ChangeNotifierProxyProvider<AuthProvider, ReservationsProvider>(
          create: (ctx) => ReservationsProvider(),
          update: (ctx, auth, reservation) => reservation!
            ..update(
                newtoken: auth.userModel == null || auth.userModel.token == null
                    ? ''
                    : auth.userModel.token),
        ),
        ChangeNotifierProxyProvider<AuthProvider,
            ServiceProviderOffersProvider>(
          create: (ctx) => ServiceProviderOffersProvider(),
          update: (ctx, auth, serviceprovideroffersprovider) =>
              serviceprovideroffersprovider!
                ..update(
                    newtoken:
                        auth.userModel == null || auth.userModel.token == null
                            ? ''
                            : auth.userModel.token),
        ),
        ChangeNotifierProxyProvider<AuthProvider,
            ServiceProviderServicesProvider>(
          create: (ctx) => ServiceProviderServicesProvider(),
          update: (ctx, auth, serviceproviderServicesProvider) =>
              serviceproviderServicesProvider!
                ..update(
                    newtoken:
                        auth.userModel == null || auth.userModel.token == null
                            ? ''
                            : auth.userModel.token),
        ),
        ChangeNotifierProxyProvider<AuthProvider, ProfileProvider>(
          create: (ctx) => ProfileProvider(),
          update: (ctx, auth, profileprovider) => profileprovider!
            ..update(
                newtoken: auth.userModel == null || auth.userModel.token == null
                    ? ''
                    : auth.userModel.token),
        ),
        ChangeNotifierProxyProvider<AuthProvider,
            ServiceProviderReservationsProvider>(
          create: (ctx) => ServiceProviderReservationsProvider(),
          update: (ctx, auth, serviceProviderReservationsProvider) =>
              serviceProviderReservationsProvider!
                ..update(
                    newtoken:
                        auth.userModel == null || auth.userModel.token == null
                            ? ''
                            : auth.userModel.token),
        ),
        ChangeNotifierProxyProvider<AuthProvider, SettingsProvider>(
            create: (ctx) => SettingsProvider(),
            update: (ctx, auth, settingsprovider) => settingsprovider!
              ..update(
                  newtoken:
                      auth.userModel == null || auth.userModel.token == null
                          ? ''
                          : auth.userModel.token)),
        ChangeNotifierProxyProvider<AuthProvider, SearchProvider>(
            create: (ctx) => SearchProvider(),
            update: (ctx, auth, searchprovider) => searchprovider!
              ..update(
                  newtoken:
                      auth.userModel == null || auth.userModel.token == null
                          ? ''
                          : auth.userModel.token))
      ],
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'Cairo'),
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
          ResetPasswordPhone.ref: (ctx) => ResetPasswordPhone(),
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
