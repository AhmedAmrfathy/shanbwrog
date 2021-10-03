import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shanbwrog/Settings/MySettings.dart';
import 'package:shanbwrog/providers/Auth.dart';
import 'package:shanbwrog/ui/screens/main/mainActivity.dart';
import 'package:shanbwrog/ui/screens/register/registerAsProvider.dart';
import 'package:shanbwrog/ui/screens/register/registerSelectUserType.dart';
import 'package:shanbwrog/ui/screens/resetpassword/resetNewPassword.dart';
import 'package:shanbwrog/ui/screens/resetpassword/resetPasswordCode.dart';
import 'package:shanbwrog/ui/screens/resetpassword/resetPasswordPhone.dart';
import 'package:shanbwrog/ui/widgets/customButton.dart';
import 'package:shanbwrog/ui/widgets/formitem.dart';
import 'package:shanbwrog/ui/widgets/myToast.dart';
import 'package:shanbwrog/ui/widgets/my_loading_widget.dart';

class LoginScreen extends StatefulWidget {
  static const String ref = 'loginref';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool _showpassword = false;
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final devicesize = MediaQuery.of(context).size;
    final authprovider = Provider.of<AuthProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: SizedBox(
              width: devicesize.width,
              child: Form(
                key: _formkey,
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
                            style: TextStyle(color: Colors.black, fontSize: 22),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            tr('joinus'),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: MySettings.secondarycolor, fontSize: 19),
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
                              validation: (String? value) {
                                String pattern =
                                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                RegExp regex = new RegExp(pattern);
                                if (value == null || value.isEmpty) {
                                  return tr('requiredfield');
                                } else if (!regex.hasMatch(value)) {
                                  return tr("emailvalidate");
                                }
                              }),
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
                            validation: (String? value) {
                              if (value == null || value.isEmpty) {
                                return tr('requiredfield');
                              }
                            },
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
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (ctx) =>
                                                ResetPasswordPhone()));
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
                          Consumer<AuthProvider>(
                            builder: (ctx, data, ch) {
                              return data.isloadingLogin
                                  ? myLoadingWidget(
                                      context, MySettings.maincolor)
                                  : CustomButton(tr('login'), () async {
                                      if (_formkey.currentState!.validate()) {
                                        final result = await authprovider.login(
                                            context,
                                            EasyLocalization.of(context)!
                                                .currentLocale!
                                                .languageCode,
                                            _email.text,
                                            _password.text);
                                        if (result['status'] == true) {
                                          Navigator.of(context)
                                              .pushAndRemoveUntil(
                                                  MaterialPageRoute(
                                                      builder: (ctx) =>
                                                          MainActivity(authprovider.userModel.userType!)),
                                                  (route) => false);
                                        } else {
                                          showMyToast(context, result['error'],
                                              'error');
                                        }
                                      }
                                    });
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          GestureDetector(
                            onTap: () async {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (ctx) => MainActivity(authprovider.userModel.userType!)),
                                  (route) => false);
                            },
                            child: Text(
                              tr('loginasvisitor'),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: MySettings.secondarycolor,
                                  fontSize: 18),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                tr('donothaveac'),
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
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
                                      color: MySettings.maincolor,
                                      fontSize: 20),
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
      ),
    );
  }
}
