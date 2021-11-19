import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';
import 'package:shanbwrog/Settings/MySettings.dart';
import 'package:shanbwrog/models/basic.dart';
import 'package:shanbwrog/providers/Auth.dart';
import 'package:shanbwrog/providers/profile.dart';
import 'package:shanbwrog/ui/general/appbar.dart';
import 'package:shanbwrog/ui/screens/main/mainActivity.dart';
import 'package:shanbwrog/ui/screens/resetpassword/changePassword.dart';
import 'package:shanbwrog/ui/screens/resetpassword/resetNewPassword.dart';
import 'package:shanbwrog/ui/widgets/customButton.dart';
import 'package:shanbwrog/ui/widgets/formitem.dart';
import 'package:shanbwrog/ui/widgets/myToast.dart';
import 'package:shanbwrog/ui/widgets/my_loading_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController _username = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _sglnumber = TextEditingController();
  TextEditingController _from = TextEditingController();
  TextEditingController _to = TextEditingController();

  // TextEditingController offerimage2 = TextEditingController();
  //
  // TextEditingController offerimage3 = TextEditingController();
  //
  // TextEditingController offerimage4 = TextEditingController();
  String? apiImageUrl;
  File? _image;

  // File? _imag2;
  //
  // File? _imag3;
  //
  // File? _imag4;

  final picker = ImagePicker();
  List<String> newImageList = [];
  List<int> oldImageList = [];

  Future addImage() async {
    File? _newimage;
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _newimage = File(pickedFile!.path);
      return _newimage.path;
    }
    return null;
  }

  // Future getImage(Function? updateState, TextEditingController controller,
  //     int imgNum) async {
  //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  //   updateState!(() {
  //     // if (imgNum == 1) {
  //     //   _image = File(pickedFile!.path);
  //     //   newImageList.add(_image!.path);
  //     // } else if (imgNum == 2) {
  //     //   _imag2 = File(pickedFile!.path);
  //     //   newImageList.add(_imag2!.path);
  //     //   oldImageList.add(Provider.of<ProfileProvider>(context, listen: false)
  //     //       .userprofile
  //     //       .images![1]
  //     //       .id!);
  //     // } else if (imgNum == 3) {
  //     //   _imag3 = File(pickedFile!.path);
  //     //   newImageList.add(_imag3!.path);
  //     //   oldImageList.add(Provider.of<ProfileProvider>(context, listen: false)
  //     //       .userprofile
  //     //       .images![2]
  //     //       .id!);
  //     // } else if (imgNum == 4) {
  //     //   _imag4 = File(pickedFile!.path);
  //     //   newImageList.add(_imag4!.path);
  //     //   oldImageList.add(Provider.of<ProfileProvider>(context, listen: false)
  //     //       .userprofile
  //     //       .images![3]
  //     //       .id!);
  //     // }
  //     // controller.text = _image!.path;
  //     //  print(_image!.path);
  //   });
  // }

  double heightFrom = 80;
  double heightTo = 80;
  final _formkey = GlobalKey<FormState>();

  Future getMainImage(Function? updateState) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    updateState!(() {
      _image = File(pickedFile!.path);
      apiImageUrl = null;
      Provider.of<ProfileProvider>(context, listen: false).userprofile.avatar =
          null;
      try {
        oldImageList.add(Provider.of<ProfileProvider>(context, listen: false)
            .userprofile
            .images![0]
            .id!);
      } catch (error) {}

      print(_image!.path);
    });
  }

  Future saveUserDataToSharedPref(
      {String? name, String? email, String? image, bool? local}) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences pref = await _prefs;
    try {
      pref.setString('image', image!);
      pref.setString('email', email!);
      pref.setString('name', name!);
      pref.setBool('local', local!);
    } catch (error) {}
  }

  @override
  void initState() {

    Future.delayed(Duration(milliseconds: 0), () {
      Provider.of<ProfileProvider>(context, listen: false).getUserProfile(
          context,
          EasyLocalization.of(context)!.currentLocale!.languageCode,
          Provider.of<AuthProvider>(context, listen: false).userModel.id!,
          fill: fillData,
          getprofile: true);
    });

    // TODO: implement initState
    super.initState();
  }

  Future fillData() async {
    print('ppppppppppppp');
    _username.text =
        Provider.of<ProfileProvider>(context, listen: false).userprofile.name!;
    _phone.text =
        Provider.of<ProfileProvider>(context, listen: false).userprofile.phone!;
    _email.text =
        Provider.of<ProfileProvider>(context, listen: false).userprofile.email!;
    if (Provider.of<AuthProvider>(context, listen: false).userModel.userType ==
        'provider') {
      apiImageUrl = Provider.of<ProfileProvider>(context, listen: false)
          .userprofile
          .images![0]
          .img;
      _address.text = Provider.of<ProfileProvider>(context, listen: false)
          .userprofile
          .address!;
      _sglnumber.text = Provider.of<ProfileProvider>(context, listen: false)
          .userprofile
          .commercialRegister!;
      _from.text = Provider.of<ProfileProvider>(context, listen: false)
          .userprofile
          .fromTime!;
      _to.text = Provider.of<ProfileProvider>(context, listen: false)
          .userprofile
          .toTime!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final devicesize = MediaQuery.of(context).size;
    final authlistener = Provider.of<AuthProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        body: Consumer<ProfileProvider>(
          builder: (ctx, data, ch) {
            return data.isLoadingUserProfile
                ? myLoadingWidget(context, MySettings.maincolor)
                : data.getProfileError != null
                    ? Center(
                        child: Text(data.getProfileError!),
                      )
                    : Form(
                        key: _formkey,
                        child: ListView(
                          padding: EdgeInsets.symmetric(
                              horizontal: 35, vertical: 15),
                          children: [
                            NewAppbar(
                              devicesize: devicesize,
                              text: tr('profile'),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            authlistener.userModel.userType == 'provider'
                                ? Container(
                                    width: devicesize.width * .9,
                                    height: devicesize.height * .18,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                            width: 110,
                                            height: 110,
                                            padding: EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: MySettings
                                                        .secondarycolor),
                                                shape: BoxShape.circle),
                                            child: StatefulBuilder(
                                                builder: (ctx, SetNewState) {
                                              return Stack(
                                                  children: apiImageUrl != null
                                                      ? [
                                                          Align(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            50),
                                                                child: Image
                                                                    .network(
                                                                  apiImageUrl!,
                                                                  fit: BoxFit
                                                                      .fill,
                                                                  width: 100,
                                                                  height: 100,
                                                                ),
                                                              )),
                                                          // Align(
                                                          //   alignment: Alignment
                                                          //       .center,
                                                          //   child: IconButton(
                                                          //     icon: Icon(
                                                          //       Icons
                                                          //           .camera_alt_outlined,
                                                          //       color: Colors
                                                          //           .black,
                                                          //     ),
                                                          //     onPressed:
                                                          //         () async {
                                                          //       await getMainImage(
                                                          //         SetNewState,
                                                          //       );
                                                          //     },
                                                          //   ),
                                                          // )
                                                        ]
                                                      : _image != null
                                                          ? [
                                                              Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child:
                                                                      ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            50),
                                                                    child: Image
                                                                        .file(
                                                                      _image!,
                                                                      fit: BoxFit
                                                                          .fill,
                                                                      width:
                                                                          100,
                                                                      height:
                                                                          100,
                                                                    ),
                                                                  )),
                                                              // Align(
                                                              //   alignment:
                                                              //       Alignment
                                                              //           .center,
                                                              //   child:
                                                              //       IconButton(
                                                              //     icon: Icon(
                                                              //       Icons
                                                              //           .camera_alt_outlined,
                                                              //       color: Colors
                                                              //           .black,
                                                              //     ),
                                                              //     onPressed:
                                                              //         () async {
                                                              //       await getMainImage(
                                                              //           SetNewState);
                                                              //     },
                                                              //   ),
                                                              // )
                                                            ]
                                                          : []);
                                            })),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              "مدة الإشتراك",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            Text(
                                              "تم الإشتراك ف ٣ شهور",
                                              style: TextStyle(
                                                  color: MySettings.maincolor),
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Container(
                                              width: 110,
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  color: Color.fromRGBO(
                                                      39, 172, 39, 1),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              child: Center(
                                                child: Text(
                                                  'تجديد الإشتراك',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.white,
                                                      fontSize: 13),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Container(
                                              width: 110,
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  color: Color.fromRGBO(
                                                      248, 100, 100, 1),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              child: Center(
                                                child: Text(
                                                  'إنهاء الإشتراك',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.white,
                                                      fontSize: 13),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Spacer(),
                                        Container(
                                          width: 100,
                                          height: 100,
                                          padding: EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 3,
                                                  color: MySettings
                                                      .secondarycolor),
                                              shape: BoxShape.circle),
                                          child: Center(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  'باقى',
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      '26',
                                                      style: TextStyle(
                                                          color: MySettings
                                                              .maincolor,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                      width: 3,
                                                    ),
                                                    Text(
                                                      'يوم',
                                                      style: TextStyle(
                                                          color: Colors.grey),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                : Container(
                                    width: 110,
                                    height: 110,
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: MySettings.secondarycolor),
                                        shape: BoxShape.circle),
                                    child: StatefulBuilder(
                                        builder: (ctx, SetNewState) {
                                      return Stack(
                                          children: data.userprofile.avatar !=
                                                  null
                                              ? [
                                                  Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        child: Image.network(
                                                          data.userprofile
                                                              .avatar!,
                                                          fit: BoxFit.fill,
                                                          width: 100,
                                                          height: 100,
                                                        ),
                                                      )),
                                                  Align(
                                                    alignment: Alignment.center,
                                                    child: IconButton(
                                                      icon: Icon(
                                                        Icons
                                                            .camera_alt_outlined,
                                                        color: Colors.black,
                                                      ),
                                                      onPressed: () async {
                                                        await getMainImage(
                                                            SetNewState);
                                                      },
                                                    ),
                                                  )
                                                ]
                                              : _image != null
                                                  ? [
                                                      Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                            child: Image.file(
                                                              _image!,
                                                              fit: BoxFit.fill,
                                                              width: 100,
                                                              height: 100,
                                                            ),
                                                          )),
                                                      Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: IconButton(
                                                          icon: Icon(
                                                            Icons
                                                                .camera_alt_outlined,
                                                            color: Colors.black,
                                                          ),
                                                          onPressed: () async {
                                                            await getMainImage(
                                                                SetNewState);
                                                          },
                                                        ),
                                                      )
                                                    ]
                                                  : [
                                                      Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                            child: Image.asset(
                                                              'assets/images/avatar.png',
                                                              fit: BoxFit.fill,
                                                              width: 100,
                                                              height: 100,
                                                            ),
                                                          )),
                                                      Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: IconButton(
                                                          icon: Icon(
                                                            Icons
                                                                .camera_alt_outlined,
                                                            color: Colors.black,
                                                          ),
                                                          onPressed: () async {
                                                            await getMainImage(
                                                                SetNewState);
                                                          },
                                                        ),
                                                      )
                                                    ]);
                                    })),
                            SizedBox(
                              height: 60,
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
                              errorMessage: tr('phonevalidate'),
                              countries: ['SA'],
                              inputDecoration: InputDecoration(
                                  labelText: tr('phonenumber'),
                                  labelStyle: TextStyle(
                                      color: Colors.grey, fontSize: 17),
                                  filled: true,
                                  fillColor: Colors.white,
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black26)),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: MySettings.lightgrey),
                                      borderRadius: BorderRadius.circular(12))),
                              onInputChanged: (PhoneNumber number) {
                                print(number.phoneNumber);
                              },
                              locale: EasyLocalization.of(context)!
                                  .currentLocale!
                                  .languageCode,
                              selectorConfig: SelectorConfig(
                                selectorType:
                                    PhoneInputSelectorType.BOTTOM_SHEET,
                              ),
                              validator: (value) {
                                return null;
                              },
                              ignoreBlank: false,
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
                                  isExpanded: true,
                                  hint: Text(
                                    tr('country'),
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 17),
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
                                              color:
                                                  Colors.grey.withOpacity(.8)),
                                          borderRadius:
                                              BorderRadius.circular(12))),
                                  value: data.selectedCountry,
                                  items: data.countries
                                      .map<DropdownMenuItem<Basic>>(
                                          (item) => DropdownMenuItem(
                                                child: Text(item.name!),
                                                value: item,
                                              ))
                                      .toList(),
                                  onChanged: (Basic? basic) {
                                    data.selectedCountry = basic;
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
                                  hint: Text(
                                    tr('city'),
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 17),
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
                                              color:
                                                  Colors.grey.withOpacity(.8)),
                                          borderRadius:
                                              BorderRadius.circular(12))),
                                  value: data.selectedCity,
                                  items: data.cities
                                      .map<DropdownMenuItem<Basic>>(
                                          (item) => DropdownMenuItem(
                                                child: Text(item.name!),
                                                value: item,
                                              ))
                                      .toList(),
                                  onChanged: (Basic? basic) {
                                    data.selectedCity = basic;
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
                            authlistener.userModel.userType == 'provider'
                                ? SizedBox(
                                    width: devicesize.width,
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            FormItemWidget(
                                              fill: true,
                                              fillingcolor: Colors.white,
                                              bordercolor: Colors.grey,
                                              enablingborder: true,
                                              borderRadious: 12,
                                              label: tr('address'),
                                              labelStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 19),
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
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 18,
                                        ),
                                        Row(
                                          children: [
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
                                                    _sglnumber,
                                                validation: (String? value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return tr('requiredfield');
                                                  }
                                                })
                                          ],
                                        ),
                                        SizedBox(
                                          height: 18,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              width: 130,
                                              height: 100,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey
                                                          .withOpacity(.5)),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  color: Colors.white),
                                              child: Padding(
                                                padding: EdgeInsets.all(15),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(tr('from')),
                                                    SizedBox(
                                                      height: 30,
                                                    ),
                                                    Flexible(
                                                        child: TextFormField(
                                                            controller: _from,
                                                            validator: (String?
                                                                value) {
                                                              if (value ==
                                                                      null ||
                                                                  value
                                                                      .isEmpty) {
                                                                setState(() {
                                                                  heightFrom =
                                                                      110;
                                                                });
                                                                return tr(
                                                                    'requiredfield');
                                                              } else {
                                                                if (heightFrom ==
                                                                    80) {
                                                                } else {
                                                                  setState(() {
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
                                              height: 100,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey
                                                          .withOpacity(.5)),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  color: Colors.white),
                                              child: Padding(
                                                padding: EdgeInsets.all(15),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(tr('to')),
                                                    SizedBox(
                                                      height: 30,
                                                    ),
                                                    Flexible(
                                                        child: TextFormField(
                                                            controller: _to,
                                                            validator: (String?
                                                                value) {
                                                              if (value ==
                                                                      null ||
                                                                  value
                                                                      .isEmpty) {
                                                                setState(() {
                                                                  heightTo =
                                                                      110;
                                                                });
                                                                return tr(
                                                                    'requiredfield');
                                                              } else {
                                                                if (heightTo ==
                                                                    80) {
                                                                } else {
                                                                  setState(() {
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
                                          height: 17,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),

                                        StatefulBuilder(
                                            builder: (ctx, setNewState) {
                                          return Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    tr('addimage'),
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 17),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  IconButton(
                                                      onPressed: () async {
                                                        String imagepath =
                                                            await addImage();
                                                        if (imagepath != null) {
                                                          data.addImageFromProfile(
                                                              updateGridState:
                                                                  setNewState,
                                                              imagePath:
                                                                  imagepath);
                                                        }
                                                        newImageList
                                                            .add(imagepath);
                                                      },
                                                      icon: Icon(
                                                        Icons.image,
                                                        size: 24,
                                                        color: Colors.grey,
                                                      ))
                                                ],
                                              ),
                                              GridView.builder(
                                                  shrinkWrap: true,
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  itemCount: data.userprofile
                                                      .images!.length,
                                                  gridDelegate:
                                                      SliverGridDelegateWithFixedCrossAxisCount(
                                                          crossAxisCount: 2,
                                                          mainAxisSpacing: 10,
                                                          crossAxisSpacing: 10),
                                                  itemBuilder: (ctx, index) {
                                                    return Stack(
                                                      fit: StackFit.expand,
                                                      children: [
                                                        Positioned(
                                                          top: 30,
                                                          left: 10,
                                                          right: 10,
                                                          child: ClipRRect(
                                                              child: data
                                                                      .userprofile
                                                                      .images![
                                                                          index]
                                                                      .localImage!
                                                                  ? Image.file(
                                                                      File(data
                                                                          .userprofile
                                                                          .images![
                                                                              index]!
                                                                          .img!),
                                                                      fit: BoxFit
                                                                          .fill,
                                                                    )
                                                                  : Image
                                                                      .network(
                                                                      data
                                                                          .userprofile
                                                                          .images![
                                                                              index]!
                                                                          .img!,
                                                                      fit: BoxFit
                                                                          .fill,
                                                                    )),
                                                        ),
                                                        Positioned(
                                                            top: 0,
                                                            left: 0,
                                                            child: IconButton(
                                                              icon: Icon(
                                                                Icons.delete,
                                                                size: 24,
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                              onPressed:
                                                                  () async {
                                                                if (data
                                                                        .userprofile
                                                                        .images!
                                                                        .length ==
                                                                    1) {
                                                                  showMyToast(
                                                                      context,
                                                                      'لا يمكن ان تكون قائمة الصور فارغه',
                                                                      'error');
                                                                } else {
                                                                  oldImageList.add(data
                                                                      .userprofile
                                                                      .images![
                                                                          index]!
                                                                      .id!);
                                                                  data.removImageFromProfile(
                                                                      id: data
                                                                          .userprofile
                                                                          .images![
                                                                              index]
                                                                          .id,
                                                                      updateGridState:
                                                                          setNewState);
                                                                }
                                                              },
                                                            ))
                                                      ],
                                                    );
                                                  })
                                            ],
                                          );
                                        }),
                                        SizedBox(
                                          height: 15,
                                        )
                                        // StatefulBuilder(
                                        //     builder: (ctx, setitemState) {
                                        //   return Column(
                                        //     children: [
                                        //       FormItemWidget(
                                        //         fill: true,
                                        //         fillingcolor: Colors.white,
                                        //         bordercolor: Colors.grey,
                                        //         enablingborder: true,
                                        //         borderRadious: 12,
                                        //         label: tr('offerimage') + ' 2',
                                        //         labelStyle: TextStyle(
                                        //             color: Colors.grey,
                                        //             fontSize: 19),
                                        //         textEditingController:
                                        //             offerimage2,
                                        //         suffixicon: IconButton(
                                        //           icon: Icon(
                                        //             Icons.image,
                                        //             color: MySettings
                                        //                 .secondarycolor,
                                        //           ),
                                        //           onPressed: () async {
                                        //             await getImage(setitemState,
                                        //                 offerimage2, 2);
                                        //           },
                                        //         ),
                                        //       ),
                                        //       _imag2 == null &&
                                        //               data
                                        //                       .userprofile
                                        //                       .images![1]!
                                        //                       .img! ==
                                        //                   null
                                        //           ? Container()
                                        //           : SizedBox(
                                        //               height: 18,
                                        //             ),
                                        //       _imag2 == null &&
                                        //               data
                                        //                       .userprofile
                                        //                       .images![1]!
                                        //                       .img! ==
                                        //                   null
                                        //           ? Container()
                                        //           :
                                        //           Container(
                                        //               width:
                                        //                   devicesize.width * .6,
                                        //               height:
                                        //                   devicesize.height *
                                        //                       .3,
                                        //               decoration: BoxDecoration(
                                        //                 borderRadius:
                                        //                     BorderRadius
                                        //                         .circular(8),
                                        //               ),
                                        //               child: ClipRRect(
                                        //                   child: _imag2 == null
                                        //                       ?
                                        //                       Image.network(
                                        //                           data
                                        //                               .userprofile
                                        //                               .images![
                                        //                                   1]!
                                        //                               .img!,
                                        //                           fit: BoxFit
                                        //                               .fill,
                                        //                         )
                                        //                       : Image.file(
                                        //                           File(_imag2!
                                        //                               .path),
                                        //                           fit: BoxFit
                                        //                               .fill,
                                        //                         )),
                                        //             ),
                                        //     ],
                                        //   );
                                        // }),
                                        // SizedBox(
                                        //   height: 18,
                                        // ),
                                        // StatefulBuilder(
                                        //     builder: (ctx, setitemState) {
                                        //   return Column(
                                        //     children: [
                                        //       FormItemWidget(
                                        //         fill: true,
                                        //         fillingcolor: Colors.white,
                                        //         bordercolor: Colors.grey,
                                        //         enablingborder: true,
                                        //         borderRadious: 12,
                                        //         label: tr('offerimage') + ' 3',
                                        //         labelStyle: TextStyle(
                                        //             color: Colors.grey,
                                        //             fontSize: 19),
                                        //         textEditingController:
                                        //             offerimage3,
                                        //         suffixicon: IconButton(
                                        //           icon: Icon(
                                        //             Icons.image,
                                        //             color: MySettings
                                        //                 .secondarycolor,
                                        //           ),
                                        //           onPressed: () async {
                                        //             await getImage(setitemState,
                                        //                 offerimage3, 3);
                                        //           },
                                        //         ),
                                        //         // validation: (value) {
                                        //         //   if (value == null ||
                                        //         //       value == '') {
                                        //         //     return tr(
                                        //         //         'requiredfield');
                                        //         //   }
                                        //         // }
                                        //       ),
                                        //       _imag3 == null &&
                                        //               data
                                        //                       .userprofile
                                        //                       .images![2]!
                                        //                       .img! ==
                                        //                   null
                                        //           ? Container()
                                        //           : SizedBox(
                                        //               height: 18,
                                        //             ),
                                        //       _imag3 == null &&
                                        //               data
                                        //                       .userprofile
                                        //                       .images![2]!
                                        //                       .img! ==
                                        //                   null
                                        //           ? Container()
                                        //           : Container(
                                        //               width:
                                        //                   devicesize.width * .6,
                                        //               height:
                                        //                   devicesize.height *
                                        //                       .3,
                                        //               decoration: BoxDecoration(
                                        //                 borderRadius:
                                        //                     BorderRadius
                                        //                         .circular(8),
                                        //               ),
                                        //               child: ClipRRect(
                                        //                   child: _imag3 == null
                                        //                       ? Image.network(
                                        //                           data
                                        //                               .userprofile
                                        //                               .images![
                                        //                                   2]!
                                        //                               .img!,
                                        //                           fit: BoxFit
                                        //                               .fill,
                                        //                         )
                                        //                       : Image.file(
                                        //                           File(_imag3!
                                        //                               .path),
                                        //                           fit: BoxFit
                                        //                               .fill,
                                        //                         )),
                                        //             ),
                                        //     ],
                                        //   );
                                        // }),
                                        // SizedBox(
                                        //   height: 18,
                                        // ),
                                        // StatefulBuilder(
                                        //     builder: (ctx, setitemState) {
                                        //   return Column(
                                        //     children: [
                                        //       FormItemWidget(
                                        //         fill: true,
                                        //         fillingcolor: Colors.white,
                                        //         bordercolor: Colors.grey,
                                        //         enablingborder: true,
                                        //         borderRadious: 12,
                                        //         label: tr('offerimage') + ' 4',
                                        //         labelStyle: TextStyle(
                                        //             color: Colors.grey,
                                        //             fontSize: 19),
                                        //         textEditingController:
                                        //             offerimage4,
                                        //         suffixicon: IconButton(
                                        //           icon: Icon(
                                        //             Icons.image,
                                        //             color: MySettings
                                        //                 .secondarycolor,
                                        //           ),
                                        //           onPressed: () async {
                                        //             await getImage(setitemState,
                                        //                 offerimage4, 4);
                                        //           },
                                        //         ),
                                        //       ),
                                        //       _imag4 == null &&
                                        //               data
                                        //                       .userprofile
                                        //                       .images![3]!
                                        //                       .img! ==
                                        //                   null
                                        //           ? Container()
                                        //           : SizedBox(
                                        //               height: 18,
                                        //             ),
                                        //       _imag4 == null &&
                                        //               data
                                        //                       .userprofile
                                        //                       .images![3]!
                                        //                       .img! ==
                                        //                   null
                                        //           ? Container()
                                        //           : Container(
                                        //               width:
                                        //                   devicesize.width * .6,
                                        //               height:
                                        //                   devicesize.height *
                                        //                       .3,
                                        //               decoration: BoxDecoration(
                                        //                 borderRadius:
                                        //                     BorderRadius
                                        //                         .circular(8),
                                        //               ),
                                        //               child: ClipRRect(
                                        //                   child: _imag4 == null
                                        //                       ? Image.network(
                                        //                           data
                                        //                               .userprofile
                                        //                               .images![
                                        //                                   3]!
                                        //                               .img!,
                                        //                           fit: BoxFit
                                        //                               .fill,
                                        //                         )
                                        //                       : Image.file(
                                        //                           File(_imag4!
                                        //                               .path),
                                        //                           fit: BoxFit
                                        //                               .fill,
                                        //                         )),
                                        //             )
                                        //     ],
                                        //   );
                                        // }),
                                        // SizedBox(
                                        //   height: 18,
                                        // )
                                      ],
                                    ),
                                  )
                                : Container(),
                            Consumer<ProfileProvider>(
                              builder: (ctx, data, ch) {
                                return data.isLoadingUpdatingProfile
                                    ? myLoadingWidget(
                                        context, MySettings.maincolor)
                                    : CustomButton(tr('save'), () async {
                                        if (_formkey.currentState!.validate()) {
                                          print(newImageList.toString() +
                                              'leeeeeeeeeeength');
                                          Map<String, dynamic> bodyFormData = {
                                            "name": _username.text,
                                            "email": _email.text,
                                            "phone": _phone.text,
                                            "city_id": data.selectedCity!.id,
                                            "country_id":
                                                data.selectedCountry!.id
                                          };
                                          if (data.userprofile.userType ==
                                              'provider') {
                                            bodyFormData['address'] =
                                                'this is address';
                                            bodyFormData['lat'] = '23.4';
                                            bodyFormData['lng'] = '32.3';
                                            bodyFormData[
                                                    'commercial_register'] =
                                                _sglnumber.text;
                                            bodyFormData['city_id'] =
                                                data.selectedCity!.id;
                                            bodyFormData['country_id'] =
                                                data.selectedCountry!.id;
                                            bodyFormData['from_time'] =
                                                _from.text;
                                            bodyFormData['to_time'] = _to.text;
                                            bodyFormData['old_images'] =
                                                json.encode(oldImageList);
                                            bodyFormData['images[]'] =
                                                newImageList
                                                    .map(
                                                      (imagepath) => MultipartFile
                                                          .fromFileSync(
                                                              imagepath,
                                                              filename:
                                                                  'myimage.jpg'),
                                                    )
                                                    .toList();
                                            // [

                                            //   await MultipartFile.fromFile(
                                            //       _imag2!.path,
                                            //       filename: 'myimage.jpg'),
                                            //   await MultipartFile.fromFile(
                                            //       _imag3!.path,
                                            //       filename: 'myimage.jpg'),
                                            //   await MultipartFile.fromFile(
                                            //       _imag4!.path,
                                            //       filename: 'myimage.jpg')
                                            // ];
                                          } else {
                                            bodyFormData['avatar'] =
                                                MultipartFile.fromFileSync(
                                                    _image!.path,
                                                    filename: 'myimage.jpg');
                                          }
                                          if (_image != null) {}
                                          final response = await Provider.of<
                                                      ProfileProvider>(context,
                                                  listen: false)
                                              .updateProfile(
                                                  formdata: bodyFormData,
                                                  lang: EasyLocalization.of(
                                                          context)!
                                                      .currentLocale!
                                                      .languageCode);
                                          if (response['status'] == false) {
                                            showMyToast(context,
                                                response['error'], 'error');
                                          } else {
                                            await saveUserDataToSharedPref(
                                                name: _username.text,
                                                email: _email.text,
                                                local: true,
                                                image: _image != null
                                                    ? _image!.path
                                                    : newImageList[0]);
                                            Navigator.of(context)
                                                .pushAndRemoveUntil(
                                                    MaterialPageRoute(
                                                        builder: (ctx) {
                                              return MainActivity(
                                                data.userprofile.userType !=
                                                        'provider'
                                                    ? 'normal'
                                                    : 'provider',
                                              );
                                            }),
                                                    (Route<dynamic> route) =>
                                                        false);
                                            print(response.toString());
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
                              height: 18,
                            ),
                            CustomButton(tr('changepassword'), () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (txc) {
                                return ResetNewPassword();
                              }));
                            }),
                          ],
                        ),
                      );
          },
        ),
      ),
    );
  }
}
