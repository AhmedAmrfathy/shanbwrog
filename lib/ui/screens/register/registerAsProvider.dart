import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';
import 'package:shanbwrog/Settings/MySettings.dart';
import 'package:shanbwrog/models/basic.dart';
import 'package:shanbwrog/providers/Auth.dart';
import 'package:shanbwrog/ui/screens/loginScreen.dart';
import 'package:shanbwrog/ui/screens/main/mainActivity.dart';
import 'package:shanbwrog/ui/screens/map/map_screen.dart';
import 'package:shanbwrog/ui/widgets/customButton.dart';
import 'package:shanbwrog/ui/widgets/formitem.dart';
import 'package:shanbwrog/ui/widgets/futurebuilder.dart';
import 'package:shanbwrog/ui/widgets/myToast.dart';
import 'package:shanbwrog/ui/widgets/my_loading_widget.dart';

class RegisterAsProvider extends StatefulWidget {
  final bool? isnormaluser;
  final bool? isshanb;
  final String? usertype;

  RegisterAsProvider(this.usertype, this.isshanb, {this.isnormaluser = false});

  @override
  _RegisterAsProviderState createState() => _RegisterAsProviderState();
}

class _RegisterAsProviderState extends State<RegisterAsProvider> {
  Future<Map<String, dynamic>> getDataMethod() async {
    final result = await Provider.of<AuthProvider>(context, listen: false)
        .getCountries(
            context, EasyLocalization.of(context)!.currentLocale!.languageCode);
    return result;
  }

  TextEditingController _email = TextEditingController();
  TextEditingController _commercialRegisterationNo = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _username = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _passwordconfirm = TextEditingController();
  TextEditingController _from = TextEditingController();
  TextEditingController _to = TextEditingController();
  TextEditingController _imagecontroller = TextEditingController();
  TextEditingController _imagecontroller2 = TextEditingController();
  TextEditingController _imagecontroller3 = TextEditingController();
  TextEditingController _imagecontroller4 = TextEditingController();
  String userLat = '';
  String userLng = '';

  File? _image;

  File? _imag2;

  File? _imag3;

  File? _imag4;
  final picker = ImagePicker();
  bool _showpassword = false;
  bool _showpasswordconfirm = false;
  final _formkey = GlobalKey<FormState>();
  double heightFrom = 80;
  double heightTo = 80;

  // Future getImage(Function? updateState) async {
  //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  //   updateState!(() {
  //     _image = File(pickedFile!.path);
  //     _imagecontroller.text = _image!.path;
  //     print(_image!.path);
  //   });
  // }
  Future getImage(Function? updateState, TextEditingController controller,
      int imgNum) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    updateState!(() {
      if (imgNum == 1) {
        _image = File(pickedFile!.path);
      } else if (imgNum == 2) {
        _imag2 = File(pickedFile!.path);
      } else if (imgNum == 3) {
        _imag3 = File(pickedFile!.path);
      } else if (imgNum == 4) {
        _imag4 = File(pickedFile!.path);
      }
      controller.text = _image!.path;
      print(_image!.path);
    });
  }

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 3), () {
      getDataMethod();
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final devicesize = MediaQuery.of(context).size;
    final authlistener = Provider.of<AuthProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(body: Consumer<AuthProvider>(
        builder: (ctx, data, ch) {
          return data.isloadingCountries
              ? myLoadingWidget(context, MySettings.maincolor)
              : data.getcountiesError != null
                  ? Center(
                      child: Text(data.getcountiesError!),
                    )
                  : Padding(
                      padding: EdgeInsets.all(15),
                      child: SingleChildScrollView(
                        child: SizedBox(
                          width: devicesize.width,
                          child: Form(
                            key: _formkey,
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
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 24),
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
                                            color: MySettings.secondarycolor,
                                            fontSize: 22),
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
                                          keyboardtype: TextInputType.name,
                                          labelStyle: TextStyle(
                                              color: Colors.grey, fontSize: 19),
                                          textEditingController: _username,
                                          validation: (String? value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return tr('requiredfield');
                                            }
                                          }),
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
                                          labelStyle: TextStyle(
                                              color: Colors.grey, fontSize: 19),
                                          textEditingController: _email,
                                          validation: (String? value) {
                                            String pattern =
                                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                            RegExp regex = new RegExp(pattern);
                                            if (value == null ||
                                                value.isEmpty) {
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
                                          if (number == null ||
                                              number.length == 0) {
                                            return tr('requiredfield');
                                          }
                                        },
                                        errorMessage: tr('phonevalidate'),
                                        countries: ['SA'],
                                        inputDecoration: InputDecoration(
                                            labelText: tr('phonenumber'),
                                            labelStyle: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 17),
                                            filled: true,
                                            fillColor: Colors.white,
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black26)),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color:
                                                        MySettings.lightgrey),
                                                borderRadius:
                                                    BorderRadius.circular(12))),
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
                                          selectorType: PhoneInputSelectorType
                                              .BOTTOM_SHEET,
                                        ),
                                        ignoreBlank: false,
                                        autoValidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        selectorTextStyle:
                                            TextStyle(color: Colors.black),
                                        textFieldController: _phone,
                                        formatInput: false,
                                        keyboardType:
                                            TextInputType.numberWithOptions(
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
                                            isExpanded: true,
                                            hint: Text(
                                              tr('country'),
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 19),
                                            decoration: InputDecoration(
                                                contentPadding: devicesize.width < 768
                                                    ? EdgeInsets.all(15)
                                                    : EdgeInsets.all(24),
                                                filled: true,
                                                fillColor: Colors.white,
                                                errorBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.red),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.grey
                                                            .withOpacity(.8)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12))),
                                            value: authlistener.selectedCountry,
                                            items: authlistener.countries
                                                .map<DropdownMenuItem<Basic>>(
                                                    (item) => DropdownMenuItem(
                                                          child:
                                                              Text(item.name!),
                                                          value: item,
                                                        ))
                                                .toList(),
                                            onChanged: (Basic? basic) {
                                              Provider.of<AuthProvider>(context,
                                                      listen: false)
                                                  .selectedCountry = basic;
                                              Provider.of<AuthProvider>(context,
                                                      listen: false)
                                                  .getCities(context, basic!.id,
                                                      lang: EasyLocalization.of(
                                                              context)!
                                                          .currentLocale!
                                                          .languageCode);
                                            },
                                            validator: (value) {
                                              if (value == null) {
                                                return tr('requiredfield');
                                              }
                                            }),
                                      ),
                                      SizedBox(
                                        height: 18,
                                      ),
                                      Container(
                                        width: devicesize.width * .8,
                                        child: DropdownButtonFormField(
                                            isExpanded: true,
                                            hint: Text(tr('city'),
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                )),
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 19),
                                            decoration: InputDecoration(
                                                contentPadding:
                                                    devicesize.width < 768
                                                        ? EdgeInsets.all(15)
                                                        : EdgeInsets.all(24),
                                                filled: true,
                                                fillColor: Colors.white,
                                                errorBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.red),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.grey
                                                            .withOpacity(.8)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12))),
                                            value: authlistener.selectedCity,
                                            items: authlistener.cities
                                                .map<DropdownMenuItem<Basic>>(
                                                    (item) => DropdownMenuItem(
                                                          child: Text(
                                                            item.name!,
                                                            softWrap: true,
                                                          ),
                                                          value: item,
                                                        ))
                                                .toList(),
                                            onChanged: (Basic? basic) {
                                              Provider.of<AuthProvider>(context,
                                                      listen: false)
                                                  .selectedCity = basic;
                                            },
                                            validator: (value) {
                                              if (value == null) {
                                                return tr('requiredfield');
                                              }
                                            }),
                                      ),
                                      SizedBox(
                                        height: 18,
                                      ),
                                      StatefulBuilder(
                                          builder: (ctx, setNstate) {
                                        return FormItemWidget(
                                          fill: true,
                                          fillingcolor: Colors.white,
                                          readonly: true,
                                          bordercolor: Colors.grey,
                                          enablingborder: true,
                                          borderRadious: 12,
                                          label: tr('address'),
                                          labelStyle: TextStyle(
                                              color: Colors.grey, fontSize: 19),
                                          suffixicon: Icon(
                                            Icons.location_on_sharp,
                                            color: MySettings.maincolor,
                                          ),
                                          validation: (String? value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return tr('requiredfield');
                                            }
                                          },
                                          textEditingController: _address,
                                          ontap: () async {
                                            await Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (ctx) {
                                              return MapRegisteration();
                                            })).then((value) {
                                              setNstate(() {
                                                _address.text =
                                                    value['placename'];
                                                userLat =
                                                    value['lat'].toString();
                                                userLng =
                                                    value['long'].toString();
                                              });
                                            });
                                          },
                                        );
                                      }),
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
                                                label: tr(
                                                    'CommercialRegistrationNo'),
                                                labelStyle: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 19),
                                                textEditingController:
                                                    _commercialRegisterationNo,
                                                validation: (String? value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return tr('requiredfield');
                                                  }
                                                }),
                                            SizedBox(
                                              height: 18,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  tr('services'),
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 19),
                                                ),
                                                Spacer()
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            GridView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                itemCount:
                                                    data.categories.length,
                                                gridDelegate:
                                                    SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 3,
                                                  mainAxisSpacing: 10,
                                                  crossAxisSpacing: 10,
                                                ),
                                                itemBuilder: (ctx, index) {
                                                  return Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 7,
                                                            vertical: 7),
                                                    decoration: BoxDecoration(
                                                      color:
                                                          MySettings.lightpink,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Center(
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Flexible(
                                                            child: Text(
                                                              data
                                                                  .categories[
                                                                      index]
                                                                  .name!,
                                                              softWrap: true,
                                                              style: TextStyle(
                                                                  fontSize: 13),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          StatefulBuilder(
                                                              builder: (ctx,
                                                                  setnewstate) {
                                                            return Container(
                                                              height: 20,
                                                              width: 20,
                                                              child: Checkbox(
                                                                activeColor:
                                                                    Colors
                                                                        .white,
                                                                checkColor:
                                                                    MySettings
                                                                        .maincolor,
                                                                materialTapTargetSize:
                                                                    MaterialTapTargetSize
                                                                        .shrinkWrap,
                                                                value: data
                                                                    .categories[
                                                                        index]
                                                                    .checked,
                                                                onChanged: (bool?
                                                                    newselection) {
                                                                  setnewstate(
                                                                      () {
                                                                    data
                                                                        .categories[
                                                                            index]
                                                                        .checked = newselection;
                                                                  });
                                                                  if (newselection!) {
                                                                    if (data
                                                                        .selectedCategories
                                                                        .contains(data
                                                                            .categories[index]
                                                                            .id)) {
                                                                    } else {
                                                                      data.selectedCategories.add(data
                                                                          .categories[
                                                                              index]
                                                                          .id!);
                                                                    }
                                                                  } else {
                                                                    data.selectedCategories.removeWhere((element) =>
                                                                        element ==
                                                                        data.selectedCategories.contains(data
                                                                            .categories[index]
                                                                            .id));
                                                                  }
                                                                },
                                                              ),
                                                            );
                                                          }),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                }),
                                            // FormItemWidget(
                                            //     fill: true,
                                            //     fillingcolor: Colors.white,
                                            //     bordercolor: Colors.grey,
                                            //     enablingborder: true,
                                            //     borderRadious: 12,
                                            //     label: tr('services'),
                                            //     labelStyle: TextStyle(
                                            //         color: Colors.grey,
                                            //         fontSize: 19),
                                            //     validation: (String? value) {
                                            //       if (value == null ||
                                            //           value.isEmpty) {
                                            //         return tr('requiredfield');
                                            //       }
                                            //     }),
                                            SizedBox(
                                              height: 18,
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  width: 130,
                                                  height: heightFrom,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.grey
                                                              .withOpacity(.5)),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      color: Colors.white),
                                                  child: Padding(
                                                    padding: EdgeInsets.all(15),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(tr('from')),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Flexible(
                                                            child:
                                                                TextFormField(
                                                                    controller:
                                                                        _from,
                                                                    validator:
                                                                        (String?
                                                                            value) {
                                                                      if (value ==
                                                                              null ||
                                                                          value
                                                                              .isEmpty) {
                                                                        setState(
                                                                            () {
                                                                          heightFrom =
                                                                              110;
                                                                        });
                                                                        return tr(
                                                                            'requiredfield');
                                                                      } else {
                                                                        if (heightFrom ==
                                                                            80) {
                                                                        } else {
                                                                          setState(
                                                                              () {
                                                                            heightFrom =
                                                                                80;
                                                                          });
                                                                        }
                                                                      }
                                                                    }))
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 40,
                                                ),
                                                Container(
                                                  width: 130,
                                                  height: heightTo,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.grey
                                                              .withOpacity(.5)),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      color: Colors.white),
                                                  child: Padding(
                                                    padding: EdgeInsets.all(15),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(tr('to')),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Flexible(
                                                            child:
                                                                TextFormField(
                                                                    controller:
                                                                        _to,
                                                                    validator:
                                                                        (String?
                                                                            value) {
                                                                      if (value ==
                                                                              null ||
                                                                          value
                                                                              .isEmpty) {
                                                                        setState(
                                                                            () {
                                                                          heightTo =
                                                                              110;
                                                                        });
                                                                        return tr(
                                                                            'requiredfield');
                                                                      } else {
                                                                        if (heightTo ==
                                                                            80) {
                                                                        } else {
                                                                          setState(
                                                                              () {
                                                                            heightTo =
                                                                                80;
                                                                          });
                                                                        }
                                                                      }
                                                                    }))
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 18,
                                            ),
                                            // StatefulBuilder(
                                            //     builder: (ctx, setItemState) {
                                            //   return
                                            //     FormItemWidget(
                                            //       fill: true,
                                            //       fillingcolor: Colors.white,
                                            //       bordercolor: Colors.grey,
                                            //       enablingborder: true,
                                            //       borderRadious: 12,
                                            //       label: tr('image'),
                                            //       labelStyle: TextStyle(
                                            //           color: Colors.grey,
                                            //           fontSize: 19),
                                            //       textEditingController:
                                            //           _imagecontroller,
                                            //       suffixicon: IconButton(
                                            //         icon: Icon(Icons.image),
                                            //         color: MySettings.maincolor,
                                            //         onPressed: () {},
                                            //       ),
                                            //       ontap: () {
                                            //         getImage(setItemState);
                                            //       },
                                            //       validation: (String? value) {
                                            //         if (value == null ||
                                            //             value.isEmpty) {
                                            //           return tr(
                                            //               'requiredfield');
                                            //         }
                                            //       });
                                            // }),
                                            StatefulBuilder(
                                                builder: (ctx, setitemState) {
                                              return Column(
                                                children: [
                                                  FormItemWidget(
                                                      fill: true,
                                                      fillingcolor:
                                                          Colors.white,
                                                      bordercolor: Colors.grey,
                                                      enablingborder: true,
                                                      borderRadious: 12,
                                                      label: tr('image'),
                                                      readonly: true,
                                                      labelStyle: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 19),
                                                      textEditingController:
                                                          _imagecontroller,
                                                      suffixicon: IconButton(
                                                        icon: Icon(
                                                          Icons.image,
                                                          color: MySettings
                                                              .secondarycolor,
                                                        ),
                                                        onPressed: () async {
                                                          getImage(
                                                              setitemState,
                                                              _imagecontroller,
                                                              1);
                                                        },
                                                      ),
                                                      validation: (value) {
                                                        if (value == null ||
                                                            value == '') {
                                                          return tr(
                                                              'requiredfield');
                                                        }
                                                      }),
                                                  SizedBox(
                                                    height: 18,
                                                  ),
                                                  _image == null
                                                      ? Container()
                                                      : Container(
                                                          width:
                                                              devicesize.width *
                                                                  .6,
                                                          height: devicesize
                                                                  .height *
                                                              .3,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                          child: ClipRRect(
                                                              child: Image.file(
                                                            File(_image!.path),
                                                            fit: BoxFit.fill,
                                                          )),
                                                        ),
                                                ],
                                              );
                                            }),
                                            SizedBox(
                                              height: 18,
                                            ),
                                            StatefulBuilder(
                                                builder: (ctx, setitemState) {
                                              return Column(
                                                children: [
                                                  FormItemWidget(
                                                      fill: true,
                                                      fillingcolor:
                                                          Colors.white,
                                                      bordercolor: Colors.grey,
                                                      enablingborder: true,
                                                      borderRadious: 12,
                                                      label: tr('image'),
                                                      readonly: true,
                                                      labelStyle: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 19),
                                                      textEditingController:
                                                          _imagecontroller2,
                                                      suffixicon: IconButton(
                                                        icon: Icon(
                                                          Icons.image,
                                                          color: MySettings
                                                              .secondarycolor,
                                                        ),
                                                        onPressed: () async {
                                                          getImage(
                                                              setitemState,
                                                              _imagecontroller2,
                                                              2);
                                                        },
                                                      ),
                                                      validation: (value) {
                                                        if (value == null ||
                                                            value == '') {
                                                          return tr(
                                                              'requiredfield');
                                                        }
                                                      }),
                                                  SizedBox(
                                                    height: 18,
                                                  ),
                                                  _imag2 == null
                                                      ? Container()
                                                      : Container(
                                                          width:
                                                              devicesize.width *
                                                                  .6,
                                                          height: devicesize
                                                                  .height *
                                                              .3,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                          child: ClipRRect(
                                                              child: Image.file(
                                                            File(_imag2!.path),
                                                            fit: BoxFit.fill,
                                                          )),
                                                        ),
                                                ],
                                              );
                                            }),
                                            SizedBox(
                                              height: 18,
                                            ),
                                            StatefulBuilder(
                                                builder: (ctx, setitemState) {
                                              return Column(
                                                children: [
                                                  FormItemWidget(
                                                      fill: true,
                                                      fillingcolor:
                                                          Colors.white,
                                                      bordercolor: Colors.grey,
                                                      enablingborder: true,
                                                      borderRadious: 12,
                                                      label: tr('image'),
                                                      readonly: true,
                                                      labelStyle: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 19),
                                                      textEditingController:
                                                          _imagecontroller3,
                                                      suffixicon: IconButton(
                                                        icon: Icon(
                                                          Icons.image,
                                                          color: MySettings
                                                              .secondarycolor,
                                                        ),
                                                        onPressed: () async {
                                                          getImage(
                                                              setitemState,
                                                              _imagecontroller3,
                                                              3);
                                                        },
                                                      ),
                                                      validation: (value) {
                                                        if (value == null ||
                                                            value == '') {
                                                          return tr(
                                                              'requiredfield');
                                                        }
                                                      }),
                                                  SizedBox(
                                                    height: 18,
                                                  ),
                                                  _imag3 == null
                                                      ? Container()
                                                      : Container(
                                                          width:
                                                              devicesize.width *
                                                                  .6,
                                                          height: devicesize
                                                                  .height *
                                                              .3,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                          child: ClipRRect(
                                                              child: Image.file(
                                                            File(_imag3!.path),
                                                            fit: BoxFit.fill,
                                                          )),
                                                        ),
                                                ],
                                              );
                                            }),
                                            SizedBox(
                                              height: 18,
                                            ),
                                            StatefulBuilder(
                                                builder: (ctx, setitemState) {
                                              return Column(
                                                children: [
                                                  FormItemWidget(
                                                      fill: true,
                                                      fillingcolor:
                                                          Colors.white,
                                                      bordercolor: Colors.grey,
                                                      enablingborder: true,
                                                      borderRadious: 12,
                                                      label: tr('image'),
                                                      readonly: true,
                                                      labelStyle: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 19),
                                                      textEditingController:
                                                          _imagecontroller4,
                                                      suffixicon: IconButton(
                                                        icon: Icon(
                                                          Icons.image,
                                                          color: MySettings
                                                              .secondarycolor,
                                                        ),
                                                        onPressed: () async {
                                                          getImage(
                                                              setitemState,
                                                              _imagecontroller4,
                                                              4);
                                                        },
                                                      ),
                                                      validation: (value) {
                                                        if (value == null ||
                                                            value == '') {
                                                          return tr(
                                                              'requiredfield');
                                                        }
                                                      }),
                                                  SizedBox(
                                                    height: 18,
                                                  ),
                                                  _imag4 == null
                                                      ? Container()
                                                      : Container(
                                                          width:
                                                              devicesize.width *
                                                                  .6,
                                                          height: devicesize
                                                                  .height *
                                                              .3,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                          child: ClipRRect(
                                                              child: Image.file(
                                                            File(_imag4!.path),
                                                            fit: BoxFit.fill,
                                                          )),
                                                        ),
                                                ],
                                              );
                                            }),
                                            Container(
                                              width: devicesize.width * .8,
                                              child: DropdownButtonFormField(
                                                  hint: Text(
                                                    tr('period'),
                                                    style: TextStyle(
                                                        color: Colors.grey),
                                                  ),
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 19),
                                                  decoration: InputDecoration(
                                                      contentPadding: devicesize
                                                                  .width <
                                                              768
                                                          ? EdgeInsets.all(15)
                                                          : EdgeInsets.all(24),
                                                      filled: true,
                                                      fillColor: Colors.white,
                                                      errorBorder: OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .red),
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  12)),
                                                      enabledBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      .8)),
                                                          borderRadius:
                                                              BorderRadius.circular(12))),
                                                  value: authlistener.selectedPeriod,
                                                  items: authlistener.periods
                                                      .map<DropdownMenuItem<Basic>>((item) => DropdownMenuItem(
                                                            child: Text(
                                                                item.name!),
                                                            value: item,
                                                          ))
                                                      .toList(),
                                                  onChanged: (Basic? basic) {
                                                    Provider.of<AuthProvider>(
                                                            context,
                                                            listen: false)
                                                        .selectedPeriod = basic;
                                                  },
                                                  validator: (value) {
                                                    if (value == null) {
                                                      return tr(
                                                          'requiredfield');
                                                    }
                                                  }),
                                            ),
                                          ],
                                        ),
                                      SizedBox(
                                        height: 18,
                                      ),
                                      StatefulBuilder(
                                          builder: (CTX, setnewstate) {
                                        return
                                          FormItemWidget(
                                            fill: true,
                                            fillingcolor: Colors.white,
                                            bordercolor: Colors.grey,
                                            enablingborder: true,
                                            borderRadious: 12,
                                            hidepassword:
                                                _showpassword ? false : true,
                                            label: tr('password'),
                                            labelStyle: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 19),
                                            textEditingController: _password,
                                            suffixicon: IconButton(
                                              icon: Icon(Icons.remove_red_eye),
                                              color: Colors.grey,
                                              onPressed: () {
                                                setnewstate(() {
                                                  _showpassword =
                                                      !_showpassword;
                                                });
                                              },
                                            ),
                                            validation: (String? value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return tr('requiredfield');
                                              }
                                            });
                                      }),
                                      SizedBox(
                                        height: 18,
                                      ),
                                      StatefulBuilder(
                                          builder: (ctx, setnewstate) {
                                        return FormItemWidget(
                                            fill: true,
                                            fillingcolor: Colors.white,
                                            bordercolor: Colors.grey,
                                            enablingborder: true,
                                            borderRadious: 12,
                                            hidepassword: _showpasswordconfirm
                                                ? false
                                                : true,
                                            label: tr('passwordconfirm'),
                                            labelStyle: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 19),
                                            textEditingController:
                                                _passwordconfirm,
                                            suffixicon: IconButton(
                                              icon: Icon(Icons.remove_red_eye),
                                              color: Colors.grey,
                                              onPressed: () {
                                                setnewstate(() {
                                                  _showpasswordconfirm =
                                                      !_showpasswordconfirm;
                                                });
                                              },
                                            ),
                                            validation: (String? value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return tr('requiredfield');
                                              } else if (value! !=
                                                  _password.text) {
                                                return tr('passwordval2');
                                              }
                                            });
                                      }),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Consumer<AuthProvider>(
                                        builder: (ctx, data, ch) {
                                          return data.isloadingRegister
                                              ? myLoadingWidget(
                                                  context, MySettings.maincolor)
                                              : CustomButton(tr('register'),
                                                  () async {
                                                  FocusScope.of(context)
                                                      .unfocus();

                                                  if (_formkey.currentState!
                                                      .validate()) {
                                                    Map<String, dynamic>
                                                        bodyFormData = {
                                                      "name": _username.text,
                                                      "email": _email.text,
                                                      "phone": _phone.text,
                                                      "password":
                                                          _password.text,
                                                      "password_confirmation":
                                                          _passwordconfirm.text,
                                                      "city_id": Provider.of<
                                                                  AuthProvider>(
                                                              context,
                                                              listen: false)
                                                          .selectedCity!
                                                          .id,
                                                      "country_id": Provider.of<
                                                                  AuthProvider>(
                                                              context,
                                                              listen: false)
                                                          .selectedCountry!
                                                          .id,
                                                      'address': _address.text,
                                                      'lat': userLat,
                                                      'lng': userLng
                                                    };
                                                    if (widget.isnormaluser ==
                                                        false) {
                                                      bodyFormData['type'] =
                                                          widget.isshanb!
                                                              ? 2
                                                              : 1;
                                                      bodyFormData[
                                                              'categories'] =
                                                          json.encode(data
                                                              .selectedCategories);
                                                      bodyFormData[
                                                              'commercial_register'] =
                                                          _commercialRegisterationNo
                                                              .text;
                                                      bodyFormData['city_id'] =
                                                          data.selectedCity!.id;
                                                      bodyFormData[
                                                              'country_id'] =
                                                          data.selectedCountry!
                                                              .id;
                                                      bodyFormData[
                                                              'from_time'] =
                                                          _from.text;
                                                      bodyFormData['to_time'] =
                                                          _to.text;
                                                      bodyFormData[
                                                              'subscription'] =
                                                          data.selectedPeriod!
                                                              .id;
                                                      bodyFormData['images[]'] =
                                                          [
                                                        await MultipartFile
                                                            .fromFile(
                                                                _image!.path,
                                                                filename:
                                                                    'myimage.jpg'),
                                                        await MultipartFile
                                                            .fromFile(
                                                                _imag2!.path,
                                                                filename:
                                                                    'myimage.jpg'),
                                                        await MultipartFile
                                                            .fromFile(
                                                                _imag3!.path,
                                                                filename:
                                                                    'myimage.jpg'),
                                                        await MultipartFile
                                                            .fromFile(
                                                                _imag4!.path,
                                                                filename:
                                                                    'myimage.jpg')
                                                      ];
                                                    }
                                                    final response = await Provider
                                                            .of<AuthProvider>(
                                                                context,
                                                                listen: false)
                                                        .register(
                                                            formdata:
                                                                bodyFormData,
                                                            normaluser: widget
                                                                .isnormaluser!,
                                                            lang: EasyLocalization
                                                                    .of(context)!
                                                                .currentLocale!
                                                                .languageCode);
                                                    if (response['status'] ==
                                                        false) {
                                                      showMyToast(
                                                          context,
                                                          response['error'],
                                                          'error');
                                                    } else {
                                                      Navigator.of(context)
                                                          .pushAndRemoveUntil(
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (ctx) {
                                                        return MainActivity(
                                                          widget.isnormaluser!
                                                              ? 'normal'
                                                              : 'provider',
                                                        );
                                                      }),
                                                              (Route<dynamic>
                                                                      route) =>
                                                                  false);
                                                      print(
                                                          response.toString());
                                                    }

                                                    // Navigator.of(context).push(
                                                    //     MaterialPageRoute(builder: (ctx) {
                                                    //   return MainActivity(
                                                    //     usertype: widget.usertype,
                                                    //   );
                                                    // }));
                                                  }
                                                });
                                        },
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            tr('haveaccount'),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 17),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (ctx) {
                                                return LoginScreen();
                                              }));
                                            },
                                            child: Text(
                                              tr('login'),
                                              style: TextStyle(
                                                  color:
                                                      MySettings.secondarycolor,
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
                    );
        },
      )),
    );
  }
}
