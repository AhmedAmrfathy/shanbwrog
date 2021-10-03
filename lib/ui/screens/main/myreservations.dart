import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:shanbwrog/Settings/MySettings.dart';
import 'package:shanbwrog/models/reservation.dart';
import 'package:shanbwrog/providers/reservations.dart';
import 'package:shanbwrog/ui/general/appbar.dart';
import 'package:shanbwrog/ui/widgets/emptyitem.dart';
import 'package:shanbwrog/ui/widgets/futurebuilder.dart';
import 'package:shanbwrog/ui/widgets/myToast.dart';
import 'package:shanbwrog/ui/widgets/my_loading_widget.dart';

import 'mainFragment.dart';

class MyReservations extends StatefulWidget {
  @override
  _MyReservationsState createState() => _MyReservationsState();
}

class _MyReservationsState extends State<MyReservations> {
  int _newindex = 0;

  // List<Reservation> reservations = [
  //   Reservation(type: 1),
  //   Reservation(type: 2),
  //   Reservation(type: 3)
  // ];

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
              ),
              SizedBox(
                height: devicesize.height * .03,
              ),
              Container(
                width: devicesize.width * .9,
                height: 45,
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
                        text: tr('currentreservations'),
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
                        text: tr('finishedreservations'),
                        ontap: () {
                          setState(() {
                            _newindex = 1;
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
                      future: Provider.of<ReservationsProvider>(context,
                              listen: false)
                          .getMyReservations(
                              context,
                              EasyLocalization.of(context)!
                                  .currentLocale!
                                  .languageCode,
                              'current'),
                      consumer: Consumer<ReservationsProvider>(
                        builder: (ctx, data, ch) {
                          return data.isloadingMyReservations
                              ? myLoadingWidget(context, MySettings.maincolor)
                              : data.currentmyReservations.length == 0
                                  ? ExplainItem(tr('emptylist'))
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount:
                                          data.currentmyReservations.length,
                                      itemBuilder: (ctx, index) {
                                        return AnimationConfiguration
                                            .staggeredList(
                                          position: index,
                                          duration: const Duration(
                                              milliseconds: 1000),
                                          child: SlideAnimation(
                                            curve: Curves.easeIn,
                                            verticalOffset: 0.0,
                                            child: FlipAnimation(
                                              flipAxis: FlipAxis.x,
                                              child: Container(
                                                width: devicesize.width * .8,
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 10),
                                                padding: EdgeInsets.all(15),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                12)),
                                                    border: Border.all(
                                                        color: data
                                                                    .currentmyReservations[
                                                                        index]
                                                                    .status ==
                                                                '1'
                                                            ? Colors.yellow
                                                            : data.currentmyReservations[index]
                                                                        .status ==
                                                                    '2'
                                                                ? Colors.green
                                                                : Colors.red)),
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
                                                                  .pop();
                                                            },
                                                            icon: Icon(
                                                              Icons
                                                                  .arrow_forward_ios_rounded,
                                                              color:
                                                                  Colors.black,
                                                              size: 25,
                                                            ))
                                                      ],
                                                    ),
                                                    Container(
                                                      width: 110,
                                                      height: 40,
                                                      decoration: BoxDecoration(
                                                          color: data
                                                                      .currentmyReservations[
                                                                          index]
                                                                      .status ==
                                                                  '1'
                                                              ? Color.fromRGBO(
                                                                  255,
                                                                  244,
                                                                  212,
                                                                  1)
                                                              : data.currentmyReservations[index].status ==
                                                                      '2'
                                                                  ? Color.fromRGBO(
                                                                      211,
                                                                      238,
                                                                      211,
                                                                      1)
                                                                  : Color
                                                                      .fromRGBO(
                                                                          254,
                                                                          224,
                                                                          224,
                                                                          1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15)),
                                                      child: Center(
                                                        child: Text(
                                                          data
                                                                      .currentmyReservations[
                                                                          index]
                                                                      .status ==
                                                                  '1'
                                                              ? tr('waiting')
                                                              : data.currentmyReservations[index]
                                                                          .status ==
                                                                      '2'
                                                                  ? tr('accepted')
                                                                  : tr('refused'),
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: data
                                                                          .currentmyReservations[
                                                                              index]
                                                                          .status ==
                                                                      '1'
                                                                  ? Colors.amber
                                                                  : data.currentmyReservations[index].status ==
                                                                          2
                                                                      ? Colors
                                                                          .green
                                                                      : Colors
                                                                          .red),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                        },
                      ),
                    )
                  : ApiFutureBuilder(
                      future: Provider.of<ReservationsProvider>(context,
                              listen: false)
                          .getMyReservations(
                              context,
                              EasyLocalization.of(context)!
                                  .currentLocale!
                                  .languageCode,
                              'finish'),
                      consumer: Consumer<ReservationsProvider>(
                        builder: (ctx, data, ch) {
                          return data.isloadingMyReservations
                              ? myLoadingWidget(context, MySettings.maincolor)
                              : data.finishedmyReservations.length == 0
                                  ? ExplainItem(tr('emptylist'))
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount:
                                          data.finishedmyReservations.length,
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
                                                  color: data
                                                              .finishedmyReservations[
                                                                  index]
                                                              .status ==
                                                          '1'
                                                      ? Colors.yellow
                                                      : data.finishedmyReservations[index]
                                                                  .status ==
                                                              '2'
                                                          ? Colors.green
                                                          : Colors.red)),
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
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ),
                                                  IconButton(
                                                      onPressed: () async {
                                                        await Provider.of<
                                                                    ReservationsProvider>(
                                                                context,
                                                                listen: false)
                                                            .deleteReservation(
                                                                reservationId: data
                                                                    .finishedmyReservations[
                                                                        index]
                                                                    .id!)
                                                            .then((value) {
                                                          if (value['status'] ==
                                                              false) {
                                                            showMyToast(
                                                                context,
                                                                value['error'],
                                                                'error');
                                                          } else {}
                                                        });
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      icon: Icon(
                                                        Icons.delete,
                                                        color: Colors.red,
                                                        size: 25,
                                                      ))
                                                ],
                                              ),
                                              Container(
                                                width: 110,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                    color: Color.fromRGBO(
                                                        254, 224, 224, 1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
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
            ],
          ),
        ),
      ),
    );
  }
}
