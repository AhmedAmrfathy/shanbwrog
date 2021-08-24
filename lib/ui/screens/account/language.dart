import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shanbwrog/Settings/MySettings.dart';
import 'package:shanbwrog/ui/general/appbar.dart';

class ChangeLanguage extends StatefulWidget {
  @override
  _ChangeLanguageState createState() => _ChangeLanguageState();
}

class _ChangeLanguageState extends State<ChangeLanguage> {
  int? radiogroup = 1;

  @override
  Widget build(BuildContext context) {
    final devicesize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NewAppbar(
                devicesize: devicesize,
                text: tr('language'),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                tr('chooseapplang'),
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 19,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: devicesize.width * .9,
                padding: EdgeInsets.only(top: 8, right: 8),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12),
                    color: MySettings.lightgrey,
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Transform.scale(
                          scale: 1.1,
                          child: Radio(
                            activeColor: MySettings.secondarycolor,
                            value: 1,
                            groupValue: radiogroup,
                            splashRadius: 30,
                            onChanged: (int? newvalue) {
                              setState(() {
                                radiogroup = newvalue;
                              });
                              EasyLocalization.of(context)!
                                  .setLocale(Locale('ar'));
                            },
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text('اللغه العربيه',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w500))
                      ],
                    ),
                    Container(
                      width: devicesize.width,
                      height: .5,
                      color: Colors.black26,
                    ),
                    Row(
                      children: [
                        Transform.scale(
                          scale: 1.1,
                          child: Radio(
                            activeColor: MySettings.secondarycolor,
                            value: 2,
                            groupValue: radiogroup,
                            splashRadius: 30,
                            onChanged: (int? newvalue) {
                              setState(() {
                                radiogroup = newvalue;
                              });
                              EasyLocalization.of(context)!
                                  .setLocale(Locale('en', 'US'));
                            },
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text('English',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w500))
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
