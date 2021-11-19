import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shanbwrog/Settings/MySettings.dart';
import 'package:shanbwrog/models/reservation.dart';
import 'package:shanbwrog/providers/reservations.dart';
import 'package:shanbwrog/providers/serviceprovider/service_provider_reservations.dart';
import 'package:shanbwrog/ui/general/appbar.dart';
import 'package:shanbwrog/ui/screens/main/mainFragment.dart';
import 'package:shanbwrog/ui/serviceprovider/reservationInfo.dart';
import 'package:shanbwrog/ui/widgets/emptyitem.dart';
import 'package:shanbwrog/ui/widgets/futurebuilder.dart';
import 'package:shanbwrog/ui/widgets/loadingDialog.dart';
import 'package:shanbwrog/ui/widgets/myToast.dart';
import 'package:shanbwrog/ui/widgets/my_loading_widget.dart';

class ServiceProviderReservationFragment extends StatefulWidget {
  @override
  _ServiceProviderReservationFragmentState createState() =>
      _ServiceProviderReservationFragmentState();
}

class _ServiceProviderReservationFragmentState
    extends State<ServiceProviderReservationFragment> {
  int _newindex = 0;
  List<Reservation> reservations = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final devicesize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(20),
          child: ListView(
            children: [
              NewAppbar(
                devicesize: devicesize,
                text: tr('myreservations'),
                allowBack: false,
              ),
              SizedBox(
                height: devicesize.height * .03,
              ),
              Container(
                width: devicesize.width * .9,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    border: Border.all(color: MySettings.maincolor),
                    borderRadius: BorderRadius.circular(8)),
                child: Row(
                  children: [
                    Expanded(
                      child: SelectionItem(
                        currentIndex: 0,
                        newIndex: _newindex,
                        text: tr('reservationrequests'),
                        ontap: () {
                          setState(() {
                            _newindex = 0;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: SelectionItem(
                        currentIndex: 1,
                        newIndex: _newindex,
                        text: tr('currentreservations'),
                        ontap: () {
                          setState(() {
                            _newindex = 1;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: SelectionItem(
                        currentIndex: 2,
                        newIndex: _newindex,
                        text: tr('finishedreservations'),
                        ontap: () {
                          setState(() {
                            _newindex = 2;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              _newindex == 0
                  ? ApiFutureBuilder(
                      future: Provider.of<ServiceProviderReservationsProvider>(
                              context,
                              listen: false)
                          .getProviderReservations(
                              context,
                              EasyLocalization.of(context)!
                                  .currentLocale!
                                  .languageCode,
                              'current'),
                      consumer: Consumer<ServiceProviderReservationsProvider>(
                        builder: (ctx, data, ch) {
                          return data.isloadingMyReservations
                              ? myLoadingWidget(context, MySettings.maincolor)
                              : data.newmyReservations.length == 0
                                  ? ExplainItem(tr('emptylist'))
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: data.newmyReservations.length,
                                      itemBuilder: (ctx, index) {
                                        return Container(
                                          width: devicesize.width * .8,
                                          margin: EdgeInsets.symmetric(
                                              vertical: 10),
                                          padding: EdgeInsets.all(15),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12)),
                                              border: Border.all(
                                                  color: MySettings
                                                      .secondarycolor)),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                data.newmyReservations[index]
                                                    .name!,
                                                style: TextStyle(
                                                    fontSize: 19,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      data
                                                          .newmyReservations[
                                                              index]
                                                          .reservationDate!,
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ),
                                                  IconButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .push(
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (ctx) {
                                                          return ReservationInfo(
                                                              data.newmyReservations[
                                                                  index]);
                                                        }));
                                                      },
                                                      icon: Icon(
                                                        Icons
                                                            .arrow_forward_ios_rounded,
                                                        color: Colors.black,
                                                        size: 25,
                                                      ))
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Consumer<
                                                      ServiceProviderReservationsProvider>(
                                                    builder: (ctx, data, ch) {
                                                      return GestureDetector(
                                                        onTap: () async {
                                                          showDialog(
                                                              context: context,
                                                              barrierDismissible:
                                                                  false,
                                                              builder:
                                                                  (context) {
                                                                return LoadingDialog(
                                                                    tr('loading'));
                                                              });
                                                          final result = await data.acceptReservation(
                                                              context: context,
                                                              lang: EasyLocalization
                                                                      .of(
                                                                          context)!
                                                                  .currentLocale!
                                                                  .languageCode,
                                                              id: data
                                                                  .newmyReservations[
                                                                      index]
                                                                  .id
                                                                  .toString());
                                                          Navigator.of(context)
                                                              .pop();
                                                          if (result[
                                                                  'status'] ==
                                                              false) {
                                                            showMyToast(
                                                                context,
                                                                result['error'],
                                                                'error');
                                                          } else {}
                                                        },
                                                        child: Container(
                                                          width: 110,
                                                          height: 40,
                                                          decoration: BoxDecoration(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      39,
                                                                      172,
                                                                      39,
                                                                      1),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15)),
                                                          child: Center(
                                                            child: Text(
                                                              tr('accept'),
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Consumer<
                                                      ServiceProviderReservationsProvider>(
                                                    builder: (ctx, data, ch) {
                                                      return GestureDetector(
                                                        onTap: () async {
                                                          showDialog(
                                                              context: context,
                                                              barrierDismissible:
                                                                  false,
                                                              builder:
                                                                  (context) {
                                                                return LoadingDialog(
                                                                    tr('loading'));
                                                              });
                                                          final result = await data.refuseReservation(
                                                              context: context,
                                                              lang: EasyLocalization
                                                                      .of(
                                                                          context)!
                                                                  .currentLocale!
                                                                  .languageCode,
                                                              id: data
                                                                  .newmyReservations[
                                                                      index]
                                                                  .id
                                                                  .toString());
                                                          Navigator.of(context)
                                                              .pop();
                                                          if (result[
                                                                  'status'] ==
                                                              false) {
                                                            showMyToast(
                                                                context,
                                                                result['error'],
                                                                'error');
                                                          } else {}
                                                        },
                                                        child: Container(
                                                          width: 110,
                                                          height: 40,
                                                          decoration: BoxDecoration(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      248,
                                                                      100,
                                                                      100,
                                                                      1),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15)),
                                                          child: Center(
                                                            child: Text(
                                                              tr('refuse'),
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        );
                                      });
                        },
                      ),
                    )
                  : _newindex == 1
                      ? ApiFutureBuilder(
                          future:
                              Provider.of<ServiceProviderReservationsProvider>(
                                      context,
                                      listen: false)
                                  .getProviderReservations(
                                      context,
                                      EasyLocalization.of(context)!
                                          .currentLocale!
                                          .languageCode,
                                      'processing'),
                          consumer:
                              Consumer<ServiceProviderReservationsProvider>(
                            builder: (ctx, data, ch) {
                              return data.isloadingMyReservations
                                  ? myLoadingWidget(
                                      context, MySettings.maincolor)
                                  : data.currentmyReservations.length == 0
                                      ? ExplainItem(tr('emptylist'))
                                      : ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount:
                                              data.currentmyReservations.length,
                                          itemBuilder: (ctx, index) {
                                            return Container(
                                              width: devicesize.width * .8,
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 10),
                                              padding: EdgeInsets.all(15),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(12)),
                                                  border: Border.all(
                                                      color: MySettings
                                                          .secondarycolor)),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    data
                                                        .currentmyReservations[
                                                            index]
                                                        .name!,
                                                    style: TextStyle(
                                                        fontSize: 19,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          data
                                                              .currentmyReservations[
                                                                  index]
                                                              .reservationDate!,
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              color:
                                                                  Colors.grey,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ),
                                                      IconButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .push(MaterialPageRoute(
                                                                    builder:
                                                                        (ctx) {
                                                              return ReservationInfo(
                                                                  data.currentmyReservations[
                                                                      index]);
                                                            }));
                                                          },
                                                          icon: Icon(
                                                            Icons
                                                                .arrow_forward_ios_rounded,
                                                            color: Colors.black,
                                                            size: 25,
                                                          ))
                                                    ],
                                                  ),
                                                  GestureDetector(
                                                    onTap: () async {
                                                      showDialog(
                                                          context: context,
                                                          barrierDismissible:
                                                              false,
                                                          builder: (context) {
                                                            return LoadingDialog(
                                                                tr('loading'));
                                                          });
                                                      await Provider.of<
                                                                  ServiceProviderReservationsProvider>(
                                                              context,
                                                              listen: false)
                                                          .finsihReservation(
                                                              context: context,
                                                              lang: EasyLocalization
                                                                      .of(
                                                                          context)!
                                                                  .currentLocale!
                                                                  .languageCode,
                                                              id: data
                                                                  .currentmyReservations[
                                                                      index]
                                                                  .id
                                                                  .toString()!)
                                                          .then((value) {
                                                        Navigator.of(context)
                                                            .pop();
                                                        if (value['status'] ==
                                                            false) {
                                                          showMyToast(
                                                              context,
                                                              value['error'],
                                                              'error');
                                                        } else {}
                                                      });
                                                    },
                                                    child: Container(
                                                      width: 110,
                                                      height: 40,
                                                      decoration: BoxDecoration(
                                                          color: MySettings
                                                              .secondarycolor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15)),
                                                      child: Center(
                                                        child: Text(
                                                          tr('finishreservation'),
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            );
                                          });
                            },
                          ),
                        )
                      : ApiFutureBuilder(
                          future:
                              Provider.of<ServiceProviderReservationsProvider>(
                                      context,
                                      listen: false)
                                  .getProviderReservations(
                                      context,
                                      EasyLocalization.of(context)!
                                          .currentLocale!
                                          .languageCode,
                                      'finish'),
                          consumer:
                              Consumer<ServiceProviderReservationsProvider>(
                            builder: (ctx, data, ch) {
                              return data.isloadingMyReservations
                                  ? myLoadingWidget(
                                      context, MySettings.maincolor)
                                  : data.finishedmyReservations.length == 0
                                      ? ExplainItem(tr('emptylist'))
                                      : ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount: data
                                              .finishedmyReservations.length,
                                          itemBuilder: (ctx, index) {
                                            return Container(
                                              width: devicesize.width * .8,
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 10),
                                              padding: EdgeInsets.all(15),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(12)),
                                                  border: Border.all(
                                                      color: Colors.red)),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    data
                                                        .finishedmyReservations[
                                                            index]
                                                        .name!,
                                                    style: TextStyle(
                                                        fontSize: 19,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          data
                                                              .finishedmyReservations[
                                                                  index]
                                                              .reservationDate!,
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              color:
                                                                  Colors.grey,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ),
                                                      Consumer<
                                                          ServiceProviderReservationsProvider>(
                                                        builder:
                                                            (ctx, data, ch) {
                                                          return IconButton(
                                                              onPressed:
                                                                  () async {
                                                                showDialog(
                                                                    context:
                                                                        context,
                                                                    barrierDismissible:
                                                                        false,
                                                                    builder:
                                                                        (context) {
                                                                      return LoadingDialog(
                                                                          tr('loading'));
                                                                    });
                                                                await Provider.of<
                                                                            ServiceProviderReservationsProvider>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .deleteReservation(
                                                                        context:
                                                                            context,
                                                                        lang: EasyLocalization.of(context)!
                                                                            .currentLocale!
                                                                            .languageCode,
                                                                        reservationId: data
                                                                            .finishedmyReservations[
                                                                                index]
                                                                            .id!)
                                                                    .then(
                                                                        (value) {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                  if (value[
                                                                          'status'] ==
                                                                      false) {
                                                                    showMyToast(
                                                                        context,
                                                                        value[
                                                                            'error'],
                                                                        'error');
                                                                  } else {}
                                                                });
                                                              },
                                                              icon: Icon(
                                                                Icons.delete,
                                                                color:
                                                                    Colors.red,
                                                                size: 25,
                                                              ));
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    width: 110,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                        color: Color.fromRGBO(
                                                            254, 224, 224, 1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15)),
                                                    child: Center(
                                                      child: Text(
                                                        tr('completed'),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Colors.red),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            );
                                          });
                            },
                          ),
                        )
              // ListView.builder(
              //             shrinkWrap: true,
              //             physics: NeverScrollableScrollPhysics(),
              //             itemCount: reservations.length,
              //             itemBuilder: (ctx, index) {
              //               return Container(
              //                 width: devicesize.width * .8,
              //                 margin: EdgeInsets.symmetric(vertical: 10),
              //                 padding: EdgeInsets.all(15),
              //                 decoration: BoxDecoration(
              //                     borderRadius:
              //                         BorderRadius.all(Radius.circular(12)),
              //                     border: Border.all(
              //                         color: reservations[index].type == 1
              //                             ? Colors.yellow
              //                             : reservations[index].type == 2
              //                                 ? Colors.green
              //                                 : Colors.red)),
              //                 child: Column(
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   children: [
              //                     Text(
              //                       'إسم الصالون او المركز',
              //                       style: TextStyle(
              //                           fontSize: 19,
              //                           color: Colors.black,
              //                           fontWeight: FontWeight.bold),
              //                     ),
              //                     Row(
              //                       children: [
              //                         Expanded(
              //                           child: Text(
              //                             'السبت 24 -5 -2012',
              //                             style: TextStyle(
              //                                 fontSize: 15,
              //                                 color: Colors.grey,
              //                                 fontWeight: FontWeight.w600),
              //                           ),
              //                         ),
              //                         IconButton(
              //                             onPressed: () {
              //                               Navigator.of(context).pop();
              //                             },
              //                             icon: Icon(
              //                               Icons.delete,
              //                               color: Colors.red,
              //                               size: 25,
              //                             ))
              //                       ],
              //                     ),
              //                     Container(
              //                       width: 110,
              //                       height: 40,
              //                       decoration: BoxDecoration(
              //                           color: Color.fromRGBO(254, 224, 224, 1),
              //                           borderRadius:
              //                               BorderRadius.circular(15)),
              //                       child: Center(
              //                         child: Text(
              //                           tr('completed'),
              //                           style: TextStyle(
              //                               fontWeight: FontWeight.w600,
              //                               color: Colors.red),
              //                         ),
              //                       ),
              //                     )
              //                   ],
              //                 ),
              //               );
              //             })
            ],
          ),
        ),
      ),
    );
  }
}
