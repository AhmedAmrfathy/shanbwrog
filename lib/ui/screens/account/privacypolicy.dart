import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shanbwrog/Settings/MySettings.dart';
import 'package:shanbwrog/providers/settings.dart';
import 'package:shanbwrog/ui/general/appbar.dart';
import 'package:shanbwrog/ui/widgets/my_loading_widget.dart';

class PrivacyPolicy extends StatefulWidget {
  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 0), () {
      Provider.of<SettingsProvider>(context, listen: false).getPolices(
          context, EasyLocalization.of(context)!.currentLocale!.languageCode);
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final devicesize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Consumer<SettingsProvider>(
          builder: (ctx, data, ch) {
            return data.isloadingPolces
                ? myLoadingWidget(context, MySettings.maincolor)
                : Padding(
                    padding: EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          NewAppbar(
                            devicesize: devicesize,
                            text: tr('infoaboutus'),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Text(
                            data.polices,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
