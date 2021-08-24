import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shanbwrog/Settings/MySettings.dart';
import 'package:shanbwrog/ui/general/appbar.dart';

class SearchFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final devicesize = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            NewAppbar(
              devicesize: devicesize,
              text: tr('search'),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              width: devicesize.width * .9,
              padding: EdgeInsets.only(top: 8, right: 8,left: 10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                  color: MySettings.lightgrey,
                  borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  Flexible(
                      child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: tr('searchwhatyouwant'),
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 17)),
                  )),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Image.asset(
                        'assets/icons/search.png',
                        color: MySettings.secondarycolor,
                      ))
                ],
              ),
            ),
            SizedBox(
              height: devicesize.height * .3,
            ),
            Center(
              child: Text(
                'نتائج البحث',
                style: TextStyle(color: Colors.grey, fontSize: 19),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
