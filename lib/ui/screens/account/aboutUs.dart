import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shanbwrog/Settings/MySettings.dart';
import 'package:shanbwrog/providers/settings.dart';
import 'package:shanbwrog/ui/general/appbar.dart';
import 'package:shanbwrog/ui/widgets/my_loading_widget.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 0), () {
      Provider.of<SettingsProvider>(context, listen: false).getAboutUs(
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
          return data.isloadingaboutus
              ? myLoadingWidget(context, MySettings.maincolor)
              : Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      NewAppbar(
                        devicesize: devicesize,
                        text: tr('infoaboutus'),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Image.asset(
                        'assets/icons/login.png',
                        fit: BoxFit.fill,
                        width: 170,
                        height: 150,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        data.aboutus,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
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
