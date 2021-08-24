import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:shanbwrog/Settings/MySettings.dart';
import 'package:shanbwrog/providers/home.dart';
import 'package:shanbwrog/ui/general/appbar.dart';
import 'package:shanbwrog/ui/screens/main/salonDetails.dart';

class MyFavourite extends StatefulWidget {
  @override
  _MyFavouriteState createState() => _MyFavouriteState();
}

class _MyFavouriteState extends State<MyFavourite> {
  @override
  Widget build(BuildContext context) {
    final devicesize = MediaQuery.of(context).size;
    final homeprovider = Provider.of<HomeProvider>(context, listen: false);

    return Scaffold(
      body: ListView(padding: EdgeInsets.all(20),
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
                          height:devicesize.width>768?devicesize.height*.5: devicesize.height * .2,
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
