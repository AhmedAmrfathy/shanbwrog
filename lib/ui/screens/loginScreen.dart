import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shanbwrog/Settings/MySettings.dart';
import 'package:shanbwrog/ui/screens/main/mainActivity.dart';
import 'package:shanbwrog/ui/screens/register/registerAsProvider.dart';
import 'package:shanbwrog/ui/screens/register/registerSelectUserType.dart';
import 'package:shanbwrog/ui/screens/resetpassword/resetNewPassword.dart';
import 'package:shanbwrog/ui/screens/resetpassword/resetPasswordCode.dart';
import 'package:shanbwrog/ui/screens/resetpassword/resetPasswordMail.dart';
import 'package:shanbwrog/ui/widgets/customButton.dart';
import 'package:shanbwrog/ui/widgets/formitem.dart';

class LoginScreen extends StatefulWidget {
  static const String ref = 'loginref';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool _showpassword = false;

  @override
  Widget build(BuildContext context) {
    final devicesize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: SizedBox(
              width: devicesize.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icons/login.png',
                    fit: BoxFit.fill,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: devicesize.width * .84,
                    padding: EdgeInsets.all(18),
                    decoration: BoxDecoration(
                        color: MySettings.lightgrey,
                        borderRadius: BorderRadius.circular(50)),
                    child: Column(
                      children: [
                        Text(
                          tr('welcomeback'),
                          style: TextStyle(color: Colors.black, fontSize: 24),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          tr('joinus'),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: MySettings.secondarycolor, fontSize: 22),
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
                          labelStyle:
                              TextStyle(color: Colors.grey, fontSize: 19),
                          textEditingController: _email,
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        FormItemWidget(
                          fill: true,
                          fillingcolor: Colors.white,
                          bordercolor: Colors.grey,
                          enablingborder: true,
                          borderRadious: 12,
                          hidepassword: _showpassword ? false : true,
                          label: tr('password'),
                          labelStyle:
                              TextStyle(color: Colors.grey, fontSize: 19),
                          textEditingController: _password,
                          suffixicon: IconButton(
                            icon: Icon(Icons.remove_red_eye),
                            color: Colors.grey,
                            onPressed: () {
                              setState(() {
                                _showpassword = !_showpassword;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (ctx) => ResetPasswordMail()));
                                },
                                child: Text(
                                  tr('forgetpassword'),
                                  style: TextStyle(
                                      color: MySettings.secondarycolor,
                                      fontSize: 17),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomButton(tr('login'), () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => MainActivity(
                                    usertype: 'oo',
                                  )));
                        }),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              tr('donothaveac'),
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) =>
                                        RegisterSelectUserType()));
                              },
                              child: Text(
                                tr('register'),
                                style: TextStyle(
                                    color: MySettings.maincolor, fontSize: 20),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
