import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shanbwrog/ui/general/appbar.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final devicesize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              NewAppbar(
                devicesize: devicesize,
                text: tr('infoaboutus'),
              ),
              SizedBox(
                height: 15,
              ),
              Image.asset(
                'assets/icons/login.png',
                fit: BoxFit.fill,
                width: 170,
                height: 150,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'هذا النص هو مثال فقد هذا النص هو مثال فقد هذا النص هو مثال فقد هذا النص هو مثال فقد هذا النص هو مثال فقد',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
      ),
    );
  }
}
