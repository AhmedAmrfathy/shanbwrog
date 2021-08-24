import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:shanbwrog/Settings/MySettings.dart';
import 'package:shanbwrog/providers/home.dart';
import 'package:shanbwrog/ui/screens/main/salonDetails.dart';

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
      child: ListView(
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                    : devicesize.height * .24,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: homeprovider.serviceprovideroffers.length,
                    itemBuilder: (ctx, index) {
                      return Container(
                        margin: EdgeInsets.only(left: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: devicesize.width * .7,
                              height: devicesize.width > 768
                                  ? devicesize.height * .4
                                  : devicesize.height * .13,
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                child: Image.network(
                                  homeprovider
                                      .serviceprovideroffers[index].image!,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: devicesize.width * .72,
                              child: Row(
                                children: [
                                  Text(
                                    homeprovider
                                        .serviceprovideroffers[index].title!,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 17),
                                  ),
                                  Spacer(),
                                  Text(
                                    homeprovider
                                        .serviceprovideroffers[index].priceB!,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                        decoration: TextDecoration.lineThrough),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    homeprovider
                                        .serviceprovideroffers[index].priceA!,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: MySettings.secondarycolor,
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
                              child: Text(
                                homeprovider.serviceprovideroffers[index].desc!,
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 17),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              )
            ],
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
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, childAspectRatio: 2 / 1.9),
              itemCount: 8,
              itemBuilder: (ctx, index) {
                return Column(
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
              itemCount: homeprovider.availableservices.length,
              itemBuilder: (ctx, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => SalonDetailsScreen()));
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: devicesize.width * .9,
                          height: devicesize.width > 768
                              ? devicesize.height * .5
                              : devicesize.height * .2,
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            child: Image.network(
                              homeprovider.availableservices[index].image!,
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
                                homeprovider.availableservices[index].title!,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 19,
                                    fontWeight: FontWeight.w600),
                              ),
                              Spacer(),
                              RatingBar.builder(
                                initialRating: 3,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemSize: 18,
                                itemBuilder: (context, _) => Image.asset(
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
                              'المنصوره احمد ماهر شارع الصفا',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 17),
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
                                  style: TextStyle(
                                      color: MySettings.secondarycolor),
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
      ),
    );
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
                children: [
                  Text(
                    text!,
                    style: TextStyle(
                        color: currentIndex == newIndex
                            ? Colors.white
                            : MySettings.secondarycolor,
                        fontSize: 17),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Image.asset(
                    'assets/icons/filter.png',
                    width: 20,
                    height: 20,
                    fit: BoxFit.fill,
                    color: currentIndex == newIndex
                        ? Colors.white
                        : MySettings.secondarycolor,
                  ),
                ],
              )
            : Center(
                child: Text(
                  text!,
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
