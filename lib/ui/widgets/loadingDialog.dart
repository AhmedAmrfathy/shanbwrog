import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  final Color? backgroundColor;
  final String message;

  LoadingDialog(this.message, {this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: backgroundColor,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(6)),
        padding: EdgeInsets.all(15),
        child: Row(
          children: [
            SizedBox(
              width: 6,
            ),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black87),
            ),
            SizedBox(
              width: 26,
            ),
            Text(
              message,
              style: TextStyle(color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
