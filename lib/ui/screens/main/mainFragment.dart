import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:shanbwrog/Settings/MySettings.dart';
import 'package:shanbwrog/models/category.dart';
import 'package:shanbwrog/providers/Auth.dart';
import 'package:shanbwrog/providers/home.dart';
import 'package:shanbwrog/ui/screens/main/offer_details.dart';
import 'package:shanbwrog/ui/screens/main/providers_of_category.dart';
import 'package:shanbwrog/ui/screens/main/salonDetails.dart';
import 'package:shanbwrog/ui/screens/main/serviceDetails.dart';
import 'package:shanbwrog/ui/widgets/customButton.dart';
import 'package:shanbwrog/ui/widgets/formitem.dart';
import 'package:shanbwrog/ui/widgets/futurebuilder.dart';
import 'package:shanbwrog/ui/widgets/myToast.dart';
import 'package:shanbwrog/ui/widgets/my_loading_widget.dart';

class MainFragment extends StatefulWidget {
  @override
  _MainFragmentState createState() => _MainFragmentState();
}

class _MainFragmentState extends State<MainFragment> {
  int _newindex = 0;
  TextEditingController _price = TextEditingController();
  TextEditingController _rate = TextEditingController();
  var modalsheetFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 0), () {
      Provider.of<HomeProvider>(context, listen: false).getHomeDate(
          context, EasyLocalization.of(context)!.currentLocale!.languageCode);
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final devicesize = MediaQuery.of(context).size;
    final homeprovider = Provider.of<HomeProvider>(context, listen: false);

    return Container(
        width: devicesize.width,
        height: devicesize.height,
        child: Consumer<HomeProvider>(
          builder: (ctx, data, ch) {
            return data.isloadingHomeData
                ? myLoadingWidget(context, MySettings.maincolor)
                : data.homeerror != null
                    ? Center(
                        child: Text(data.homeerror!),
                      )
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
                                    ontap: () async {
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
                                      } else {
                                        final response =
                                            await Provider.of<HomeProvider>(
                                                    context,
                                                    listen: false)
                                                .getNearstProviders(
                                          context,
                                          EasyLocalization.of(context)!
                                              .currentLocale!
                                              .languageCode,
                                        );
                                        if (response['status'] == false) {
                                          showMyToast(context,
                                              response['error'], 'error');
                                        }
                                      }

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
                                      } else {
                                        showModalBottomSheet<void>(
                                            context: context,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                top: Radius.circular(20),
                                              ),
                                            ),
                                            clipBehavior:
                                                Clip.antiAliasWithSaveLayer,
                                            builder: (BuildContext context) {
                                              return Container(
                                                height: devicesize.height * .4,
                                                padding:
                                                    EdgeInsets.only(top: 30),
                                                decoration: BoxDecoration(),
                                                child: Form(
                                                  key: modalsheetFormKey,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Container(
                                                        width:
                                                            devicesize.width *
                                                                .8,
                                                        child:
                                                            DropdownButtonFormField(
                                                                isExpanded:
                                                                    true,
                                                                hint: Text(
                                                                    tr(
                                                                        'category'),
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .grey,
                                                                    )),
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize:
                                                                        19),
                                                                decoration: InputDecoration(
                                                                    contentPadding: devicesize.width < 768
                                                                        ? EdgeInsets.all(
                                                                            15)
                                                                        : EdgeInsets.all(
                                                                            24),
                                                                    filled:
                                                                        true,
                                                                    fillColor: Colors
                                                                        .white,
                                                                    errorBorder: OutlineInputBorder(
                                                                        borderSide: BorderSide(
                                                                            color: Colors
                                                                                .red),
                                                                        borderRadius: BorderRadius.circular(
                                                                            12)),
                                                                    enabledBorder: OutlineInputBorder(
                                                                        borderSide:
                                                                            BorderSide(color: Colors.grey.withOpacity(.8)),
                                                                        borderRadius: BorderRadius.circular(12))),
                                                                value: homeprovider.selectedCategory,
                                                                items: homeprovider.categories
                                                                    .map<DropdownMenuItem<Category>>((item) => DropdownMenuItem(
                                                                          child:
                                                                              Text(
                                                                            item.name!,
                                                                            softWrap:
                                                                                true,
                                                                          ),
                                                                          value:
                                                                              item,
                                                                        ))
                                                                    .toList(),
                                                                onChanged: (Category? category) {
                                                                  Provider.of<HomeProvider>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .selectedCategory = category;
                                                                },
                                                                validator: (value) {
                                                                  if (value ==
                                                                      null) {
                                                                    return tr(
                                                                        'requiredfield');
                                                                  }
                                                                }),
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                      FormItemWidget(
                                                          fill: true,
                                                          fillingcolor:
                                                              Colors.white,
                                                          bordercolor:
                                                              Colors.grey,
                                                          enablingborder: true,
                                                          borderRadious: 12,
                                                          keyboardtype:
                                                              TextInputType
                                                                  .number,
                                                          label: tr('price'),
                                                          labelStyle: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 19),
                                                          textEditingController:
                                                              _price,
                                                          validation:
                                                              (String? value) {
                                                            if (value == null ||
                                                                value.isEmpty) {
                                                              return tr(
                                                                  'requiredfield');
                                                            }
                                                          }),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                      FormItemWidget(
                                                          fill: true,
                                                          fillingcolor:
                                                              Colors.white,
                                                          bordercolor:
                                                              Colors.grey,
                                                          enablingborder: true,
                                                          borderRadious: 12,
                                                          label:
                                                              tr('modalrate'),
                                                          labelStyle: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 19),
                                                          textEditingController:
                                                              _rate,
                                                          validation:
                                                              (String? value) {
                                                            if (value == null ||
                                                                value.isEmpty) {
                                                              return tr(
                                                                  'requiredfield');
                                                            }
                                                          }),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                      Consumer<HomeProvider>(
                                                        builder:
                                                            (ctx, data, ch) {
                                                          return data
                                                                  .isloadingsearch
                                                              ? myLoadingWidget(
                                                                  context,
                                                                  MySettings
                                                                      .maincolor)
                                                              : CustomButton(
                                                                  tr('filter'),
                                                                  () async {
                                                                  FocusScope.of(
                                                                          context)
                                                                      .unfocus();

                                                                  if (modalsheetFormKey
                                                                      .currentState!
                                                                      .validate()) {
                                                                    final response = await Provider.of<HomeProvider>(context, listen: false).search(
                                                                        context,
                                                                        EasyLocalization.of(context)!
                                                                            .currentLocale!
                                                                            .languageCode,
                                                                        '',
                                                                        filter:
                                                                            true,
                                                                        category_id: data
                                                                            .selectedCategory!
                                                                            .id,
                                                                        rate: _rate
                                                                            .text,
                                                                        price: _price
                                                                            .text);
                                                                    if (response[
                                                                            'status'] ==
                                                                        false) {
                                                                      showMyToast(
                                                                          context,
                                                                          response[
                                                                              'error'],
                                                                          'error');
                                                                    } else {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    }

                                                                    // Navigator.of(context).push(
                                                                    //     MaterialPageRoute(builder: (ctx) {
                                                                    //   return MainActivity(
                                                                    //     usertype: widget.usertype,
                                                                    //   );
                                                                    // }));
                                                                  }
                                                                });
                                                        },
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            });
                                      }

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
                              // Row(
                              //   children: [
                              //     Text(
                              //       tr('showall'),
                              //       style: TextStyle(
                              //         color: MySettings.lightblue,
                              //         fontSize: 19,
                              //       ),
                              //     ),
                              //     SizedBox(
                              //       width: 4,
                              //     ),
                              //     Image.asset(
                              //       'assets/icons/more.png',
                              //       width: 12,
                              //       height: 12,
                              //       fit: BoxFit.fill,
                              //     )
                              //   ],
                              // )
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
                                    duration:
                                        const Duration(milliseconds: 1000),
                                    child: SlideAnimation(
                                      horizontalOffset: 140.0,
                                      child: FlipAnimation(
                                        flipAxis: FlipAxis.x,
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(MaterialPageRoute(
                                                builder: (ctx) => OfferDetails(
                                                    offer: homeprovider
                                                            .serviceprovideroffers[
                                                        index],
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
                                                    width:
                                                        devicesize.width * .7,
                                                    height: devicesize.width >
                                                            768
                                                        ? devicesize.height * .4
                                                        : devicesize.height *
                                                            .13,
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
                                                    width:
                                                        devicesize.width * .7,
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
                                                                color: Colors
                                                                    .black,
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
                                                    width:
                                                        devicesize.width * .7,
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
                              // Row(
                              //   children: [
                              //     Text(
                              //       tr('showall'),
                              //       style: TextStyle(
                              //         color: MySettings.lightblue,
                              //         fontSize: 19,
                              //       ),
                              //     ),
                              //     SizedBox(
                              //       width: 4,
                              //     ),
                              //     Image.asset(
                              //       'assets/icons/more.png',
                              //       width: 12,
                              //       height: 12,
                              //       fit: BoxFit.fill,
                              //     )
                              //   ],
                              // )
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
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (ctx) =>
                                                ProvidersOfCategory(data
                                                    .categories[index].id!)));
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                          radius: 28,
                                          backgroundImage: NetworkImage(
                                            data.categories[index].img!,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Flexible(
                                          child: Text(
                                            data.categories[index].name!,
                                            style: TextStyle(
                                                color:
                                                    MySettings.secondarycolor,
                                                fontSize: 14),
                                          ),
                                        )
                                      ],
                                    ),
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
                              // Row(
                              //   children: [
                              //     Text(
                              //       tr('showall'),
                              //       style: TextStyle(
                              //         color: MySettings.lightblue,
                              //         fontSize: 19,
                              //       ),
                              //     ),
                              //     SizedBox(
                              //       width: 4,
                              //     ),
                              //     Image.asset(
                              //       'assets/icons/more.png',
                              //       width: 12,
                              //       height: 12,
                              //       fit: BoxFit.fill,
                              //     )
                              //   ],
                              // )
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
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (ctx) =>
                                                SalonDetailsScreen(homeprovider
                                                    .serviceproviders[index]
                                                    .id!)));
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
                                              homeprovider
                                                  .serviceproviders[index]
                                                  .images![0]
                                                  .img!,
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
                                                    fontWeight:
                                                        FontWeight.w600),
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
                                            Expanded(
                                              child: Text(
                                                homeprovider
                                                    .serviceproviders[index]
                                                    .address!,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 17),
                                              ),
                                            ),
                                            Container(
                                              width: 120,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                  color: MySettings.lightpink,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              child: Center(
                                                child: Text(
                                                  EasyLocalization.of(context)!
                                                              .currentLocale!
                                                              .languageCode ==
                                                          'ar'
                                                      ? data
                                                              .serviceproviders[
                                                                  index]
                                                              .subscription! +
                                                          ' مشترك '
                                                      : 'Subscriptor' +
                                                          data
                                                              .serviceproviders[
                                                                  index]
                                                              .subscription!,
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
