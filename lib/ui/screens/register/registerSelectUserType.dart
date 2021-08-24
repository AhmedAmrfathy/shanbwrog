import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shanbwrog/Settings/MySettings.dart';
import 'package:shanbwrog/ui/screens/register/registerSelectCategoryType.dart';
import 'package:shanbwrog/ui/screens/register/widgets/radiowidget.dart';

import '../loginScreen.dart';

class RegisterSelectUserType extends StatefulWidget {
  static const String ref = 'RegisterSelectUserTyperef';

  @override
  _RegisterSelectUserTypeState createState() => _RegisterSelectUserTypeState();
}

class _RegisterSelectUserTypeState extends State<RegisterSelectUserType> {
  bool _isnormalUser = true;

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
                          tr('register'),
                          style: TextStyle(color: Colors.black, fontSize: 24),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          tr('chooseyouraccount'),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: MySettings.secondarycolor, fontSize: 19),
                        ),
                        SizedBox(
                          height: 28,
                        ),
                        RadioWidget(_isnormalUser, false, tr('normaluser'),
                            'assets/icons/man.png', () {
                          if (_isnormalUser) {
                          } else {
                            setState(() {
                              _isnormalUser = !_isnormalUser;
                            });
                          }
                        }),
                        SizedBox(
                          height: 18,
                        ),
                        RadioWidget(
                            !_isnormalUser,
                            false,
                            tr('serviceprovider'),
                            'assets/icons/serviceprovider.png', () {
                          if (!_isnormalUser) {
                          } else {
                            setState(() {
                              _isnormalUser = !_isnormalUser;
                            });
                          }
                        }),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) =>
                                    RegisterSelectCategoryType('provider')));
                          },
                          child: Container(
                            width: devicesize.width * .8,
                            height: 70,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      MySettings.maincolor,
                                      MySettings.secondarycolor
                                    ])),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Container(
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(right: 15),
                                        child: Icon(
                                          Icons.arrow_back_ios,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        tr('next'),
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 22),
                                      ),
                                    ],
                                  ),
                                )),
                                Expanded(child: Container()),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              tr('haveaccount'),
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            GestureDetector(onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                                return LoginScreen();
                              }));
                            },
                              child: Text(
                                tr('login'),
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
