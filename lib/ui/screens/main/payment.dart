import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shanbwrog/Settings/MySettings.dart';
import 'package:shanbwrog/models/reservation.dart';
import 'package:shanbwrog/providers/reservations.dart';
import 'package:shanbwrog/ui/general/appbar.dart';
import 'package:shanbwrog/ui/screens/main/mainActivity.dart';
import 'package:shanbwrog/ui/screens/main/myreservations.dart';
import 'package:shanbwrog/ui/widgets/customButton.dart';
import 'package:shanbwrog/ui/widgets/myToast.dart';
import 'package:shanbwrog/ui/widgets/my_loading_widget.dart';

class PaymentScreen extends StatefulWidget {
  Map<String, dynamic> bodyData;

  PaymentScreen(this.bodyData);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int? radiogroup = 0;

  @override
  Widget build(BuildContext context) {
    final devicesize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                NewAppbar(
                  devicesize: devicesize,
                  text: tr('payment'),
                ),
                SizedBox(
                  height: devicesize.height * .06,
                ),
                Image.asset(
                  'assets/images/banking.png',
                  width: 150,
                  height: 150,
                  fit: BoxFit.fill,
                ),
                SizedBox(
                  height: devicesize.height * .02,
                ),
                Text(
                  tr('choosepayment'),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Transform.scale(
                      scale: 1.5,
                      child: Radio(
                        activeColor: MySettings.secondarycolor,
                        value: 0,
                        groupValue: radiogroup,
                        splashRadius: 30,
                        onChanged: (int? newvalue) {
                          setState(() {
                            radiogroup = newvalue;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      tr('cash'),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Transform.scale(
                      scale: 1.5,
                      child: Radio(
                        activeColor: MySettings.secondarycolor,
                        value: 1,
                        groupValue: radiogroup,
                        splashRadius: 30,
                        onChanged: (int? newvalue) {
                          setState(() {
                            radiogroup = newvalue;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(tr('visa'),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500))
                  ],
                ),
                Row(
                  children: [
                    Transform.scale(
                      scale: 1.5,
                      child: Radio(
                        activeColor: MySettings.secondarycolor,
                        value: 2,
                        groupValue: radiogroup,
                        splashRadius: 30,
                        onChanged: (int? newvalue) {
                          setState(() {
                            radiogroup = newvalue;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(tr('mda'),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500))
                  ],
                ),
                SizedBox(
                  height: devicesize.height * .04,
                ),
                Consumer<ReservationsProvider>(
                  builder: (ctx, data, ch) {
                    return data.isloadingAddingReservation
                        ? myLoadingWidget(context, MySettings.maincolor)
                        : GestureDetector(
                            onTap: () async {
                              widget.bodyData['payment_method'] =
                                  radiogroup == 0
                                      ? 'cache'
                                      : radiogroup == 1
                                          ? 'visa'
                                          : 'mada';
                              final result =
                                  await Provider.of<ReservationsProvider>(
                                          context,
                                          listen: false)
                                      .addReservation(
                                          context: context,
                                          lang: EasyLocalization.of(context)!
                                              .currentLocale!
                                              .languageCode,
                                          bodydata: widget.bodyData);
                              if (result['status'] == true) {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (ctx) {
                                  return SuccessPayment();
                                }));
                              } else {
                                showMyToast(context, result['error'], 'error');
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
                                      padding:
                                          EdgeInsets.only(right: 15, left: 15),
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
                            ),
                          );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SuccessPayment extends StatefulWidget {
  @override
  _SuccessPaymentState createState() => _SuccessPaymentState();
}

class _SuccessPaymentState extends State<SuccessPayment> {
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
                  text: tr('payment'),
                ),
                SizedBox(
                  height: devicesize.height * .14,
                ),
                Image.asset(
                  'assets/images/successpay.png',
                  width: devicesize.width * .3,
                  height: devicesize.width * .3,
                  fit: BoxFit.fill,
                ),
                SizedBox(
                  height: devicesize.height * .02,
                ),
                Text(
                  tr('successreserved'),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: MySettings.secondarycolor,
                      fontSize: 23,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: devicesize.height * .05,
                ),
                CustomButton(tr('myreservations'), () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (ctx) => MainActivity(
                                'user',
                                navigateIndex: 2,
                              )),
                      (route) => false);
                  // Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                  //   return MyReservations();
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
