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

class SearchFragment extends StatefulWidget {
  @override
  _SearchFragmentState createState() => _SearchFragmentState();
}

class _SearchFragmentState extends State<SearchFragment> {
  TextEditingController _searchController = TextEditingController();

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
              text: tr('search'),
              allowBack: false,
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              width: devicesize.width * .9,
              padding: EdgeInsets.only(top: 8, right: 8, left: 10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                  color: MySettings.lightgrey,
                  borderRadius: BorderRadius.circular(22)),
              child: Row(
                children: [
                  Flexible(
                      child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: tr('searchwhatyouwant'),
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 15)),
                  )),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: GestureDetector(
                        onTap: () async {
                          await Provider.of<SearchProvider>(context,
                                  listen: false)
                              .search(
                                  context,
                                  EasyLocalization.of(context)!
                                      .currentLocale!
                                      .languageCode,
                                  _searchController.text)
                              .then((value) {
                            if (value['status'] == false) {
                              showMyToast(context, value['error'], 'error');
                            }
                          });
                        },
                        child: Image.asset(
                          'assets/icons/search.png',
                          color: MySettings.secondarycolor,
                        ),
                      ))
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Consumer<SearchProvider>(
              builder: (ctx, data, ch) {
                return data.isloadingsearch == false &&
                        data.searchedProvider == null &&
                        data.searcherror == null
                    ? Center(
                        child: Text(
                          'نتائج البحث',
                          style: TextStyle(color: Colors.grey, fontSize: 19),
                        ),
                      )
                    : data.isloadingsearch
                        ? myLoadingWidget(context, MySettings.maincolor)
                        : data.searchedProvider!.length == 0
                            ? Center(
                                child: Text(
                                  'لا يوجد بيانات مطابقه لطلب البحث',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 19),
                                ),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: data.searchedProvider!.length,
                                itemBuilder: (ctx, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (ctx) =>
                                                  SalonDetailsScreen(data
                                                      .searchedProvider![index]
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
                                                data.searchedProvider![index]
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
                                                  data.searchedProvider![index]
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
                                                      (data
                                                              .searchedProvider![
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
                                                  data.searchedProvider![index]
                                                      .address!,
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                                    EasyLocalization.of(
                                                                    context)!
                                                                .currentLocale!
                                                                .languageCode ==
                                                            'ar'
                                                        ? data
                                                                .searchedProvider![
                                                                    index]
                                                                .subscription! +
                                                            ' مشترك '
                                                        : 'Subscriptor' +
                                                            data
                                                                .searchedProvider![
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
