import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shanbwrog/Settings/MySettings.dart';
import 'package:shanbwrog/ui/screens/account/notifications.dart';
import 'package:shanbwrog/ui/screens/main/reservationInfo.dart';
import 'package:shanbwrog/ui/screens/main/searchFragment.dart';
import 'package:shanbwrog/ui/serviceprovider/reservationFragment.dart';
import 'package:shanbwrog/ui/serviceprovider/serviceProviderMainFragment.dart';

import 'mainFragment.dart';
import 'myAccount.dart';
import 'myFavourite.dart';
import 'myreservations.dart';

class MainActivity extends StatefulWidget {
  final String usertype;

  MainActivity(this.usertype);

  @override
  _MainActivityState createState() => _MainActivityState();
}

class _MainActivityState extends State<MainActivity> {
  List<Widget> getfragment(Size devicesize, int currentindex) {
    return [
      widget.usertype == 'provider'
          ? ServiceProviderMainFragment()
          : MainFragment(),
      SearchFragment(),
      widget.usertype == 'provider'
          ? ServiceProviderReservationFragment()
          : MyReservations(),
      MyFavourite(),
      MyAccount(),
    ];
  }

  List<PreferredSizeWidget> getAppbar(int currentindex) {
    return [
      AppBar(
        backgroundColor: Colors.white10,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'شنب و روج',
          style: TextStyle(
              color: MySettings.secondarycolor,
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                  return Notifications();
                }));
              },
              icon: Icon(
                Icons.notifications,
                color: Colors.black,
                size: 24,
              ))
        ],
      ),
      AppBar(
        backgroundColor: Colors.white24,
        elevation: 0,
      ),
      AppBar(
        backgroundColor: Colors.white24,
        elevation: 0,
      ),
      AppBar(
        backgroundColor: Colors.white24,
        elevation: 0,
      ),
      AppBar(
        backgroundColor: Colors.white24,
        elevation: 0,
      ),
      AppBar(
        backgroundColor: Colors.white24,
        elevation: 0,
      ),
    ];
  }

  int currentindex = 0;

  @override
  Widget build(BuildContext context) {
    final devicesize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: getAppbar(currentindex)[currentindex],
      body: getfragment(devicesize, currentindex)[currentindex],
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize:
            EasyLocalization.of(context)!.currentLocale!.languageCode == 'ar'
                ? 19
                : 17,
        unselectedFontSize:
            EasyLocalization.of(context)!.currentLocale!.languageCode == 'ar'
                ? 19
                : 17,
        selectedLabelStyle: TextStyle(color: MySettings.maincolor),
        unselectedLabelStyle: TextStyle(color: MySettings.maincolor),
        selectedItemColor: MySettings.maincolor,
        unselectedItemColor: Colors.black12.withOpacity(.2),
        iconSize: 25,
        currentIndex: currentindex,
        onTap: (int newindex) {
          setState(() {
            currentindex = newindex;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          /*    BottomNavigationBarItem(
              icon: Icon(Icons.offline_bolt_sharp),
              label: translator.translate('offers')),*/
          BottomNavigationBarItem(
              icon: currentindex == 0
                  ? Image.asset('assets/icons/homes.png')
                  : Image.asset('assets/icons/home.png'),
              label: tr('home')),
          BottomNavigationBarItem(
              icon: currentindex == 1
                  ? Image.asset('assets/icons/searchs.png')
                  : Image.asset('assets/icons/search.png'),
              label: tr('search')),
          BottomNavigationBarItem(
              icon: currentindex == 2
                  ? Image.asset('assets/icons/reservs.png')
                  : Image.asset('assets/icons/reserv.png'),
              label: tr('resrvs')),
          BottomNavigationBarItem(
              icon: currentindex == 3
                  ? Image.asset('assets/icons/hearts.png')
                  : Image.asset('assets/icons/heart.png'),
              label: tr('favourite')),
          BottomNavigationBarItem(
              icon: currentindex == 4
                  ? Image.asset('assets/icons/accounts.png')
                  : Image.asset('assets/icons/account.png'),
              label: tr('myaccount')),
        ],
      ),
    );
  }
}
