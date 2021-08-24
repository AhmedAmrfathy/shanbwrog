import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shanbwrog/Settings/MySettings.dart';
import 'package:shanbwrog/ui/general/appbar.dart';
import 'package:shanbwrog/ui/widgets/customButton.dart';
import 'package:shanbwrog/ui/widgets/formitem.dart';

class EditOffer extends StatelessWidget {
  TextEditingController offeraddress = TextEditingController();
  TextEditingController offerdetails = TextEditingController();
  TextEditingController offerimage = TextEditingController();
  TextEditingController offerpriceafter = TextEditingController();
  TextEditingController offerpricebefore = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final devicesize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                NewAppbar(
                  devicesize: devicesize,
                  text: tr('editoffer'),
                ),
                SizedBox(
                  height: 25,
                ),
                Image.asset(
                  'assets/images/offer.png',
                  fit: BoxFit.fill,
                ),
                SizedBox(
                  height: 25,
                ),
                FormItemWidget(
                  fill: true,
                  fillingcolor: Colors.white,
                  bordercolor: Colors.grey,
                  enablingborder: true,
                  borderRadious: 12,
                  label: tr('offeraddress'),
                  labelStyle: TextStyle(color: Colors.grey, fontSize: 19),
                  textEditingController: offeraddress,
                ),
                SizedBox(
                  height: 18,
                ),
                FormItemWidget(
                  fill: true,
                  fillingcolor: Colors.white,
                  bordercolor: Colors.grey,
                  enablingborder: true,
                  borderRadious: 12,
                  label: tr('offerdetails'),
                  labelStyle: TextStyle(color: Colors.grey, fontSize: 19),
                  textEditingController: offeraddress,
                ),
                SizedBox(
                  height: 18,
                ),
                FormItemWidget(
                  fill: true,
                  fillingcolor: Colors.white,
                  bordercolor: Colors.grey,
                  enablingborder: true,
                  borderRadious: 12,
                  label: tr('offerimage'),
                  labelStyle: TextStyle(color: Colors.grey, fontSize: 19),
                  textEditingController: offeraddress,
                  suffixicon: IconButton(
                    icon: Icon(
                      Icons.image,
                      color: MySettings.secondarycolor,
                    ),
                    onPressed: () {},
                  ),
                ),
                SizedBox(
                  height: 18,
                ),
                FormItemWidget(
                  fill: true,
                  fillingcolor: Colors.white,
                  bordercolor: Colors.grey,
                  enablingborder: true,
                  borderRadious: 12,
                  label: tr('offerpriceafter'),
                  labelStyle: TextStyle(color: Colors.grey, fontSize: 19),
                  textEditingController: offeraddress,
                ),
                SizedBox(
                  height: 18,
                ),
                FormItemWidget(
                  fill: true,
                  fillingcolor: Colors.white,
                  bordercolor: Colors.grey,
                  enablingborder: true,
                  borderRadious: 12,
                  label: tr('offerpricebefore'),
                  labelStyle: TextStyle(color: Colors.grey, fontSize: 19),
                  textEditingController: offeraddress,
                ),
                SizedBox(
                  height: 26,
                ),
                CustomButton(tr('saveedit'), () {})
              ],
            ),
          ),
        ),
      ),
    );
  }
}
