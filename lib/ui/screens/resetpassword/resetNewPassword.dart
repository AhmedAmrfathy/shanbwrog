import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shanbwrog/Settings/MySettings.dart';
import 'package:shanbwrog/ui/widgets/customButton.dart';
import 'package:shanbwrog/ui/widgets/formitem.dart';

class ResetNewPassword extends StatefulWidget {
  static const String ref = 'resetnewpassref';

  @override
  _ResetNewPasswordState createState() => _ResetNewPasswordState();
}

class _ResetNewPasswordState extends State<ResetNewPassword> {
  TextEditingController _pass = TextEditingController();
  TextEditingController _passconfirm = TextEditingController();

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
            'assets/images/successreset.png',
            width: 150,
            height: 150,
            fit: BoxFit.fill,
          ),
          SizedBox(
            height: 28,
          ),
          Padding(padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              tr('successvalidate'),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
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
            hidepassword: true,
            label: tr('password'),
            labelStyle: TextStyle(color: Colors.grey, fontSize: 19),
            textEditingController: _pass,
            suffixicon: IconButton(
              icon: Icon(Icons.remove_red_eye),
              color: Colors.grey,
              onPressed: () {},
            ),
          ),
          SizedBox(
            height: 20,
          ),
          FormItemWidget(
            fill: true,
            fillingcolor: Colors.white,
            bordercolor: Colors.grey,
            enablingborder: true,
            borderRadious: 12,
            hidepassword: true,
            label: tr('passconfirm'),
            labelStyle: TextStyle(color: Colors.grey, fontSize: 19),
            textEditingController: _passconfirm,
            suffixicon: IconButton(
              icon: Icon(Icons.remove_red_eye),
              color: Colors.grey,
              onPressed: () {},
            ),
          ),
          SizedBox(
            height: 28,
          ),
          CustomButton(tr('confirm'), () {})
        ],
      ),
    );
  }
}
