import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shanbwrog/Settings/MySettings.dart';
import 'package:shanbwrog/ui/screens/main/serviceDetails.dart';

import 'mainFragment.dart';

class SalonDetailsScreen extends StatefulWidget {
  @override
  _SalonDetailsScreenState createState() => _SalonDetailsScreenState();
}

class _SalonDetailsScreenState extends State<SalonDetailsScreen> {
  int _newindex = 0;
  List<String> images = [
    'https://media-cdn.tripadvisor.com/media/photo-s/0c/a3/67/9d/maestral-resort-casino.jpg',
    'https://mostaql.hsoubcdn.com/uploads/thumbnails/835649/5fb1c7c34bc0a/Beauty-Centre-1.jpg'
  ];
  List<String> conditions = [
    'مثال لما يمكن كتابته ف هذا المربع الخاص بالكتابه',
    'مثال لما يمكن كتابته ف هذا المربع الخاص بالكتابه',
    'مثال لما يمكن كتابته ف هذا المربع الخاص بالكتابه'
  ];

  List<Widget> getfragment(Size devicesize, int currentindex) {
    return [
      Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tr('saloninfo'),
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 19,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 15,
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
                      color: Color.fromRGBO(194, 195, 196, 1), fontSize: 17),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                tr('rates'),
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 19,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: devicesize.width * .85,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(243, 246, 250, 1),
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    MySettings.maincolor,
                                    MySettings.secondarycolor
                                  ])),
                          child: Center(
                            child: Text(
                              '4.6',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Column(
                          children: [
                            RatingBar.builder(
                              initialRating: 3,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 15,
                              itemBuilder: (context, _) => Image.asset(
                                'assets/icons/star.png',
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'تقييم ٢٥ مشترك',
                              style: TextStyle(
                                  color: Color.fromRGBO(194, 195, 196, 1),
                                  fontSize: 13),
                            ),
                          ],
                        ),
                        Spacer(),
                        Container(
                          width: devicesize.width * .32,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    MySettings.maincolor,
                                    MySettings.secondarycolor
                                  ])),
                          child: Center(
                            child: Text(
                              tr('addcomment'),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      tr('comments'),
                      style: TextStyle(fontSize: 16),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (ctx, index) {
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text(
                                      'هذا النص هو مثال فقد لما يمكن كتابته ف هذا المربع')),
                              RatingBar.builder(
                                initialRating: 3,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemSize: 10,
                                itemBuilder: (context, _) => Image.asset(
                                  'assets/icons/star.png',
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                      itemCount: 5,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      GridView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.only(top: 15),
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, childAspectRatio: 2 / 1.9),
          itemCount: 8,
          itemBuilder: (ctx, index) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => ServiceDetails()));
              },
              child: Column(
                children: [
                  Image.asset(
                    'assets/icons/service.png',
                    width: 60,
                    height: 60,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'قص الشعر',
                    style: TextStyle(
                        color: MySettings.secondarycolor, fontSize: 16),
                  )
                ],
              ),
            );
          }),
      Container(
        width: devicesize.width * .85,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Color.fromRGBO(243, 246, 250, 1),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Column(
          children: conditions
              .map((e) => Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Icon(
                          Icons.circle,
                          size: 10,
                          color: MySettings.maincolor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            e,
                            style: TextStyle(color: Colors.black, fontSize: 17),
                          ),
                        ),
                      ],
                    ),
                  ))
              .toList(),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final devicesize = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
          width: devicesize.width,
          height: devicesize.height,
          child: ListView(
            children: [
              Container(
                width: devicesize.width,
                height: devicesize.width > 768
                    ? devicesize.height * .6
                    : devicesize.height * .3,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                        child: CarouselSlider(
                      options: CarouselOptions(viewportFraction: 1.0),
                      items: images
                          .map((item) => Container(
                                child: Center(
                                    child: Image.network(item,
                                        fit: BoxFit.cover, width: 1000)),
                              ))
                          .toList(),
                    )),
                    Positioned(
                      top: 40,
                      child: Container(
                        width: devicesize.width,
                        height: 40,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.favorite_border,
                                  color: Colors.white,
                                  size: 30,
                                )),
                            Spacer(),
                            IconButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                icon: Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Colors.white,
                                  size: 30,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    Container(
                      width: devicesize.width * .9,
                      child: Text(
                        'صالون مدام سعاد',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 19,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_sharp,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          'المنصوره احمد ماهر شارع الصفا',
                          style: TextStyle(color: Colors.grey, fontSize: 17),
                        ),
                        Spacer(),
                        Container(
                          width: 120,
                          height: 30,
                          decoration: BoxDecoration(
                              color: MySettings.lightpink,
                              borderRadius: BorderRadius.circular(15)),
                          child: Center(
                            child: Text(
                              'يبعد عنكم ١٥ كم',
                              style:
                                  TextStyle(color: MySettings.secondarycolor),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.timelapse,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          '11:00 Am - 6:5 PM',
                          style: TextStyle(color: Colors.grey, fontSize: 17),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25,
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
                              text: tr('details'),
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
                              text: tr('services'),
                              ontap: () {
                                setState(() {
                                  _newindex = 1;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: SelectionItem(
                              currentIndex: 2,
                              newIndex: _newindex,
                              text: tr('saloncondition'),
                              ontap: () {
                                setState(() {
                                  _newindex = 2;
                                });
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    getfragment(devicesize, _newindex)[_newindex]
                  ],
                ),
              )
            ],
          )),
    );
  }
}
