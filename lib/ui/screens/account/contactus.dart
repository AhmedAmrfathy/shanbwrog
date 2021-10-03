import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';
import 'package:shanbwrog/Settings/MySettings.dart';
import 'package:shanbwrog/models/basic.dart';
import 'package:shanbwrog/providers/Auth.dart';
import 'package:shanbwrog/ui/general/appbar.dart';
import 'package:shanbwrog/ui/widgets/customButton.dart';
import 'package:shanbwrog/ui/widgets/formitem.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  TextEditingController _username = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _message = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final devicesize = MediaQuery.of(context).size;
    final authlistener = Provider.of<AuthProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formkey,
          child: ListView(
            padding: EdgeInsets.all(25),
            children: [
              NewAppbar(
                devicesize: devicesize,
                text: tr('callus'),
              ),
              SizedBox(
                height: 20,
              ),
              FormItemWidget(
                  fill: true,
                  fillingcolor: Colors.white,
                  bordercolor: Colors.grey,
                  enablingborder: true,
                  borderRadious: 12,
                  label: tr('username'),
                  labelStyle: TextStyle(color: Colors.grey, fontSize: 19),
                  textEditingController: _username,
                  validation: (String? value) {
                    if (value == null || value.isEmpty) {
                      return tr('requiredfield');
                    }
                  }),
              SizedBox(
                height: 18,
              ),
              Container(
                width: devicesize.width * .8,
                child: DropdownButtonFormField(
                    hint: Text(
                      tr('determinereason'),
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
                                  child: Text(item.id.toString()),
                                  value: item,
                                ))
                        .toList(),
                    onChanged: (Basic? basic) {},
                    validator: (value) {
                      if (value == null) {
                        return tr('requiredfield');
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
                  label: tr('email'),
                  labelStyle: TextStyle(color: Colors.grey, fontSize: 19),
                  textEditingController: _email,
                  validation: (String? value) {
                    String pattern =
                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                    RegExp regex = new RegExp(pattern);
                    if (value == null || value.isEmpty) {
                      return tr('requiredfield');
                    } else if (!regex.hasMatch(value)) {
                      return tr("emailvalidate");
                    }
                  }),
              SizedBox(
                height: 18,
              ),
              InternationalPhoneNumberInput(
                validator: (number) {
                  if (number == null || number.length == 0) {
                    return tr('requiredfield');
                  }
                },
                inputDecoration: InputDecoration(
                    labelText: tr('phonenumber'),
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 17),
                    filled: true,
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black26)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: MySettings.lightgrey),
                        borderRadius: BorderRadius.circular(12))),
                onInputChanged: (PhoneNumber number) {
                  print(number.phoneNumber);
                },
                locale:
                    EasyLocalization.of(context)!.currentLocale!.languageCode,
                onInputValidated: (bool value) {
                  print(value);
                },
                selectorConfig: SelectorConfig(
                  selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                ),
                ignoreBlank: false,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                selectorTextStyle: TextStyle(color: Colors.black),
                textFieldController: _phone,
                formatInput: false,
                keyboardType: TextInputType.numberWithOptions(
                    signed: true, decimal: true),
                onSaved: (PhoneNumber number) {
                  print('On Saved: $number');
                },
              ),
              SizedBox(
                height: 18,
              ),
              Container(
                width: devicesize.width * .85,
                height: 180,
                child: TextFormField(
                  controller: _message,
                  validator: (value) {
                    if (value == null || value.length == 0) {
                      return tr('requiredfield');
                    }
                  },
                  textAlignVertical: TextAlignVertical.top,
                  expands: true,
                  maxLines: null,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF4A4A4A),
                  ),
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      isDense: true,
                      hintText: tr('message'),
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 17),
                      filled: true,
                      // contentPadding: EdgeInsets.symmetric(vertical: 50),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black38),
                          borderRadius: BorderRadius.circular(5))),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              CustomButton(tr('send'), () {
                if(_formkey.currentState!.validate()){
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
