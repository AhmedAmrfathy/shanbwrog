import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shanbwrog/Settings/MySettings.dart';
import 'package:shanbwrog/ui/general/appbar.dart';

class TermsConditions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final devicesize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NewAppbar(
                devicesize: devicesize,
                text: tr('condition'),
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                tr('termsforapp'),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: MySettings.secondarycolor,
                    fontSize: 19,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'هذا النص التجريبى هو مثال فقد لما يمكن كتابته ف هذا المربع هذا النص التجريبى هو مثال فقد لما يمكن كتابته ف هذا المربع هذا النص التجريبى هو مثال فقد لما يمكن كتابته ف هذا المربع هذا النص التجريبى هو مثال فقد لما يمكن كتابته ف هذا المربع',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
      ),
    );
  }
}
