import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shanbwrog/Settings/MySettings.dart';
import 'package:shanbwrog/models/basic.dart';
import 'package:shanbwrog/providers/Auth.dart';
import 'package:shanbwrog/ui/general/appbar.dart';
import 'package:shanbwrog/ui/widgets/customButton.dart';
import 'package:shanbwrog/ui/widgets/formitem.dart';

class AddOffer extends StatelessWidget {
  TextEditingController offeraddress = TextEditingController();
  TextEditingController offerdetails = TextEditingController();
  TextEditingController offerimage = TextEditingController();
  TextEditingController offerpriceafter = TextEditingController();
  TextEditingController offerpricebefore = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final devicesize = MediaQuery.of(context).size;
    final authlistener = Provider.of<AuthProvider>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              NewAppbar(
                devicesize: devicesize,
                text: tr('addoffer'),
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
              Container(
                width: devicesize.width * .8,
                child: DropdownButtonFormField(
                    hint: Text(
                      tr('service'),
                      style: TextStyle(color: Colors.grey),
                    ),
                    style: TextStyle(color: Colors.grey, fontSize: 19),
                    decoration: InputDecoration(
                        contentPadding: devicesize.width < 768
                            ? EdgeInsets.all(15)
                            : EdgeInsets.all(24),
                        filled: true,
                        fillColor: Colors.white,
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(12)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey.withOpacity(.8)),
                            borderRadius: BorderRadius.circular(12))),
                    value: authlistener.selected,
                    items: authlistener.countries
                        .map<DropdownMenuItem<Basic>>(
                            (item) => DropdownMenuItem(
                                  child: Text(item.name!),
                                  value: item,
                                ))
                        .toList(),
                    onChanged: (Basic? basic) {},
                    validator: (value) {
                      if (value == null) {
                        return 'qqqq';
                      }
                    }),
              ),
              SizedBox(
                height: 18,
              ),
              Container(
                width: devicesize.width * .8,
                child: DropdownButtonFormField(
                    hint: Text(
                      tr('category'),
                      style: TextStyle(color: Colors.grey),
                    ),
                    style: TextStyle(color: Colors.grey, fontSize: 19),
                    decoration: InputDecoration(
                        contentPadding: devicesize.width < 768
                            ? EdgeInsets.all(15)
                            : EdgeInsets.all(24),
                        filled: true,
                        fillColor: Colors.white,
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(12)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey.withOpacity(.8)),
                            borderRadius: BorderRadius.circular(12))),
                    value: authlistener.selected,
                    items: authlistener.countries
                        .map<DropdownMenuItem<Basic>>(
                            (item) => DropdownMenuItem(
                                  child: Text(item.name!),
                                  value: item,
                                ))
                        .toList(),
                    onChanged: (Basic? basic) {},
                    validator: (value) {
                      if (value == null) {
                        return 'qqqq';
                      }
                    }),
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
              CustomButton(tr('add'), () {})
            ],
          ),
        ),
      ),
    );
  }
}
