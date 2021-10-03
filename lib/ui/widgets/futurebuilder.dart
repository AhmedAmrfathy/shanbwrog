import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';
import 'package:tabebcom/general/mysettings.dart';
import 'package:tabebcom/providers/doctors.dart';

import 'emptyitem.dart';
import 'helper_widgets/my_loading_widget.dart';

class ApiFutureBuilder extends StatelessWidget {
  final Future future;
  final Widget consumer;

  ApiFutureBuilder({this.future, this.consumer});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: future,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Material(
              child: Padding(
                padding: EdgeInsets.only(top: 50),
                child: Center(
                  child: myLoadingWidget(context, MySettings.maincolor),
                ),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data['status'] == false) {
              return Center(
                child: ExplainItem(snapshot.data['error']),
              );
            } else {
              return consumer;
            }
          }
        });
  }
}
