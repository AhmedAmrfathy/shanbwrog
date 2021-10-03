import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shanbwrog/Settings/MySettings.dart';
import 'package:shanbwrog/providers/Auth.dart';
import 'package:shanbwrog/ui/screens/loginScreen.dart';
import 'package:shanbwrog/ui/widgets/customButton.dart';
import 'package:shanbwrog/ui/widgets/formitem.dart';
import 'package:shanbwrog/ui/widgets/myToast.dart';
import 'package:shanbwrog/ui/widgets/my_loading_widget.dart';

class ResetNewPassword extends StatefulWidget {
  final String ? phone;

  ResetNewPassword({this.phone});

  static const String ref = 'resetnewpassref';

  @override
  _ResetNewPasswordState createState() => _ResetNewPasswordState();
}

class _ResetNewPasswordState extends State<ResetNewPassword> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController _pass = TextEditingController();
  TextEditingController _passconfirm = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final devicesize = MediaQuery.of(context).size;
    final authprovider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      body: Form(
        key: _formkey,
        child: Column(
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
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
              validation: (String? value) {
                if (value == null || value.isEmpty) {
                  return tr('requiredfield');
                }
              },
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
              validation: (String? value) {
                if (value == null || value.isEmpty) {
                  return tr('requiredfield');
                } else if (value! != _pass.text) {
                  return tr('passwordval2');
                }
              },
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
            Consumer<AuthProvider>(
              builder: (ctx, data, ch) {
                return data.isloadingChangePassword
                    ? myLoadingWidget(context, MySettings.maincolor)
                    : CustomButton(tr('confirm'), () async {
                        if (_formkey.currentState!.validate()) {
                          final result = await authprovider.changePassword(
                              context,
                              EasyLocalization.of(context)!
                                  .currentLocale!
                                  .languageCode,
                              widget.phone!,
                              _pass.text,
                              _passconfirm.text);
                          if (result['status'] == true) {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (ctx) => LoginScreen()),
                                (route) => false);
                          } else {
                            showMyToast(context, result['error'], 'error');
                          }
                        }
                      });
              },
            )
          ],
        ),
      ),
    );
  }
}
