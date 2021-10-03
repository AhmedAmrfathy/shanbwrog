import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class ExplainItem extends StatelessWidget {
  final String text;

  ExplainItem(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * .1),
          Text(text),
          SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}
