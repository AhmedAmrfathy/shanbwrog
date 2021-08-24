import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shanbwrog/Settings/MySettings.dart';
import 'package:shanbwrog/ui/general/appbar.dart';

class Notifications extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final devicesize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                NewAppbar(
                  devicesize: devicesize,
                  text: tr('notifications'),
                ),
                SizedBox(
                  height: 20,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 7,
                    padding: EdgeInsets.all(20),
                    itemBuilder: (ctx, index) {
                      return Container(
                        width: devicesize.width * .9,
                        padding: EdgeInsets.all(15),
                        margin: EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12),
                            color: MySettings.lightgrey,
                            borderRadius: BorderRadius.circular(12)),
                        child: Text(
                          'هذا النص هو مثال تجريبى فقد لما يمكن كتابته ف هذا المربع الخاص بالكتابه',
                          style: TextStyle(
                              color: index.isOdd ? Colors.black : Colors.black26),
                        ),
                      );
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
