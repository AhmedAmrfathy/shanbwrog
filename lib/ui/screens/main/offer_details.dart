import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shanbwrog/Settings/MySettings.dart';
import 'package:shanbwrog/models/category.dart';
import 'package:shanbwrog/models/offer.dart';
import 'package:shanbwrog/providers/Auth.dart';
import 'package:shanbwrog/providers/home.dart';
import 'package:shanbwrog/ui/screens/main/reserveService.dart';
import 'package:shanbwrog/ui/widgets/customButton.dart';
import 'package:shanbwrog/ui/widgets/futurebuilder.dart';
import 'package:shanbwrog/ui/widgets/myToast.dart';
import 'package:shanbwrog/ui/widgets/my_loading_widget.dart';
import 'package:shanbwrog/ui/widgets/photopreview.dart';

class OfferDetails extends StatefulWidget {
  final int? offerId;
  final String? categoryid;
  final Offer? offer;

  OfferDetails({this.offerId, this.categoryid, this.offer});

  @override
  _OfferDetailsState createState() => _OfferDetailsState();
}

class _OfferDetailsState extends State<OfferDetails> {
  late List<String?> images;

  @override
  void initState() {
    images = [
      widget.offer!.img,
      widget.offer!.img2,
      widget.offer!.img3,
      widget.offer!.img4
    ];
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final devicesize = MediaQuery.of(context).size;
    final homeprovider = Provider.of<HomeProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
          child: ApiFutureBuilder(
        future: homeprovider.getserviceProviderOfferDetails(
            context,
            EasyLocalization.of(context)!.currentLocale!.languageCode,
            widget.offerId!),
        consumer: Consumer<HomeProvider>(
          builder: (ctx, data, ch) {
            return data.isloadingofferdetails
                ? myLoadingWidget(context, MySettings.maincolor)
                : ListView(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    children: [
                      Container(
                        width: devicesize.width,
                        height: 40,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Text(
                              '?????????? ????????????',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 19,
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
                            .map((item) => GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(builder: (ctx) {
                                      return PhotoPreview(item!);
                                    }));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Center(
                                        child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(
                                        item!,
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                                  ),
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
                              tr('offerprice'),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600),
                            ),
                            Spacer(),
                            Text(data.serviceProviderOfferDetails.oldPrice!,
                                style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    color: MySettings.secondarycolor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600)),
                            SizedBox(
                              width: 7,
                            ),
                            Text(
                              data.serviceProviderOfferDetails.price!,
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
                                tr('offerdetails'),
                                style: TextStyle(
                                    color: Colors.black, fontSize: 19),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: devicesize.width * .85,
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(243, 246, 250, 1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                child: Text(
                                  data.serviceProviderOfferDetails.details!,
                                  style: TextStyle(
                                      color: Color.fromRGBO(194, 195, 196, 1),
                                      fontSize: 16),
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
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (ctx) {
                              return ReserveService(
                                data.serviceProviderOfferDetails.id.toString()!,
                                reserveOffer: true,
                                offer: data.serviceProviderOfferDetails,
                              );
                            }));
                          }
                        }),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: CustomButton(tr('sendgift'), () {
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
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (ctx) {
                              return ReserveService(
                                data.serviceProviderOfferDetails.id.toString()!,
                                reserveOffer: true,
                                offer: data.serviceProviderOfferDetails,
                                sendGift: true,
                              );
                            }));
                          }
                        }),
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
                      //                 '?????????? ????????????',
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
                  );
          },
        ),
      )),
    );
  }
}
