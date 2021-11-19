import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:shanbwrog/Settings/MySettings.dart';
import 'package:shanbwrog/providers/search.dart';
import 'package:shanbwrog/ui/general/appbar.dart';
import 'package:shanbwrog/ui/screens/main/salonDetails.dart';
import 'package:shanbwrog/ui/widgets/myToast.dart';
import 'package:shanbwrog/ui/widgets/my_loading_widget.dart';

class ProvidersOfCategory extends StatefulWidget {
  int serviceid;

  ProvidersOfCategory(this.serviceid);

  @override
  _ProvidersOfCategoryState createState() => _ProvidersOfCategoryState();
}

class _ProvidersOfCategoryState extends State<ProvidersOfCategory> {
  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 0), () {
      Provider.of<SearchProvider>(context, listen: false)
          .getProvidersOfCategory(
              context,
              EasyLocalization.of(context)!.currentLocale!.languageCode,
              widget.serviceid);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final devicesize = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            NewAppbar(
              devicesize: devicesize,
              text: tr('providersofcategory'),
            ),
            SizedBox(
              height: 50,
            ),
            Consumer<SearchProvider>(
              builder: (ctx, data, ch) {
                return data.isloadingProvidersOfCategory
                    ? Center(child: myLoadingWidget(context, MySettings.maincolor))
                    : data.providersofcategory!.length == 0
                        ? Center(
                            child: Text(
                              tr('emptylist'),
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 19),
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: data.providersofcategory!.length,
                            itemBuilder: (ctx, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (ctx) => SalonDetailsScreen(data
                                          .providersofcategory![index].id!)));
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
                                            data.providersofcategory![index]
                                                .images![0].img!,
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
                                              data.providersofcategory![index]
                                                  .name!,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 19,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Spacer(),
                                            RatingBar.builder(
                                              initialRating: double.parse((data
                                                      .providersofcategory![
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
                                              data.providersofcategory![index]
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
                                                    BorderRadius.circular(15)),
                                            child: Center(
                                              child: Text(
                                                EasyLocalization.of(context)!
                                                            .currentLocale!
                                                            .languageCode ==
                                                        'ar'
                                                    ? data
                                                            .providersofcategory![
                                                                index]
                                                            .subscription! +
                                                        ' مشترك '
                                                    : 'Subscriptor' +
                                                        data
                                                            .providersofcategory![
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
                            });
              },
            ),
          ],
        ),
      ),
    ));
  }
}
