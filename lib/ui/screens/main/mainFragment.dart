import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:shanbwrog/Settings/MySettings.dart';
import 'package:shanbwrog/providers/home.dart';
import 'package:shanbwrog/ui/screens/main/offer_details.dart';
import 'package:shanbwrog/ui/screens/main/salonDetails.dart';
import 'package:shanbwrog/ui/screens/main/serviceDetails.dart';
import 'package:shanbwrog/ui/widgets/futurebuilder.dart';
import 'package:shanbwrog/ui/widgets/my_loading_widget.dart';

class MainFragment extends StatefulWidget {
  @override
  _MainFragmentState createState() => _MainFragmentState();
}

class _MainFragmentState extends State<MainFragment> {
  int _newindex = 0;

  @override
  Widget build(BuildContext context) {
    final devicesize = MediaQuery.of(context).size;
    final homeprovider = Provider.of<HomeProvider>(context, listen: false);

    return Container(
        width: devicesize.width,
        height: devicesize.height,
        child: ApiFutureBuilder(
          future: Provider.of<HomeProvider>(context, listen: false).getHomeDate(
              context,
              EasyLocalization.of(context)!.currentLocale!.languageCode),
          consumer: Consumer<HomeProvider>(
            builder: (ctx, data, ch) {
              return data.isloadingHomeData
                  ? myLoadingWidget(context, MySettings.maincolor)
                  : ListView(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: devicesize.width * .65,
                          height: 50,
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
                                  text: tr('salonat'),
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
                                  text: tr('nearst'),
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
                                  text: tr('classto'),
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
                        Row(
                          children: [
                            Text(
                              tr('providersoffers'),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            Row(
                              children: [
                                Text(
                                  tr('showall'),
                                  style: TextStyle(
                                    color: MySettings.lightblue,
                                    fontSize: 19,
                                  ),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Image.asset(
                                  'assets/icons/more.png',
                                  width: 12,
                                  height: 12,
                                  fit: BoxFit.fill,
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: devicesize.width,
                          height: devicesize.width > 768
                              ? devicesize.height * .67
                              : devicesize.height * .27,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  homeprovider.serviceprovideroffers.length,
                              itemBuilder: (ctx, index) {
                                return AnimationConfiguration.staggeredList(
                                  position: index,
                                  duration: const Duration(milliseconds: 1000),
                                  child: SlideAnimation(
                                    horizontalOffset: 140.0,
                                    child: FlipAnimation(
                                      flipAxis: FlipAxis.x,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (ctx) => OfferDetails(
                                                      offerId: homeprovider
                                                          .serviceprovideroffers[
                                                              index]
                                                          .id,
                                                      categoryid: homeprovider
                                                          .serviceprovideroffers[
                                                              index]
                                                          .categoryId)));
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(left: 15),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: devicesize.width * .7,
                                                  height: devicesize.width > 768
                                                      ? devicesize.height * .4
                                                      : devicesize.height * .13,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                12)),
                                                    child: Image.network(
                                                      homeprovider
                                                          .serviceprovideroffers[
                                                              index]
                                                          .img!,
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Container(
                                                  width: devicesize.width * .7,
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 3,
                                                        child: Text(
                                                          homeprovider
                                                              .serviceprovideroffers[
                                                                  index]
                                                              .title!,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 17),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          homeprovider
                                                              .serviceprovideroffers[
                                                                  index]
                                                              .oldPrice!,
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color:
                                                                  Colors.grey,
                                                              decoration:
                                                                  TextDecoration
                                                                      .lineThrough),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 4,
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          homeprovider
                                                              .serviceprovideroffers[
                                                                  index]
                                                              .price!,
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            color: MySettings
                                                                .secondarycolor,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 15,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                SizedBox(
                                                  width: devicesize.width * .7,
                                                  height: 30,
                                                  child: FittedBox(
                                                    fit: BoxFit.contain,
                                                    child: Text(
                                                      homeprovider
                                                          .serviceprovideroffers[
                                                              index]
                                                          .details!,
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 17),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                        Row(
                          children: [
                            Text(
                              tr('availableservices'),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            Row(
                              children: [
                                Text(
                                  tr('showall'),
                                  style: TextStyle(
                                    color: MySettings.lightblue,
                                    fontSize: 19,
                                  ),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Image.asset(
                                  'assets/icons/more.png',
                                  width: 12,
                                  height: 12,
                                  fit: BoxFit.fill,
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    childAspectRatio: 2 / 1.9),
                            itemCount: data.categories.length,
                            itemBuilder: (ctx, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (ctx) => ServiceDetails()));
                                },
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 32,
                                      backgroundImage: NetworkImage(
                                        data.categories[index].img!,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      data.categories[index].name!,
                                      style: TextStyle(
                                          color: MySettings.secondarycolor,
                                          fontSize: 16),
                                    )
                                  ],
                                ),
                              );
                            }),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text(
                              tr('servicesproviders'),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            Row(
                              children: [
                                Text(
                                  tr('showall'),
                                  style: TextStyle(
                                    color: MySettings.lightblue,
                                    fontSize: 19,
                                  ),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Image.asset(
                                  'assets/icons/more.png',
                                  width: 12,
                                  height: 12,
                                  fit: BoxFit.fill,
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: homeprovider.serviceproviders.length,
                            itemBuilder: (ctx, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (ctx) => SalonDetailsScreen()));
                                },
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: devicesize.width * .9,
                                        height: devicesize.width > 768
                                            ? devicesize.height * .5
                                            : devicesize.height * .2,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12)),
                                          child: Image.network(
                                            homeprovider.serviceproviders[index]
                                                .avatar!,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        width: devicesize.width * .9,
                                        child: Row(
                                          children: [
                                            Text(
                                              homeprovider
                                                  .serviceproviders[index]
                                                  .name!,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 19,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Spacer(),
                                            RatingBar.builder(
                                              initialRating: double.parse(
                                                  (homeprovider
                                                          .serviceproviders[
                                                              index]
                                                          .rating!)
                                                      .toString()),
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemCount: 5,
                                              itemSize: 18,
                                              itemBuilder: (context, _) =>
                                                  Image.asset(
                                                'assets/icons/star.png',
                                              ),
                                              onRatingUpdate: (rating) {
                                                print(rating);
                                              },
                                            ),
                                          ],
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
                                            homeprovider.serviceproviders[index]
                                                .address!,
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 17),
                                          ),
                                          Spacer(),
                                          Container(
                                            width: 120,
                                            height: 30,
                                            decoration: BoxDecoration(
                                                color: MySettings.lightpink,
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            child: Center(
                                              child: Text(
                                                '???',
                                                style: TextStyle(
                                                    color: MySettings
                                                        .secondarycolor),
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            })
                      ],
                    );
            },
          ),
        ));
  }
}

class SelectionItem extends StatelessWidget {
  final int? currentIndex;
  final int? newIndex;
  final String? text;
  final Widget? extraWidget;
  final Function? ontap;

  SelectionItem(
      {this.currentIndex,
      this.newIndex,
      this.text,
      this.extraWidget,
      this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ontap!();
      },
      child: Container(
        decoration: BoxDecoration(
            color: currentIndex == newIndex
                ? MySettings.secondarycolor
                : Colors.white10,
            borderRadius:
                currentIndex == newIndex ? BorderRadius.circular(8) : null),
        padding: text == tr('classto') ? EdgeInsets.all(7) : null,
        child: text == tr('classto')
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: currentIndex == newIndex
                            ? Colors.white
                            : MySettings.secondarycolor,
                        fontSize: 17),
                  ),
                  // SizedBox(
                  //   width: 5,
                  // ),
                  // Image.asset(
                  //   'assets/icons/filter.png',
                  //   width: 20,
                  //   height: 20,
                  //   fit: BoxFit.fill,
                  //   color: currentIndex == newIndex
                  //       ? Colors.white
                  //       : MySettings.secondarycolor,
                  // ),
                ],
              )
            : Center(
                child: Text(
                  text!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: currentIndex == newIndex
                          ? Colors.white
                          : MySettings.secondarycolor,
                      fontSize: 17),
                ),
              ),
      ),
    );
  }
}
