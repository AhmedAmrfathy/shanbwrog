import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shanbwrog/Settings/MySettings.dart';

class RadioWidget extends StatelessWidget {
  final bool isnormalUser;
  final bool categoryType;
  final String text;
  final String imagepass;
  final Function ontap;

  RadioWidget(this.isnormalUser, this.categoryType, this.text, this.imagepass,
      this.ontap);

  @override
  Widget build(BuildContext context) {
    final devicesize = MediaQuery.of(context).size;
    return Container(
      width: devicesize.width * .8,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color:
                  isnormalUser ? MySettings.maincolor : MySettings.lightgrey)),
      child: Row(
        children: [
          Image.asset(
            imagepass,
          ),
          SizedBox(
            width: 12,
          ),
          Text(
            text,
            style: TextStyle(
                color: MySettings.maincolor,
                fontSize: 19,
                fontWeight: FontWeight.bold),
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              ontap();
            },
            child: Image.asset(
              categoryType
                  ? ''
                  : isnormalUser
                      ? 'assets/icons/selectedRadio.png'
                      : 'assets/icons/unselectedRadio.png',
              width: 24,
              height: 24,
              fit: BoxFit.fill,
            ),
          )
        ],
      ),
    );
  }
}
