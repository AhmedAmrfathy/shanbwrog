import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:shanbwrog/Settings/MySettings.dart';
import 'package:shanbwrog/models/userModel.dart';
import 'package:shanbwrog/providers/Auth.dart';
import 'package:shanbwrog/providers/profile.dart';
import 'package:shanbwrog/ui/screens/main/serviceDetails.dart';
import 'package:shanbwrog/ui/widgets/formitem.dart';
import 'package:shanbwrog/ui/widgets/myToast.dart';
import 'package:shanbwrog/ui/widgets/my_loading_widget.dart';
import 'package:shanbwrog/ui/widgets/photopreview.dart';

import 'mainFragment.dart';

class SalonDetailsScreen extends StatefulWidget {
  final int providerid;

  SalonDetailsScreen(this.providerid);

  @override
  _SalonDetailsScreenState createState() => _SalonDetailsScreenState();
}

class _SalonDetailsScreenState extends State<SalonDetailsScreen> {
  TextEditingController _comment = TextEditingController();
  double selectedRate = 0;

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return Scaffold(
          backgroundColor: Colors.white60,
          body: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * .8,
              height: MediaQuery.of(context).size.height * .4,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  Text(
                    tr('rateprovider'),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: MySettings.maincolor, fontSize: 16),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RatingBar.builder(
                    initialRating: selectedRate,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemPadding: EdgeInsets.symmetric(horizontal: 2),
                    itemCount: 5,
                    itemSize: 30,
                    itemBuilder: (context, _) => Image.asset(
                      'assets/icons/star.png',
                    ),
                    onRatingUpdate: (rating) {
                      selectedRate = rating;
                    },
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  FormItemWidget(
                      fill: true,
                      fillingcolor: Colors.white,
                      bordercolor: Colors.grey,
                      enablingborder: true,
                      borderRadious: 12,
                      label: tr('comment'),
                      labelStyle: TextStyle(color: Colors.grey, fontSize: 19),
                      textEditingController: _comment,
                      validation: (String? value) {
                        if (value == null || value.isEmpty) {
                          return tr('requiredfield');
                        }
                      }),
                  SizedBox(
                    height: 40,
                  ),
                  Consumer<ProfileProvider>(
                    builder: (ctx, data, ch) {
                      return data.isLoadingAddingRate
                          ? myLoadingWidget(context, MySettings.maincolor)
                          : GestureDetector(
                              onTap: () async {
                                if (Provider.of<AuthProvider>(context,
                                                listen: false)
                                            .userModel
                                            .token ==
                                        null ||
                                    Provider.of<AuthProvider>(context,
                                                listen: false)
                                            .userModel
                                            .token ==
                                        '') {
                                  showMyToast(
                                      context, tr('loginfirst'), 'error');
                                  Navigator.of(context).pop();
                                } else {
                                  await data.addRate(
                                      lang: EasyLocalization.of(context)!
                                          .currentLocale!
                                          .countryCode,
                                      body: {
                                        "rateable_id": data.userprofile.id,
                                        "rating": selectedRate,
                                        "comment": _comment.text
                                      }).then((value) {
                                    if (value['status'] == false) {
                                      showMyToast(
                                          context, value['error'], 'error');
                                    } else {
                                      showMyToast(
                                          context, value['msg'], 'success');
                                    }
                                    Navigator.of(context).pop();
                                  });
                                }

                                //  _showMyDialog();
                              },
                              child: Container(
                                width: 120,
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
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ),
                              ),
                            );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

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

  List<Widget> getfragment(
      Size devicesize, int currentindex, ProfileProvider data) {
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
                              data.userprofile.rating.toString(),
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
                              initialRating: double.parse(
                                  data.userprofile.rating!.toString()),
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
                              EasyLocalization.of(context)!
                                          .currentLocale!
                                          .languageCode ==
                                      'ar'
                                  ? data.userprofile.rates_count.toString() +
                                      ' مشترك '
                                  : data.userprofile.rates_count.toString() +
                                      ' subscriptor ',
                              style: TextStyle(
                                  color: Color.fromRGBO(194, 195, 196, 1),
                                  fontSize: 13),
                            ),
                          ],
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            _showMyDialog();
                          },
                          child: Container(
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
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
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
                                      data.userprofile.rates![index].comment)),
                              RatingBar.builder(
                                initialRating: double.parse(
                                    data.userprofile.rates![index].rating),
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
                      itemCount: data.userprofile.rates!.length,
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
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, childAspectRatio: 2 / 1.9),
          itemCount: data.userprofile.categories!.length,
          itemBuilder: (ctx, index) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => ServiceDetails(
                        service: data.userprofile.categories![index])));
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundImage: NetworkImage(
                        data.userprofile.categories![index].img!,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Flexible(
                      child: Text(
                        data.userprofile.categories![index].name!,
                        style: TextStyle(
                            color: MySettings.secondarycolor, fontSize: 14),
                      ),
                    )
                  ],
                ),
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
  void initState() {
    Future.delayed(Duration(milliseconds: 0), () {
      Provider.of<ProfileProvider>(context, listen: false).getUserProfile(
          context,
          EasyLocalization.of(context)!.currentLocale!.languageCode,
          widget.providerid);
    });
    (super.initState());
  }

  @override
  Widget build(BuildContext context) {
    final devicesize = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
          width: devicesize.width,
          height: devicesize.height,
          child: Consumer<ProfileProvider>(
            builder: (ctx, data, ch) {
              return data.isLoadingUserProfile
                  ? myLoadingWidget(context, MySettings.maincolor)
                  : data.getProfileError != null
                      ? Center(
                          child: Text(data.getProfileError!),
                        )
                      : ListView(
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
                                    options:
                                        CarouselOptions(viewportFraction: 1.0),
                                    items: data.userprofile.images!
                                        .map((item) => GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (ctx) {
                                                  return PhotoPreview(
                                                      item.img!);
                                                }));
                                              },
                                              child: Container(
                                                child: Center(
                                                    child: Image.network(
                                                        item.img!,
                                                        fit: BoxFit.cover,
                                                        width: 1000)),
                                              ),
                                            ))
                                        .toList(),
                                  )),
                                  Positioned(
                                    top: 40,
                                    child: Container(
                                      width: devicesize.width,
                                      height: 40,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: Row(
                                        children: [
                                          ChangeNotifierProvider.value(
                                              value: data.userprofile,
                                              child: Consumer<UserModel>(
                                                builder: (ctx, usermodel, ch) {
                                                  return IconButton(
                                                      onPressed: () async {
                                                        await usermodel.toggleFavourite(
                                                            providerId:
                                                                usermodel.id,
                                                            token: Provider.of<
                                                                        AuthProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .userModel
                                                                .token,
                                                            lang: EasyLocalization
                                                                    .of(context)!
                                                                .currentLocale!
                                                                .languageCode);
                                                        if (!usermodel
                                                            .isLiked!) {
                                                          Provider.of<ProfileProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .removeFromFavourite(
                                                                  usermodel
                                                                      .id!);
                                                        }
                                                      },
                                                      icon: usermodel.isLiked!
                                                          ? Icon(
                                                              Icons.favorite,
                                                              color: Colors.red,
                                                              size: 30,
                                                            )
                                                          : Icon(
                                                              Icons
                                                                  .favorite_border,
                                                              color:
                                                                  Colors.white,
                                                              size: 30,
                                                            ));
                                                },
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Column(
                                children: [
                                  Container(
                                    width: devicesize.width * .9,
                                    child: Text(
                                      data.userprofile.name!,
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
                                      Flexible(
                                        child: Text(
                                          data.userprofile.address!,
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 17),
                                        ),
                                      ),
                                      Container(
                                        width: 120,
                                        height: 30,
                                        decoration: BoxDecoration(
                                            color: MySettings.lightpink,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Center(
                                          child: Text(
                                            data.userprofile.subscription!,
                                            style: TextStyle(
                                                color:
                                                    MySettings.secondarycolor),
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
                                        'from  ${data.userprofile.fromTime!}  - to  ${data.userprofile.toTime!} ',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 17),
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
                                        border: Border.all(
                                            color: MySettings.maincolor),
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
                                  getfragment(
                                      devicesize, _newindex, data)[_newindex]
                                ],
                              ),
                            )
                          ],
                        );
            },
          )),
    );
  }
}
