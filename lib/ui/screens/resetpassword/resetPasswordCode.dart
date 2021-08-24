import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shanbwrog/Settings/MySettings.dart';
import 'package:shanbwrog/ui/screens/resetpassword/resetNewPassword.dart';
import 'package:shanbwrog/ui/screens/resetpassword/resetPasswordMail.dart';
import 'package:shanbwrog/ui/widgets/customButton.dart';
import 'package:shanbwrog/ui/widgets/formitem.dart';

class ResetPasswordCode extends StatefulWidget {
  static const String ref = 'resetcoderef';

  @override
  _ResetPasswordCodeState createState() => _ResetPasswordCodeState();
}

class _ResetPasswordCodeState extends State<ResetPasswordCode> {
  StreamController<ErrorAnimationType>? errorController;
  TextEditingController? _pin;
  bool hasError = false;
  TextEditingController _email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final devicesize = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: devicesize.width,
            height: devicesize.height * .15,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: MySettings.secondarycolor,
            ),
            child: Stack(
              children: [
                Positioned(
                    bottom: 0,
                    child: Container(
                      width: devicesize.width,
                      height: 50,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Text(
                            tr('resetpassword'),
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          Spacer(),
                          IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.white,
                                size: 24,
                              ))
                        ],
                      ),
                    ))
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Image.asset(
            'assets/images/resetpass.png',
            width: 150,
            height: 160,
            fit: BoxFit.fill,
          ),
          SizedBox(
            height: 28,
          ),
          Text(
            tr('codesent'),
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontSize: 22),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Ahmed@yahoo.com',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey, fontSize: 17),
          ),
          SizedBox(
            height: 28,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: PinCodeTextField(
              appContext: context,
              textStyle: TextStyle(color: Colors.white, fontSize: 22),
              backgroundColor: Colors.transparent,
              length: 4,
              animationType: AnimationType.fade,
              pinTheme: PinTheme(
                inactiveColor: Colors.black26,
                //for border
                activeColor: MySettings.maincolor,
                //for border
                selectedColor: Colors.white,
                selectedFillColor: MySettings.maincolor,
                inactiveFillColor: MySettings.maincolor.withOpacity(.2),
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(12),
                fieldHeight: 60,
                fieldWidth: 60,
                activeFillColor:
                    hasError ? Colors.orange : MySettings.maincolor,
              ),
              animationDuration: Duration(milliseconds: 300),
              enableActiveFill: true,
              errorAnimationController: errorController,
              controller: _pin,
              onCompleted: (code) async {
                // FocusScope.of(context).unfocus();
                // if (widget.code != code) {
                //   setState(() {
                //     hasError = true;
                //   });
                //   showMyToast(
                //       context,
                //       translator.currentLanguage == 'ar'
                //           ? 'كود التفعيل غير صحيح'
                //           : 'Incorrect Code',
                //       'error');
                // } else {
                //   Get.to(LoginScreen());
                // }
              },
              onChanged: (value) {},
            ),
          ),
          SizedBox(
            height: 28,
          ),
          CustomButton(tr('send'), () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (ctx) => ResetNewPassword()));
          })
        ],
      ),
    );
  }
}
