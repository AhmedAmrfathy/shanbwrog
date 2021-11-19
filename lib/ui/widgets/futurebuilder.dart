import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shanbwrog/Settings/MySettings.dart';

import 'emptyitem.dart';
import 'my_loading_widget.dart';

class ApiFutureBuilder extends StatelessWidget {
  final Future future;
  final Widget consumer;

  ApiFutureBuilder({required this.future, required this.consumer});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: future,
        builder: (ctx, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.connectionState == ConnectionState.none) {
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
              return consumer!;
            }
          } else {
            return Container();
          }
        });
  }
}
