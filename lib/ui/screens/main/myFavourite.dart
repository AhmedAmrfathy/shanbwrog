import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:shanbwrog/Settings/MySettings.dart';
import 'package:shanbwrog/providers/Auth.dart';
import 'package:shanbwrog/providers/home.dart';
import 'package:shanbwrog/providers/profile.dart';
import 'package:shanbwrog/ui/general/appbar.dart';
import 'package:shanbwrog/ui/screens/main/salonDetails.dart';
import 'package:shanbwrog/ui/widgets/my_loading_widget.dart';

class MyFavourite extends StatefulWidget {
  @override
  _MyFavouriteState createState() => _MyFavouriteState();
}

class _MyFavouriteState extends State<MyFavourite> {
  @override
  void initState() {
    if (Provider.of<AuthProvider>(context, listen: false).userModel.token ==
            null ||
        Provider.of<AuthProvider>(context, listen: false).userModel.token ==
            '') {
    } else {
      Future.delayed(Duration(milliseconds: 0), () {
        Provider.of<ProfileProvider>(context, listen: false).getFvouriteUsers(
          context,
          EasyLocalization.of(context)!.currentLocale!.languageCode,
        );
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final devicesize = MediaQuery.of(context).size;
    final auth = Provider.of<AuthProvider>(context, listen: false);

    return SafeArea(
      child: Scaffold(
          body: auth.userModel == null || auth.userModel.token == null
              ? Center(
                  child: Text(tr('loginfirst')),
                )
              : Consumer<ProfileProvider>(
                  builder: (ctx, data, ch) {
                    return data.isLoadingFavouriteUsers
                        ? myLoadingWidget(context, MySettings.maincolor)
                        : data.isLoadingFavouriteUsersError != null
                            ? Center(
                                child: Text(data.isLoadingFavouriteUsersError!),
                              )
                            : ListView(
                                padding: EdgeInsets.all(20),
                                children: [
                                  NewAppbar(
                                    devicesize: devicesize,
                                    text: tr('favourite'),
                                    allowBack: false,
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: data.favouriteUsers.length,
                                      itemBuilder: (ctx, index) {
                                        return AnimationConfiguration
                                            .staggeredList(
                                          position: index,
                                          duration: const Duration(
                                              milliseconds: 1000),
                                          child: SlideAnimation(
                                            verticalOffset: 50.0,
                                            child: FadeInAnimation(
                                              duration:
                                                  Duration(milliseconds: 1000),
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (ctx) =>
                                                              SalonDetailsScreen(data
                                                                  .favouriteUsers[
                                                                      index]
                                                                  .id!)));
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 20),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        width:
                                                            devicesize.width *
                                                                .9,
                                                        height: devicesize
                                                                    .width >
                                                                768
                                                            ? devicesize
                                                                    .height *
                                                                .5
                                                            : devicesize
                                                                    .height *
                                                                .2,
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          12)),
                                                          child: Image.network(
                                                            data
                                                                .favouriteUsers[
                                                                    index]
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
                                                        width:
                                                            devicesize.width *
                                                                .9,
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              data
                                                                  .favouriteUsers[
                                                                      index]
                                                                  .name!,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 19,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                            Spacer(),
                                                            RatingBar.builder(
                                                              initialRating: 3,
                                                              direction: Axis
                                                                  .horizontal,
                                                              allowHalfRating:
                                                                  true,
                                                              itemCount: 5,
                                                              itemSize: 18,
                                                              itemBuilder:
                                                                  (context,
                                                                          _) =>
                                                                      Image
                                                                          .asset(
                                                                'assets/icons/star.png',
                                                              ),
                                                              onRatingUpdate:
                                                                  (rating) {
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
                                                            Icons
                                                                .location_on_sharp,
                                                            color: Colors.grey,
                                                          ),
                                                          SizedBox(
                                                            width: 4,
                                                          ),
                                                          Flexible(
                                                            child: Text(
                                                              data
                                                                  .favouriteUsers[
                                                                      index]
                                                                  .address!,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: 17),
                                                            ),
                                                          ),
                                                          // Container(
                                                          //   width: 120,
                                                          //   height: 30,
                                                          //   decoration: BoxDecoration(
                                                          //       color: MySettings.lightpink,
                                                          //       borderRadius:
                                                          //           BorderRadius.circular(
                                                          //               15)),
                                                          //   child: Center(
                                                          //     child: Text(
                                                          //       EasyLocalization.of(
                                                          //                       context)!
                                                          //                   .currentLocale!
                                                          //                   .languageCode ==
                                                          //               'ar'
                                                          //           ? data
                                                          //                   .favouriteUsers[
                                                          //                       index]
                                                          //                   .subscription! +
                                                          //               ' مشترك '
                                                          //           : 'Subscriptor' +
                                                          //               data
                                                          //                   .favouriteUsers[
                                                          //                       index]
                                                          //                   .subscription!,
                                                          //       style: TextStyle(
                                                          //           color: MySettings
                                                          //               .secondarycolor),
                                                          //     ),
                                                          //   ),
                                                          // )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      })
                                ],
                              );
                  },
                )),
    );
  }
}
