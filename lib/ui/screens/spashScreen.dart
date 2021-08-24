import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shanbwrog/Settings/MySettings.dart';

import 'loginScreen.dart';

class SplashScreen extends StatefulWidget {
  static const String ref = 'splashref';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  // _navigatToNextScreen() {
  //   Provider.of<AuthProvider>(context, listen: false)
  //       .autoAuthenticate()
  //       .then((value) {
  //     if (value) {
  //       Get.offAll(HiddenAnimation());
  //     } else {
  //       Get.offAll(SelectLanguageScreen());
  //     }
  //   });
  // }

  // AnimationController controller;
  // Animation animation;
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => LoginScreen()));
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/images/splashbc.png',
                ),
                fit: BoxFit.fill)),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Swing(
                duration: Duration(seconds: 2),
                child: SizedBox(
                  child: Image.asset(
                    'assets/icons/splashicon.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(
                height: 7,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
