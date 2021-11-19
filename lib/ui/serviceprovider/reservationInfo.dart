import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shanbwrog/Settings/MySettings.dart';
import 'package:shanbwrog/models/reservation.dart';
import 'package:shanbwrog/providers/Auth.dart';
import 'package:shanbwrog/providers/serviceprovider/service_provider_reservations.dart';
import 'package:shanbwrog/ui/screens/main/mainActivity.dart';
import 'package:shanbwrog/ui/screens/main/reserveService.dart';
import 'package:shanbwrog/ui/widgets/customButton.dart';
import 'package:shanbwrog/ui/widgets/loadingDialog.dart';
import 'package:shanbwrog/ui/widgets/myToast.dart';

class ReservationInfo extends StatefulWidget {
  Reservation reservation;

  ReservationInfo(this.reservation);

  @override
  _ReservationInfoState createState() => _ReservationInfoState();
}

class _ReservationInfoState extends State<ReservationInfo> {
  List<String?> images = [
    'https://media-cdn.tripadvisor.com/media/photo-s/0c/a3/67/9d/maestral-resort-casino.jpg',
    'https://mostaql.hsoubcdn.com/uploads/thumbnails/835649/5fb1c7c34bc0a/Beauty-Centre-1.jpg'
  ];

  @override
  void initState() {
    images = widget.reservation.category == null
        ? [
            widget.reservation.offer!.img,
            widget.reservation.offer!.img2,
            widget.reservation.offer!.img3,
            widget.reservation.offer!.img4
          ]
        : [
            widget.reservation.category!.img,
            widget.reservation.category!.img2,
            widget.reservation.category!.img3,
            widget.reservation.category!.img4
          ];

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final devicesize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 20),
          children: [
            Container(
              width: devicesize.width,
              height: 40,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text(
                    widget.reservation.category == null
                        ? widget.reservation.offer!.title!
                        : widget.reservation.category!.name!,
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
              height: 15,
            ),
            Container(
                child: CarouselSlider(
              options: CarouselOptions(autoPlay: true),
              items: images
                  .map((item) => Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12)),
                        child: Center(
                            child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            item!,
                            fit: BoxFit.cover,
                          ),
                        )),
                      ))
                  .toList(),
            )),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text(
                    tr('serviceprice'),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w600),
                  ),
                  Spacer(),
                  Text(
                    widget.reservation.category == null
                        ? widget.reservation.offer!.price!
                        : widget.reservation.category!.price!,
                    style: TextStyle(
                        color: MySettings.secondarycolor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: devicesize.width,
              height: 1,
              color: Colors.grey.withOpacity(.2),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: devicesize.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      tr('servicedetails'),
                      style: TextStyle(color: Colors.black, fontSize: 19),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: devicesize.width * .85,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(243, 246, 250, 1),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Text(
                        widget.reservation.category == null
                            ? widget.reservation.offer!.details!
                            : widget.reservation.category!.details!,
                        style: TextStyle(
                            color: Color.fromRGBO(194, 195, 196, 1),
                            fontSize: 17),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      tr('reserverinfo'),
                      style: TextStyle(color: Colors.black, fontSize: 19),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: devicesize.width * .85,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(243, 246, 250, 1),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tr('username'),
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              widget.reservation.name!,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Text(
                              tr('address'),
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              widget.reservation.address!,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Text(
                              tr('phonenumber'),
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              widget.reservation.phone!,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Text(
                              tr('appointment'),
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              widget.reservation.reservationDate!,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Provider.of<AuthProvider>(context, listen: false)
                        .userModel
                        .userType ==
                    'provider'
                ? Consumer<ServiceProviderReservationsProvider>(
                    builder: (ctx, data, ch) {
                      return GestureDetector(
                        onTap: () async {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) {
                                return LoadingDialog(tr('loading'));
                              });
                          final result = await data.acceptReservation(
                              context: context,
                              lang: EasyLocalization.of(context)!
                                  .currentLocale!
                                  .languageCode,
                              id: widget.reservation.id.toString());
                          Navigator.of(context).pop();
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (ctx) => MainActivity('provider',navigateIndex: 2,)),
                                  (route) => false);
                          if (result['status'] == false) {
                            showMyToast(context, result['error'], 'error');
                          } else {}
                        },
                        child: Container(
                          width: devicesize.width * .8,
                          height: 70,
                          margin: EdgeInsets.symmetric(horizontal: 40),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Color.fromRGBO(60, 194, 118, 1)),
                          child: Center(
                            child: Text(
                              tr('accept'),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 22),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : Container(),
            SizedBox(
              height: 15,
            ),
            Provider.of<AuthProvider>(context, listen: false)
                        .userModel
                        .userType ==
                    'provider'
                ? GestureDetector(
                    onTap: () {},
                    child: Consumer<ServiceProviderReservationsProvider>(
                      builder: (ctx, data, ch) {
                        return GestureDetector(
                          onTap: () async {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) {
                                  return LoadingDialog(tr('loading'));
                                });
                            final result = await data.refuseReservation(
                                context: context,
                                lang: EasyLocalization.of(context)!
                                    .currentLocale!
                                    .languageCode,
                                id: widget.reservation.id.toString());
                            Navigator.of(context).pop();
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (ctx) => MainActivity('provider',navigateIndex: 2,)),
                                (route) => false);
                            if (result['status'] == false) {
                              showMyToast(context, result['error'], 'error');
                            } else {}
                          },
                          child: Container(
                            width: devicesize.width * .8,
                            height: 70,
                            margin: EdgeInsets.symmetric(horizontal: 40),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: MySettings.secondarycolor),
                            child: Center(
                              child: Text(
                                tr('refuse'),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 22),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : Container(),

            // Container(
            //   width: devicesize.width,
            //   height: devicesize.height * .3,
            //   color: Colors.red,
            //   child: Stack(
            //     children: [
            //       Container(
            //           child: CarouselSlider(
            //         options: CarouselOptions(viewportFraction: 1.0),
            //         items: images
            //             .map((item) => Container(
            //                   child: Center(
            //                       child: Image.network(item,
            //                           fit: BoxFit.cover, width: 1000)),
            //                 ))
            //             .toList(),
            //       )),
            //       Positioned(
            //         top: 40,
            //         child:
            //         Container(
            //           width: devicesize.width,
            //           height: 40,
            //           padding: EdgeInsets.symmetric(horizontal: 20),
            //           child: Row(
            //             children: [
            //               Text(
            //                 'خدمات المساج',
            //                 style: TextStyle(color: Colors.black, fontSize: 19,fontWeight: FontWeight.w600),
            //               ),
            //               Spacer(),
            //               IconButton(
            //                   onPressed: () {},
            //                   icon: Icon(
            //                     Icons.arrow_forward_ios_rounded,
            //                     color: Colors.black,
            //                     size: 30,
            //                   )),
            //             ],
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
