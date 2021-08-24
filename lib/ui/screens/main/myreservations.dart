import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shanbwrog/Settings/MySettings.dart';
import 'package:shanbwrog/models/reservation.dart';
import 'package:shanbwrog/ui/general/appbar.dart';

import 'mainFragment.dart';

class MyReservations extends StatefulWidget {
  @override
  _MyReservationsState createState() => _MyReservationsState();
}

class _MyReservationsState extends State<MyReservations> {
  int _newindex = 0;
  List<Reservation> reservations = [
    Reservation(type: 1),
    Reservation(type: 2),
    Reservation(type: 3)
  ];

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
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: reservations.length,
                      itemBuilder: (ctx, index) {
                        return Container(
                          width: devicesize.width * .8,
                          margin: EdgeInsets.symmetric(vertical: 10),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              border: Border.all(
                                  color: reservations[index].type == 1
                                      ? Colors.yellow
                                      : reservations[index].type == 2
                                          ? Colors.green
                                          : Colors.red)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'إسم الصالون او المركز',
                                style: TextStyle(
                                    fontSize: 19,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'السبت 24 -5 -2012',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      icon: Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: Colors.black,
                                        size: 25,
                                      ))
                                ],
                              ),
                              Container(
                                width: 110,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: reservations[index].type == 1
                                        ? Color.fromRGBO(255, 244, 212, 1)
                                        : reservations[index].type == 2
                                            ? Color.fromRGBO(211, 238, 211, 1)
                                            : Color.fromRGBO(254, 224, 224, 1),
                                    borderRadius: BorderRadius.circular(15)),
                                child: Center(
                                  child: Text(
                                    reservations[index].type == 1
                                        ? tr('waiting')
                                        : reservations[index].type == 2
                                            ? tr('accepted')
                                            : tr('refused'),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: reservations[index].type == 1
                                            ? Colors.amber
                                            : reservations[index].type == 2
                                                ? Colors.green
                                                : Colors.red),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      })
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: reservations.length,
                      itemBuilder: (ctx, index) {
                        return Container(
                          width: devicesize.width * .8,
                          margin: EdgeInsets.symmetric(vertical: 10),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              border: Border.all(
                                  color: reservations[index].type == 1
                                      ? Colors.yellow
                                      : reservations[index].type == 2
                                          ? Colors.green
                                          : Colors.red)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'إسم الصالون او المركز',
                                style: TextStyle(
                                    fontSize: 19,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'السبت 24 -5 -2012',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
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
                                    color: Color.fromRGBO(254, 224, 224, 1),
                                    borderRadius: BorderRadius.circular(15)),
                                child: Center(
                                  child: Text(
                                    tr('completed'),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.red),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      })
            ],
          ),
        ),
      ),
    );
  }
}
