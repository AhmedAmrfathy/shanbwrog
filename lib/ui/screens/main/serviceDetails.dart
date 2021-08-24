import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shanbwrog/Settings/MySettings.dart';
import 'package:shanbwrog/ui/screens/main/reserveService.dart';
import 'package:shanbwrog/ui/widgets/customButton.dart';

class ServiceDetails extends StatefulWidget {
  @override
  _ServiceDetailsState createState() => _ServiceDetailsState();
}

class _ServiceDetailsState extends State<ServiceDetails> {
  List<String> images = [
    'https://media-cdn.tripadvisor.com/media/photo-s/0c/a3/67/9d/maestral-resort-casino.jpg',
    'https://mostaql.hsoubcdn.com/uploads/thumbnails/835649/5fb1c7c34bc0a/Beauty-Centre-1.jpg'
  ];

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
                    'خدمات المساج',
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
                            item,
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
                    '25 جنيه',
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
                        ' هذا النص هو مثال تجريبى فقد لما يمكن كتابته هذا النص هو مثال تجريبى فقد لما يمكن كتابته هذا النص هو مثال تجريبى فقد لما يمكن كتابته هذا النص هو مثال تجريبى فقد لما يمكن كتابته لما يمكن كتابته هذا النص هو مثال تجريبى فقد لما يمكن كتابته ',
                        style: TextStyle(
                            color: Color.fromRGBO(194, 195, 196, 1),
                            fontSize: 17),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: CustomButton(tr('reserve'), () {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                  return ReserveService();
                }));
              }),
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: CustomButton(tr('sendgift'), () {}),
            ),

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
