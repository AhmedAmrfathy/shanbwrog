import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class NewAppbar extends StatelessWidget {
  final Size devicesize;
  final String text;
  final bool allowBack;

  NewAppbar({required this.devicesize, required this.text,this.allowBack=true});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: devicesize.width,
      height: 40,
      padding: EdgeInsets.only(right: 30,left: 30),
      child: Row(
        children: [
          Text(
            text,
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
          ),
          Spacer(),
          allowBack?
          IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.black,
                size: 30,
              )):Container(),
        ],
      ),
    );
  }
}
