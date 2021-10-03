import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shanbwrog/Settings/MySettings.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function ontap;

  CustomButton(this.text, this.ontap);

  @override
  Widget build(BuildContext context) {
    final devicesize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        ontap();
      },
      child: Container(
        width: devicesize.width * .8,
        height: 70,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [MySettings.maincolor, MySettings.secondarycolor])),
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 22),
          ),
        ),
      ),
    );
  }
}
