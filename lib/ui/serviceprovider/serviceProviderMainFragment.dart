import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shanbwrog/Settings/MySettings.dart';
import 'package:shanbwrog/providers/home.dart';
import 'package:shanbwrog/ui/screens/main/serviceDetails.dart';
import 'package:shanbwrog/ui/serviceprovider/addOffer.dart';
import 'package:shanbwrog/ui/serviceprovider/addService.dart';
import 'package:shanbwrog/ui/serviceprovider/editOffer.dart';

class ServiceProviderMainFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final devicesize = MediaQuery.of(context).size;
    final homeprovider = Provider.of<HomeProvider>(context, listen: false);

    return ListView(
      padding: EdgeInsets.all(20),
      children: [
        Row(
          children: [
            Text(
              tr('myoffers'),
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 19,
                  fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Row(
              children: [
                GestureDetector(onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                    return AddOffer();
                  }));
                },
                  child: Text(
                    tr('addoffer'),
                    style: TextStyle(
                      color: MySettings.lightblue,
                      fontSize: 19,
                    ),
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
              : devicesize.height * .26,
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
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              child: Image.network(
                                homeprovider
                                    .serviceprovideroffers[index].img!,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Positioned(
                                top: 10,
                                right: 10,
                                child: Column(
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 20,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12)),
                                          color:
                                              Color.fromRGBO(255, 176, 72, 1)),
                                      child: Center(
                                        child: FittedBox(
                                          fit: BoxFit.cover,
                                          child: Text(
                                            tr('edit'),
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      width: 60,
                                      height: 20,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12)),
                                          color:
                                              Color.fromRGBO(255, 78, 78, 1)),
                                      child: Center(
                                        child: FittedBox(
                                          fit: BoxFit.cover,
                                          child: Text(
                                            tr('delete'),
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ))
                          ],
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
                                    .serviceprovideroffers[index].title!,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 17),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Text(
                                homeprovider
                                    .serviceprovideroffers[index].price!,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough),
                              ),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Expanded(
                              child: Text(
                                homeprovider
                                    .serviceprovideroffers[index].oldPrice!,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: MySettings.secondarycolor,
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
                          fit: BoxFit.fill,
                          child: Text(
                            homeprovider.serviceprovideroffers[index].details!,
                            style: TextStyle(color: Colors.grey, fontSize: 17),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),
        Text(
          tr('myservices'),
          style: TextStyle(
              color: Colors.black, fontSize: 19, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 14,
        ),
        GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, childAspectRatio: 2 / 2.9),
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
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (ctx) {
                          return EditOffer();
                        }));
                      },
                      child: Container(
                        width: 60,
                        height: 20,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            color: Color.fromRGBO(255, 176, 72, 1)),
                        child: Center(
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: Text(
                              tr('edit'),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 60,
                        height: 20,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            color: Color.fromRGBO(255, 78, 78, 1)),
                        child: Center(
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: Text(
                              tr('delete'),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                    return AddService();
                  }));
                },
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromRGBO(60, 194, 118, 1)),
                  child: Center(
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
