import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';
import 'package:shanbwrog/Settings/MySettings.dart';
import 'package:shanbwrog/models/category.dart';
import 'package:shanbwrog/models/offer.dart';
import 'package:shanbwrog/models/serviceProviderOffer.dart';
import 'package:shanbwrog/providers/Auth.dart';
import 'package:shanbwrog/providers/reservations.dart';
import 'package:shanbwrog/ui/screens/main/payment.dart';
import 'package:shanbwrog/ui/screens/map/map_screen.dart';
import 'package:shanbwrog/ui/widgets/formitem.dart';
import 'package:shanbwrog/ui/widgets/myToast.dart';

class ReserveService extends StatefulWidget {
  final String id;
  bool? reserveOffer;
  bool? sendGift;
  ServiceProviderOffer? offer;
  Category? service;

  ReserveService(this.id,
      {this.reserveOffer, this.sendGift = false, this.offer, this.service});

  @override
  _ReserveServiceState createState() => _ReserveServiceState();
}

class _ReserveServiceState extends State<ReserveService> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController _address = TextEditingController();
  TextEditingController _appointment = TextEditingController();
  TextEditingController _username = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _time = TextEditingController();
  String userLat = '';
  String userLng = '';

  DateTime? pickeddate;

  Future<void> pickdate(BuildContext context, String lang) async {
    final f = new DateFormat('yyyy-MM-dd');
    final selecteddate = await showDatePicker(
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.fromSwatch(
                primarySwatch: Colors.pink,
              ),
              dialogBackgroundColor: Colors.white,
            ),
            child: child!,
          );
        },
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100));
    if (selecteddate != null) {
      pickeddate = selecteddate;
      String formateddate =
          lang == 'ar' ? f.format(pickeddate!) : f.format(pickeddate!);
      setState(() {
        _appointment.text = formateddate;
      });
    }
  }

  TimeOfDay _initial = TimeOfDay.now().replacing(minute: 30);
  TimeOfDay selectedTime = TimeOfDay.now().replacing(minute: 30);
  late String timeeeee;

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _initial,
    );
    timeeeee = picked!.format(context);
    if (picked != null)
      setState(() {
        selectedTime = picked;
        String _hour = selectedTime.hour.toString();
        String _minute = selectedTime.minute.toString();
        String _alltime = _minute + ' : ' + _hour;
        _time.text = _alltime;
      });
  }

  @override
  void initState() {
    _address.text = (widget.service == null
        ? widget.offer!.address
        : widget.service!.address)!;

    userLat =
        (widget.service == null ? widget.offer!.lat : widget.service!.lat)!;

    userLng =
        (widget.service == null ? widget.offer!.lng : widget.service!.lng)!;
    if (widget.sendGift == false) {
      _username.text =
          Provider.of<AuthProvider>(context, listen: false).userModel.name!;
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final devicesize = MediaQuery.of(context).size;
    final reservationProvider =
        Provider.of<ReservationsProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  Container(
                    width: devicesize.width,
                    height: 40,
                    padding: EdgeInsets.only(right: 30, left: 30),
                    child: Row(
                      children: [
                        Text(
                          tr('reserveservice'),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                        Spacer(),
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.black,
                              size: 30,
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: devicesize.height * .06,
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
                    height: 20,
                  ),
                  StatefulBuilder(builder: (ctx, setNstate) {
                    return FormItemWidget(
                      fill: true,
                      fillingcolor: Colors.white,
                      readonly: true,
                      bordercolor: Colors.grey,
                      enablingborder: true,
                      borderRadious: 12,
                      label: tr('address'),
                      labelStyle: TextStyle(color: Colors.grey, fontSize: 19),
                      suffixicon: Icon(
                        Icons.location_on_sharp,
                        color: MySettings.maincolor,
                      ),
                      validation: (String? value) {
                        if (value == null || value.isEmpty) {
                          return tr('requiredfield');
                        }
                      },
                      textEditingController: _address,
                      ontap: () async {
                        // await Navigator.of(context)
                        //     .push(MaterialPageRoute(builder: (ctx) {
                        //   return MapRegisteration();
                        // })).then((value) {
                        //   setNstate(() {
                        //     _address.text = value['placename'];
                        //     userLat = value['lat'].toString();
                        //     userLng = value['long'].toString();
                        //   });
                        // });
                      },
                    );
                  }),
                  SizedBox(
                    height: 20,
                  ),
                  FormItemWidget(
                    fill: true,
                    fillingcolor: Colors.white,
                    bordercolor: Colors.grey,
                    enablingborder: true,
                    borderRadious: 12,
                    label: tr('time'),
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 19),
                    suffixicon: Icon(
                      Icons.access_time_rounded,
                      color: MySettings.maincolor,
                    ),
                    textEditingController: _time,
                    validation: (String? value) {
                      if (value == null || value.isEmpty) {
                        return tr('requiredfield');
                      }
                    },
                    ontap: () {
                      _selectTime(context);
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    child: InternationalPhoneNumberInput(
                      inputDecoration: InputDecoration(
                          labelText: tr('phonenumber'),
                          labelStyle:
                              TextStyle(color: Colors.grey, fontSize: 17),
                          filled: true,
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black26)),
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
                      countries: ['SA'],
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
                    label: tr('appointment'),
                    validation: (String? value) {
                      if (value == null || value.isEmpty) {
                        return tr('requiredfield');
                      }
                    },
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 19),
                    suffixicon: Icon(
                      Icons.calendar_today,
                      color: MySettings.maincolor,
                    ),
                    textEditingController: _appointment,
                    ontap: () {
                      pickdate(
                          context,
                          EasyLocalization.of(context)!
                              .currentLocale!
                              .languageCode);
                    },
                  ),
                  SizedBox(
                    height: devicesize.height * .05,
                  ),
                  GestureDetector(
                      onTap: () {
                        if (Provider.of<AuthProvider>(context, listen: false)
                                    .userModel
                                    .token ==
                                null ||
                            Provider.of<AuthProvider>(context, listen: false)
                                    .userModel
                                    .token ==
                                '') {
                          showMyToast(context, tr('loginfirst'), 'error');
                        } else {
                          if (_formkey.currentState!.validate()) {
                            DateTime time = DateTime.parse(_appointment.text);
                            String formattedDate =
                                DateFormat('dd/MM/yyyy').format(time);
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (ctx) {
                              return widget.reserveOffer!
                                  ? PaymentScreen({
                                      'reservation_date': formattedDate,
                                      'reservation_time': timeeeee,
                                      'name': _username.text,
                                      'address': _address.text,
                                      'lat': userLat,
                                      'lng': userLng,
                                      'phone': _phone.text,
                                      'offer_id': widget.id,
                                      'reserveOffer': true
                                    })
                                  : PaymentScreen({
                                      'reservation_date': formattedDate,
                                      'reservation_time': timeeeee,
                                      'name': _username.text,
                                      'address': _address.text,
                                      'lat': userLat,
                                      'lng': userLng,
                                      'phone': _phone.text,
                                      'category_id': widget.id,
                                      'reserveOffer': false
                                    });
                            }));
                          }
                        }
                      },
                      child: Container(
                        width: devicesize.width * .8,
                        height: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  MySettings.maincolor,
                                  MySettings.secondarycolor
                                ])),
                        child: Row(
                          children: [
                            Expanded(
                                child: Container(
                              child: Padding(
                                padding: EdgeInsets.only(right: 15, left: 15),
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                ),
                              ),
                            )),
                            Expanded(
                              child: Text(
                                tr('next'),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 22),
                              ),
                            ),
                            Expanded(child: Container()),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
