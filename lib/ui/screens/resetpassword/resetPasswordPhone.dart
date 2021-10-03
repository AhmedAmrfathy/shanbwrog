import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:shanbwrog/Settings/MySettings.dart';
import 'package:shanbwrog/ui/screens/resetpassword/resetPasswordCode.dart';
import 'package:shanbwrog/ui/widgets/customButton.dart';
import 'package:shanbwrog/ui/widgets/formitem.dart';

class ResetPasswordPhone extends StatefulWidget {
  static const String ref = 'resetphoneref';

  @override
  _ResetPasswordPhoneState createState() => _ResetPasswordPhoneState();
}

class _ResetPasswordPhoneState extends State<ResetPasswordPhone> {
  TextEditingController _phone = TextEditingController();

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
            tr('enterphone'),
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontSize: 22),
          ),
          SizedBox(
            height: 28,
          ),
          InternationalPhoneNumberInput(
            errorMessage: tr('phonevalidate'),
            countries: ['SA'],
            inputDecoration: InputDecoration(
                labelText: tr('phonenumber'),
                labelStyle: TextStyle(color: Colors.grey, fontSize: 17),
                filled: true,
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black26)),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: MySettings.lightgrey),
                    borderRadius: BorderRadius.circular(12))),
            onInputChanged: (PhoneNumber number) {
              print(number.phoneNumber);
            },
            locale: EasyLocalization.of(context)!.currentLocale!.languageCode,
            onInputValidated: (bool value) {
              print(value);
            },
            selectorConfig: SelectorConfig(
              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
            ),
            ignoreBlank: false,
            autoValidateMode: AutovalidateMode.onUserInteraction,
            selectorTextStyle: TextStyle(color: Colors.black),
            textFieldController: _phone,
            formatInput: false,
            keyboardType:
                TextInputType.numberWithOptions(signed: true, decimal: true),
            onSaved: (PhoneNumber number) {
              print('On Saved: $number');
            },
          ),
          SizedBox(
            height: 28,
          ),
          CustomButton(tr('send'), () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (ctx) => ResetPasswordCode()));
          })
        ],
      ),
    );
  }
}
