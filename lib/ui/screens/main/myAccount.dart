import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shanbwrog/Settings/MySettings.dart';
import 'package:shanbwrog/providers/Auth.dart';
import 'package:shanbwrog/providers/profile.dart';
import 'package:shanbwrog/ui/general/appbar.dart';
import 'package:shanbwrog/ui/screens/account/aboutUs.dart';
import 'package:shanbwrog/ui/screens/account/contactus.dart';
import 'package:shanbwrog/ui/screens/account/language.dart';
import 'package:shanbwrog/ui/screens/account/notifications.dart';
import 'package:shanbwrog/ui/screens/account/privacypolicy.dart';
import 'package:shanbwrog/ui/screens/account/profile.dart';
import 'package:shanbwrog/ui/screens/account/terms.dart';
import 'package:shanbwrog/ui/widgets/my_loading_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../loginScreen.dart';

class MyAccount extends StatefulWidget {
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  String? name;
  String? email;
  String? image;
  bool? local;

  Future<bool> getData() async {
    try {
      Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
      final SharedPreferences pref = await _prefs;
      final String? usertoken = pref.getString('token');
      if (usertoken != null) {
        name = pref.getString('name');
        email = pref.getString('email');
        image = pref.getString('image');
        local = pref.getBool('local');
        return true;
      } else {
        print('فى حاجه متخزنه ب null فى اللوجن');
        return false;
      }
    } catch (err) {
      print('فى حاجه متخزنه ب null فى اللوجن');
      return false;
    }
  }

  @override
  void initState() {
    //  getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final devicesize = MediaQuery.of(context).size;
    return   SafeArea(
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          children: [
            NewAppbar(
              devicesize: devicesize,
              text: tr('myaccount'),
              allowBack: false,
            ),
            SizedBox(
              height: 20,
            ),
            FutureBuilder(
              builder: (ctx, snapshotdata) {
                if (snapshotdata.connectionState == ConnectionState.waiting) {
                  return myLoadingWidget(context, MySettings.maincolor);
                } else {
                  return Row(
                    children: [
                      Provider.of<AuthProvider>(context, listen: false)
                                      .userModel
                                      .token ==
                                  null ||
                              Provider.of<AuthProvider>(context, listen: false)
                                      .userModel
                                      .token ==
                                  ''
                          ? Container()
                          : Container(
                              width: 110,
                              height: 110,
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: MySettings.secondarycolor),
                                  shape: BoxShape.circle),
                              child: CircleAvatar(
                                backgroundImage: local == true
                                    ? FileImage(File(image!)) as ImageProvider
                                    : NetworkImage(image!),
                              ),
                            ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Provider.of<AuthProvider>(context, listen: false)
                                          .userModel
                                          .token ==
                                      null ||
                                  Provider.of<AuthProvider>(context,
                                              listen: false)
                                          .userModel
                                          .token ==
                                      ''
                              ? Container()
                              : Text(
                                  'اهلا ' + name!,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                          SizedBox(
                            height: 3,
                          ),
                          Provider.of<AuthProvider>(context, listen: false)
                                          .userModel
                                          .token ==
                                      null ||
                                  Provider.of<AuthProvider>(context,
                                              listen: false)
                                          .userModel
                                          .token ==
                                      ''
                              ? Container()
                              : Text(
                                  email!,
                                  style:
                                      TextStyle(fontSize: 16, color: Colors.grey),
                                ),
                          SizedBox(
                            height: 15,
                          ),
                          InkWell(
                            onTap: () async {
                              if (Provider.of<AuthProvider>(context,
                                              listen: false)
                                          .userModel
                                          .token ==
                                      null ||
                                  Provider.of<AuthProvider>(context,
                                              listen: false)
                                          .userModel
                                          .token ==
                                      '') {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (ctx) => LoginScreen()),
                                    (route) => false);
                              } else {
                                await Provider.of<AuthProvider>(context,
                                        listen: false)
                                    .logOut()
                                    .then((value) {
                                  if (value) {
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (ctx) => LoginScreen()),
                                        (route) => false);
                                  }
                                });
                              }
                            },
                            child: Text(
                              Provider.of<AuthProvider>(context, listen: false)
                                              .userModel
                                              .token ==
                                          null ||
                                      Provider.of<AuthProvider>(context,
                                                  listen: false)
                                              .userModel
                                              .token ==
                                          ''
                                  ? tr('login')
                                  : tr('logout'),
                              style: TextStyle(
                                  color: MySettings.secondarycolor,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }
              },
              future: getData(),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: devicesize.width * .8,
              padding: EdgeInsets.only(top: 8, right: 8),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                  color: MySettings.lightgrey,
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  Provider.of<AuthProvider>(context, listen: false)
                                  .userModel
                                  .token ==
                              null ||
                          Provider.of<AuthProvider>(context, listen: false)
                                  .userModel
                                  .token ==
                              ''
                      ? Container()
                      : AccountItem(
                          icon: Icon(
                            Icons.person,
                            color: MySettings.secondarycolor,
                            size: 24,
                          ),
                          text: tr('accountsettings'),
                          ontap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => ProfileScreen()));
                          },
                        ),
                  SizedBox(
                    height: 5,
                  ),
                  AccountItem(
                    icon: Icon(Icons.language),
                    text: tr('language'),
                    ontap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (ctx) => ChangeLanguage()));
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  AccountItem(
                    icon: Icon(
                      Icons.info_outline,
                      color: MySettings.secondarycolor,
                      size: 24,
                    ),
                    ontap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (ctx) => AboutUs()));
                    },
                    text: tr('infoaboutus'),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  AccountItem(
                    icon: Icon(
                      Icons.privacy_tip_outlined,
                      size: 24,
                    ),
                    ontap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (ctx) => PrivacyPolicy()));
                    },
                    text: tr('privacy'),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  AccountItem(
                    icon: Icon(
                      Icons.notifications_active_outlined,
                      size: 24,
                      color: MySettings.secondarycolor,
                    ),
                    text: tr('notifications'),
                    ontap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (ctx) => Notifications()));
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  AccountItem(
                    icon: Icon(
                      Icons.filter,
                      size: 24,
                    ),
                    text: tr('condition'),
                    ontap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (ctx) => TermsConditions()));
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Provider.of<AuthProvider>(context, listen: false)
                                  .userModel
                                  .token ==
                              null ||
                          Provider.of<AuthProvider>(context, listen: false)
                                  .userModel
                                  .token ==
                              ''
                      ? Container()
                      : AccountItem(
                          icon: Icon(
                            Icons.add_ic_call_outlined,
                            size: 24,
                            color: MySettings.secondarycolor,
                          ),
                          text: tr('callus'),
                          ontap: () {
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (ctx) => ContactUs()));
                          }),
                  SizedBox(
                    height: 5,
                  ),
                  AccountItem(
                    icon: Icon(
                      Icons.star_rate_rounded,
                      size: 24,
                      color: Colors.yellow,
                    ),
                    text: tr('rateapp'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AccountItem extends StatelessWidget {
  final String? iconpath;
  final Icon? icon;
  final String? text;
  final Function? ontap;

  AccountItem({this.iconpath, this.text, this.ontap, this.icon});

  @override
  Widget build(BuildContext context) {
    final devicesize = MediaQuery.of(context).size;
    return Column(
      children: [
        ListTile(
          leading: icon,
          title: Text(
            text!,
            style: TextStyle(color: Colors.black, fontSize: 19),
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.black,
              size: 24,
            ),
            onPressed: () {
              ontap!();
            },
          ),
        ),
        Container(
          width: devicesize.width,
          height: .5,
          color: Colors.black26,
        )
      ],
    );
  }
}
