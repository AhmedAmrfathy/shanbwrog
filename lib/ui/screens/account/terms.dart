import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shanbwrog/Settings/MySettings.dart';
import 'package:shanbwrog/providers/settings.dart';
import 'package:shanbwrog/ui/general/appbar.dart';
import 'package:shanbwrog/ui/widgets/my_loading_widget.dart';

class TermsConditions extends StatefulWidget {
  @override
  _TermsConditionsState createState() => _TermsConditionsState();
}

class _TermsConditionsState extends State<TermsConditions> {
  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 0), () {
      Provider.of<SettingsProvider>(context, listen: false).getrules(
          context, EasyLocalization.of(context)!.currentLocale!.languageCode);
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final devicesize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(body: Consumer<SettingsProvider>(
        builder: (ctx, data, ch) {
          return data.isloadingRoles
              ? myLoadingWidget(context, MySettings.maincolor)
              : Padding(
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
                        data.rules,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                );
        },
      )),
    );
  }
}
