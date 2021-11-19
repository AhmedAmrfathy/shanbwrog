import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shanbwrog/Settings/MySettings.dart';
import 'package:shanbwrog/providers/Auth.dart';
import 'package:shanbwrog/providers/profile.dart';
import 'package:shanbwrog/ui/general/appbar.dart';
import 'package:shanbwrog/ui/widgets/my_loading_widget.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  void initState() {
    if (Provider.of<AuthProvider>(context, listen: false).userModel.token ==
            null ||
        Provider.of<AuthProvider>(context, listen: false).userModel.token ==
            '') {
    } else {
      Future.delayed(Duration(milliseconds: 0), () {
        Provider.of<ProfileProvider>(context, listen: false).getNotifications(
          context,
          EasyLocalization.of(context)!.currentLocale!.languageCode,
        );
      });
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final devicesize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(body: Consumer<ProfileProvider>(
        builder: (ctx, data, ch) {
          return data.LoadingNotificationError != null
              ? Center(
                  child: Text(data.LoadingNotificationError!),
                )
              : data.isLoadingNotifications
                  ? myLoadingWidget(context, MySettings.maincolor)
                  : Padding(
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
                            data.notifications.length == 0
                                ? Center(
                                    child: Text(tr('emptylist')),
                                  )
                                : ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: data.notifications.length,
                                    padding: EdgeInsets.all(20),
                                    itemBuilder: (ctx, index) {
                                      return Container(
                                        width: devicesize.width * .9,
                                        padding: EdgeInsets.all(15),
                                        margin:
                                            EdgeInsets.symmetric(vertical: 8),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black12),
                                            color: MySettings.lightgrey,
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: Text(
                                          data.notifications[index].content,
                                          style: TextStyle(
                                              color: data.notifications[index]
                                                          .isActive ==
                                                      '1'
                                                  ? Colors.black
                                                  : Colors.black26),
                                        ),
                                      );
                                    })
                          ],
                        ),
                      ),
                    );
        },
      )),
    );
  }
}
