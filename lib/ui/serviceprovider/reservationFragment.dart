import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shanbwrog/Settings/MySettings.dart';
import 'package:shanbwrog/models/reservation.dart';
import 'package:shanbwrog/ui/general/appbar.dart';
import 'package:shanbwrog/ui/screens/main/mainFragment.dart';

class ServiceProviderReservationFragment extends StatefulWidget {
  @override
  _ServiceProviderReservationFragmentState createState() =>
      _ServiceProviderReservationFragmentState();
}

class _ServiceProviderReservationFragmentState
    extends State<ServiceProviderReservationFragment> {
  int _newindex = 0;
  List<Reservation> reservations = [

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
                              border:
                                  Border.all(color: MySettings.secondarycolor)),
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
                              Row(
                                children: [
                                  Container(
                                    width: 110,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: Color.fromRGBO(39, 172, 39, 1),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Center(
                                      child: Text(
                                        tr('accept'),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    width: 110,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: Color.fromRGBO(248, 100, 100, 1),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Center(
                                      child: Text(
                                        tr('refuse'),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      })
                  : _newindex == 1
                      ?
              ListView.builder(
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
                                      color: MySettings.secondarycolor)),
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
                                        color: MySettings.secondarycolor,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Center(
                                      child: Text(
                                        tr('finishreservation'),textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          })
                      : Container()
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
