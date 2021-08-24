import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';
import 'package:shanbwrog/Settings/MySettings.dart';
import 'package:shanbwrog/models/basic.dart';
import 'package:shanbwrog/providers/Auth.dart';
import 'package:shanbwrog/ui/screens/loginScreen.dart';
import 'package:shanbwrog/ui/screens/main/mainActivity.dart';
import 'package:shanbwrog/ui/widgets/customButton.dart';
import 'package:shanbwrog/ui/widgets/formitem.dart';

class RegisterAsProvider extends StatefulWidget {
  final bool? isnormaluser;
  final String? usertype;

  RegisterAsProvider(this.usertype, {this.isnormaluser = false});

  @override
  _RegisterAsProviderState createState() => _RegisterAsProviderState();
}

class _RegisterAsProviderState extends State<RegisterAsProvider> {
  TextEditingController _email = TextEditingController();
  TextEditingController _commercialRegisterationNo = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _username = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _passwordconfirm = TextEditingController();
  TextEditingController _from = TextEditingController();
  TextEditingController _to = TextEditingController();

  bool _showpassword = false;
  bool _showpasswordconfirm = false;

  @override
  Widget build(BuildContext context) {
    final devicesize = MediaQuery.of(context).size;
    final authlistener = Provider.of<AuthProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: SizedBox(
              width: devicesize.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icons/login.png',
                    fit: BoxFit.fill,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: devicesize.width * .84,
                    padding: EdgeInsets.all(18),
                    decoration: BoxDecoration(
                        color: MySettings.lightgrey,
                        borderRadius: BorderRadius.circular(50)),
                    child: Column(
                      children: [
                        Text(
                          tr('service'),
                          style: TextStyle(color: Colors.black, fontSize: 24),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          widget.isnormaluser != null &&
                                  widget.isnormaluser == true
                              ? tr('normaluser')
                              : tr('providerinfo'),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: MySettings.secondarycolor, fontSize: 22),
                        ),
                        SizedBox(
                          height: 28,
                        ),
                        FormItemWidget(
                          fill: true,
                          fillingcolor: Colors.white,
                          bordercolor: Colors.grey,
                          enablingborder: true,
                          borderRadious: 12,
                          label: tr('username'),
                          labelStyle:
                              TextStyle(color: Colors.grey, fontSize: 19),
                          textEditingController: _username,
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
                          labelStyle:
                              TextStyle(color: Colors.grey, fontSize: 19),
                          textEditingController: _email,
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        InternationalPhoneNumberInput(
                          inputDecoration: InputDecoration(
                              labelText: tr('phonenumber'),
                              labelStyle:
                                  TextStyle(color: Colors.grey, fontSize: 17),
                              filled: true,
                              fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.black26)),
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: MySettings.lightgrey),
                                  borderRadius: BorderRadius.circular(12))),
                          onInputChanged: (PhoneNumber number) {
                            print(number.phoneNumber);
                          },
                          locale: EasyLocalization.of(context)!
                              .currentLocale!
                              .languageCode,
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
                          width: devicesize.width * .8,
                          child: DropdownButtonFormField(
                              hint: Text(
                                tr('country'),
                                style: TextStyle(color: Colors.grey),
                              ),
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 19),
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
                                      borderSide: BorderSide(
                                          color: Colors.grey.withOpacity(.8)),
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
                                tr('city'),
                                style: TextStyle(color: Colors.grey),
                              ),
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 19),
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
                                      borderSide: BorderSide(
                                          color: Colors.grey.withOpacity(.8)),
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
                        if (widget.isnormaluser != null &&
                            widget.isnormaluser == false)
                          Column(
                            children: [
                              SizedBox(
                                height: 18,
                              ),
                              FormItemWidget(
                                fill: true,
                                fillingcolor: Colors.white,
                                bordercolor: Colors.grey,
                                enablingborder: true,
                                borderRadious: 12,
                                label: tr('address'),
                                labelStyle:
                                    TextStyle(color: Colors.grey, fontSize: 19),
                                suffixicon: Icon(
                                  Icons.location_on_sharp,
                                  color: MySettings.maincolor,
                                ),
                                textEditingController: _address,
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
                                label: tr('CommercialRegistrationNo'),
                                labelStyle:
                                    TextStyle(color: Colors.grey, fontSize: 19),
                                textEditingController:
                                    _commercialRegisterationNo,
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
                                label: tr('services'),
                                labelStyle:
                                    TextStyle(color: Colors.grey, fontSize: 19),
                              ),
                              SizedBox(
                                height: 18,
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: 130,
                                    height: 80,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey.withOpacity(.5)),
                                        borderRadius: BorderRadius.circular(12),
                                        color: Colors.white),
                                    child: Padding(
                                      padding: EdgeInsets.all(15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(tr('from')),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Flexible(
                                              child: TextFormField(
                                            controller: _from,
                                          ))
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 40,
                                  ),
                                  Container(
                                    width: 130,
                                    height: 80,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey.withOpacity(.5)),
                                        borderRadius: BorderRadius.circular(12),
                                        color: Colors.white),
                                    child: Padding(
                                      padding: EdgeInsets.all(15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(tr('to')),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Flexible(
                                              child: TextFormField(
                                            controller: _to,
                                          ))
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
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
                                label: tr('image'),
                                labelStyle:
                                    TextStyle(color: Colors.grey, fontSize: 19),
                                textEditingController: _password,
                                suffixicon: IconButton(
                                  icon: Icon(Icons.image),
                                  color: MySettings.maincolor,
                                  onPressed: () {},
                                ),
                              ),
                              SizedBox(
                                height: 18,
                              ),
                              Container(
                                width: devicesize.width * .8,
                                child: DropdownButtonFormField(
                                    hint: Text(
                                      tr('period'),
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 19),
                                    decoration: InputDecoration(
                                        contentPadding: devicesize.width < 768
                                            ? EdgeInsets.all(15)
                                            : EdgeInsets.all(24),
                                        filled: true,
                                        fillColor: Colors.white,
                                        errorBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.red),
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey
                                                    .withOpacity(.8)),
                                            borderRadius:
                                                BorderRadius.circular(12))),
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
                            ],
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
                          hidepassword: _showpassword ? false : true,
                          label: tr('password'),
                          labelStyle:
                              TextStyle(color: Colors.grey, fontSize: 19),
                          textEditingController: _password,
                          suffixicon: IconButton(
                            icon: Icon(Icons.remove_red_eye),
                            color: Colors.grey,
                            onPressed: () {
                              setState(() {
                                _showpassword = !_showpassword;
                              });
                            },
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
                          hidepassword: _showpasswordconfirm ? false : true,
                          label: tr('passwordconfirm'),
                          labelStyle:
                              TextStyle(color: Colors.grey, fontSize: 19),
                          textEditingController: _passwordconfirm,
                          suffixicon: IconButton(
                            icon: Icon(Icons.remove_red_eye),
                            color: Colors.grey,
                            onPressed: () {
                              setState(() {
                                _showpasswordconfirm = !_showpasswordconfirm;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        CustomButton(tr('register'), () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                            return MainActivity(usertype: widget.usertype,);
                          }));
                        }
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              tr('haveaccount'),
                              style:
                                  TextStyle(color: Colors.black, fontSize: 17),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (ctx) {
                                  return LoginScreen();
                                }));
                              },
                              child: Text(
                                tr('login'),
                                style: TextStyle(
                                    color: MySettings.secondarycolor,
                                    fontSize: 17),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
