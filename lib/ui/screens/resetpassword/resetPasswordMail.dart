import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shanbwrog/Settings/MySettings.dart';
import 'package:shanbwrog/ui/screens/resetpassword/resetPasswordCode.dart';
import 'package:shanbwrog/ui/widgets/customButton.dart';
import 'package:shanbwrog/ui/widgets/formitem.dart';

class ResetPasswordMail extends StatefulWidget {
  static const String ref = 'resetmailref';

  @override
  _ResetPasswordMailState createState() => _ResetPasswordMailState();
}

class _ResetPasswordMailState extends State<ResetPasswordMail> {
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
            tr('entermail'),
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontSize: 22),
          ),
          SizedBox(
            height: 28,
          ),
          FormItemWidget(
            fill: true,
            fillingcolor: Colors.white,
            bordercolor: Colors.grey,
            enablingborder: true,
            borderRadious: 12,
            label: tr('email'),
            labelStyle: TextStyle(color: Colors.grey, fontSize: 20),
            textEditingController: _email,
          ),
          SizedBox(
            height: 28,
          ),
          CustomButton(tr('send'), () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => ResetPasswordCode()));
          })
        ],
      ),
    );
  }
}
