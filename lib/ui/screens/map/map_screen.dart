import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shanbwrog/Settings/MySettings.dart';
import 'package:shanbwrog/ui/screens/map/search_map_place/search_map_place.dart';

class MapRegisteration extends StatefulWidget {
  @override
  _MapRegisterationState createState() => _MapRegisterationState();
}

class _MapRegisterationState extends State<MapRegisteration> {
  LatLng? pickedLocation = null;
  GoogleMapController? mapController;
  Completer<GoogleMapController> _mapController = Completer();
  final CameraPosition _initialCamera = CameraPosition(
    target: LatLng(24.718031154085143, 46.666135266423225),
    zoom: 14.0000,
  );
  String savedaddressname = '';

  @override
  Widget build(BuildContext context) {
    final devicesize = MediaQuery.of(context).size;

    Map<int, dynamic> myResp = getResponseve(context: context);
    return Scaffold(
        floatingActionButton: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: myResp[32],
              height: myResp[33],
              child: FloatingActionButton(
                backgroundColor:
                    savedaddressname == '' ? Colors.grey : MySettings.maincolor,
                onPressed: () {
                  if (savedaddressname == '') {
                  } else {
                    Navigator.of(context).pop({
                      'placename': savedaddressname,
                      'lat': pickedLocation!.latitude,
                      'long': pickedLocation!.longitude
                    });
                  }
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(myResp[11])),
                child: Text(tr('save')),
              ),
            )),
        body: Container(
          child: ListView(
            children: <Widget>[
              Container(
                height: devicesize.height,
                child: Stack(
                  children: <Widget>[
                    GoogleMap(
                      mapType: MapType.normal,
                      zoomGesturesEnabled: true,
                      gestureRecognizers:
                          <Factory<OneSequenceGestureRecognizer>>[
                        new Factory<OneSequenceGestureRecognizer>(
                          () => new EagerGestureRecognizer(),
                        ),
                      ].toSet(),
                      initialCameraPosition: _initialCamera,
                      onMapCreated: (GoogleMapController controller) {
                        _mapController.complete(controller);
                      },
                      onTap: (LatLng selectedlocation) async {
                        final coordinates = new Coordinates(
                            selectedlocation.latitude,
                            selectedlocation.longitude);
                        print(selectedlocation.latitude);
                        print(selectedlocation.longitude);

                        var addresses = await Geocoder.local
                            .findAddressesFromCoordinates(coordinates);
                        // final addresses = await Geocoder.google(
                        //         'AIzaSyCDzltRvdehaa-81Gh7T0JGW-s3x6igHMg',
                        //         language: 'ar')
                        //     .findAddressesFromCoordinates(coordinates);

                        final first = addresses.first;
                        setState(() {
                          pickedLocation = selectedlocation;
                          savedaddressname = first.addressLine;
                        });
                      },
                      markers: pickedLocation == null
                          ? {}
                          : {
                              Marker(
                                  markerId: MarkerId('mark'),
                                  position: pickedLocation!)
                            },
                    ),
                    Positioned(
                        top: (myResp[29]),
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.circular(myResp[30])),
                            margin:
                                EdgeInsets.symmetric(horizontal: (myResp[34])),
                            child: Container(
                              child: SearchMapPlaceWidget(
                                placeholder: tr('search'),
                                apiKey:
                                    'AIzaSyCDzltRvdehaa-81Gh7T0JGW-s3x6igHMg',
                                noPlacesErrorMessage: 'error',
                                noPlacesErrorMessageStyle:
                                    TextStyle(color: Colors.red),
                                searchHintStyle: TextStyle(
                                    color: Colors.black, fontSize: myResp[26]),
                                searchStyle: TextStyle(
                                  color: Colors.black,
                                ),
                                placesStyle: TextStyle(color: Colors.black),
                                language: 'ar',
                                icon: Icon(
                                  Icons.search,
                                ),
                                onSearch: (rsult, future) {},
                                onSelected: (result) async {
                                  final geolocation = await result.geolocation;
                                  final GoogleMapController controller =
                                      await _mapController.future;
                                  controller.animateCamera(
                                      CameraUpdate.newLatLng(
                                          geolocation!.coordinates));
                                  controller.animateCamera(
                                      CameraUpdate.newLatLngBounds(
                                          geolocation.bounds, 0));
                                },
                              ),
                            ))),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

Map<int, dynamic> getResponseve(
    {required BuildContext context,
    double wid = 0.0,
    double hieg = 0.0,
    bool? loca}) {
  Map<int, dynamic> myValues;
  double width = 0.0;
  double height = 0.0;
  if (wid > 0.0 && hieg > 0.0) {
    width = wid;
    height = hieg;
  } else {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
  }
  //final double height = MediaQuery.of(cont).size.height;
  //final String orient = MediaQuery.of(cont).orientation.toString(,

  /*
// on Genymotion

isSmall = width <= 330.0 ( width 320  Google Nexus S  480 x 800  )

isMedium 1 = width <= 410.0  ( width 360  Google Nexus 5  1080 x 1920  )

isMedium 2 = width <= 576.0  ( width 411  Google Nexus 6p  1440 x 2560  )

isNormal = width <= 768.0  ( width 600.938  Google Nexus 7  800 x 1280  )

isLarge = width <= 992.0  ( width 960.938  Sony Xperia Tablet Z  1920 x 1200  )

isXLarge = width <= 1500.0  ( width 1202  Google Nexus 10  2560 x 1600  )
*/

  final bool isSmall = width <= 330.0; // small screen with portrait Orientation
  final bool isMedium1 = width <=
      410.0; // small screen with landscape Orientation and normall screen with portrait Orientation
  final bool isMedium2 = width <=
      576.0; // small screen with landscape Orientation and normall screen with portrait Orientation
  final bool isNormal = width <=
      768.0; // large screen with portrait Orientation and normall screen with landscape Orientation
  final bool isLarge = width <=
      992.0; // large screen with landscape Orientation and Xlarge screen with portrait Orientation
  final bool isXlarge =
      width <= 1550.0; // Xlarge screen with landscape Orientation
  /*bool isEng;
  if(wid > 0.0 && hieg > 0.0){
    isEng = loca;
  } else {
    Locale mylocale = Localizations.localeOf(context);
    isEng = mylocale.languageCode.contains("en");
  }*/

  if (isSmall) {
    myValues = {
      1: 100.0, // 1 MyAppBar appBarHight
      2: 10.0, // 2 MyAppBar appBarPadding
      3: 20.0, // 3 MyAppBar Container margin top
      4: 25.0, // 4 MyAppBar IconButton iconSize
      5: 12.0, // 5 MyAppBar Text fontSize
      6: 35.0, // 6 MyAppBar SizedBox width
      7: 35.0, // 7 MyAppBar SizedBox height
      8: 12.0, // 8 ListView padding horizontal
      9: 20.0, // 9 ListView padding vertical
      10: 20.0, // 10 SizedBox height
      11: 12.0, // 11 Text fontSize
      12: 14.0, // 12 Text fontSize
      13: 14.0, // 13 Text fontSize
      14: 20.0, // 14 SizedBox height
      15: 0.0, // 15 FlatButton padding all
      16: 1.0, // 16 Text fontSize
      17: 0.0, // 17 SizedBox height
      18: 20.0, // 18 SizedBox height
      26: 16.0, // 26 Text fontSize
      27: 12.0, // 27 Text fontSize
      28: 14.0, // 28 Text fontSize
      29: 30.0, // 29 Container margin top
      30: 20.0, // 30 Container margin bottom
      31: 0.5, // 31 MyButton buttonWidth,
      34: 12.0, //margin of map search container
    };
  } else if (isMedium1) {
    myValues = {
      1: 100.0, // 1 MyAppBar appBarHight
      2: 10.0, // 2 MyAppBar appBarPadding
      3: 20.0, // 3 MyAppBar Container margin top
      4: 25.0, // 4 MyAppBar IconButton iconSize
      5: 12.0, // 5 MyAppBar Text fontSize
      6: 35.0, // 6 MyAppBar SizedBox width
      7: 35.0, // 7 MyAppBar SizedBox height
      8: 12.0, // 8 ListView padding horizontal
      9: 20.0, // 9 ListView padding vertical
      10: 20.0, // 10 SizedBox height
      11: 12.0, // 11 Text fontSize
      12: 14.0, // 12 Text fontSize
      13: 14.0, // 13 Text fontSize
      14: 20.0, // 14 SizedBox height
      15: 0.0, // 15 FlatButton padding all
      16: 14.0, // 16 Text fontSize
      17: 0.0, // 17 SizedBox height
      18: 20.0, // 18 SizedBox height
      26: 16.0, // 26 Text fontSize
      27: 12.0, // 27 Text fontSize
      28: 14.0, // 28 Text fontSize
      29: 30.0, // 29 Container margin top
      30: 20.0, // 30 Container margin bottom
      31: 0.5, // 31 MyButton buttonWidth
      32: 160.0, //width of floating action button
      33: 40.0, //height of floating action button
      34: 12.0, //margin of map search container
    };
  } else if (isMedium2) {
    myValues = {
      1: 100.0, // 1 MyAppBar appBarHight
      2: 10.0, // 2 MyAppBar appBarPadding
      3: 20.0, // 3 MyAppBar Container margin top
      4: 30.0, // 4 MyAppBar IconButton iconSize
      5: 16.0, // 5 MyAppBar Text fontSize
      6: 35.0, // 6 MyAppBar SizedBox width
      7: 35.0, // 7 MyAppBar SizedBox height
      8: 12.0, // 8 ListView padding horizontal
      9: 20.0, // 9 ListView padding vertical
      10: 20.0, // 10 SizedBox height
      11: 14.0, // 11 Text fontSize
      12: 16.0, // 12 Text fontSize
      13: 16.0, // 13 Text fontSize
      14: 20.0, // 14 SizedBox height
      15: 0.0, // 15 FlatButton padding all
      16: 16.0, // 16 Text fontSize
      17: 0.0, // 17 SizedBox height
      18: 20.0, // 18 SizedBox height
      26: 18.0, // 26 Text fontSize
      27: 14.0, // 27 Text fontSize
      28: 16.0, // 28 Text fontSize
      29: 30.0, // 29 Container margin top
      30: 20.0, // 30 Container margin bottom
      31: 0.5, // 31 MyButton buttonWidth
      32: 160.0, //width of floating action button
      33: 40.0, //height of floating action button
      34: 12.0, //margin of map search container
    };
  } else if (isNormal) {
    if (width > height) {
      myValues = {
        1: 100.0, // 1 MyAppBar appBarHight
        2: 10.0, // 2 MyAppBar appBarPadding
        3: 20.0, // 3 MyAppBar Container margin top
        4: 25.0, // 4 MyAppBar IconButton iconSize
        5: 12.0, // 5 MyAppBar Text fontSize
        6: 35.0, // 6 MyAppBar SizedBox width
        7: 35.0, // 7 MyAppBar SizedBox height
        8: 12.0, // 8 ListView padding horizontal
        9: 20.0, // 9 ListView padding vertical
        10: 20.0, // 10 SizedBox height
        11: 12.0, // 11 Text fontSize
        12: 14.0, // 12 Text fontSize
        13: 14.0, // 13 Text fontSize
        14: 20.0, // 14 SizedBox height
        15: 0.0, // 15 FlatButton padding all
        16: 14.0, // 16 Text fontSize
        17: 0.0, // 17 SizedBox height
        18: 20.0, // 18 SizedBox height
        26: 16.0, // 26 Text fontSize
        27: 12.0, // 27 Text fontSize
        28: 14.0, // 28 Text fontSize
        29: 30.0, // 29 Container margin top
        30: 20.0, // 30 Container margin bottom
        31: 0.5, // 31 MyButton buttonWidth
        32: 160.0, //width of floating action button
        33: 40.0, //height of floating action button,
        34: 28.0, //margin of map search container
      };
    } else {
      myValues = {
        1: 100.0, // 1 MyAppBar appBarHight
        2: 10.0, // 2 MyAppBar appBarPadding
        3: 20.0, // 3 MyAppBar Container margin top
        4: 35.0, // 4 MyAppBar IconButton iconSize
        5: 18.0, // 5 MyAppBar Text fontSize
        6: 35.0, // 6 MyAppBar SizedBox width
        7: 35.0, // 7 MyAppBar SizedBox height
        8: 12.0, // 8 ListView padding horizontal
        9: 20.0, // 9 ListView padding vertical
        10: 20.0, // 10 SizedBox height
        11: 16.0, // 11 Text fontSize
        12: 20.0, // 12 Text fontSize
        13: 20.0, // 13 Text fontSize
        14: 20.0, // 14 SizedBox height
        15: 0.0, // 15 FlatButton padding all
        16: 18.0, // 16 Text fontSize
        17: 0.0, // 17 SizedBox height
        18: 20.0, // 18 SizedBox height
        26: 20.0, // 26 Text fontSize
        27: 16.0, // 27 Text fontSize
        28: 18.0, // 28 Text fontSize
        29: 30.0, // 29 Container margin top
        30: 20.0, // 30 Container margin bottom
        31: 0.5, // 31 MyButton buttonWidth
        32: 160.0, //width of floating action button
        33: 40.0, //height of floating action button
        34: 28.0, //margin of map search container
      };
    }
  } else if (isLarge) {
    myValues = {
      1: 100.0, // 1 MyAppBar appBarHight
      2: 10.0, // 2 MyAppBar appBarPadding
      3: 20.0, // 3 MyAppBar Container margin top
      4: 35.0, // 4 MyAppBar IconButton iconSize
      5: 18.0, // 5 MyAppBar Text fontSize
      6: 35.0, // 6 MyAppBar SizedBox width
      7: 35.0, // 7 MyAppBar SizedBox height
      8: 12.0, // 8 ListView padding horizontal
      9: 20.0, // 9 ListView padding vertical
      10: 20.0, // 10 SizedBox height
      11: 16.0, // 11 Text fontSize
      12: 20.0, // 12 Text fontSize
      13: 20.0, // 13 Text fontSize
      14: 20.0, // 14 SizedBox height
      15: 0.0, // 15 FlatButton padding all
      16: 18.0, // 16 Text fontSize
      17: 0.0, // 17 SizedBox height
      18: 20.0, // 18 SizedBox height
      26: 20.0, // 26 Text fontSize
      27: 16.0, // 27 Text fontSize
      28: 18.0, // 28 Text fontSize
      29: 30.0, // 29 Container margin top
      30: 20.0, // 30 Container margin bottom
      31: 0.5, // 31 MyButton buttonWidth
      32: 160.0, //width of floating action button
      33: 40.0, //height of floating action button
      34: 42.0, //margin of map search container
    };
  } else if (isXlarge) {
    myValues = {
      1: 100.0, // 1 MyAppBar appBarHight
      2: 10.0, // 2 MyAppBar appBarPadding
      3: 20.0, // 3 MyAppBar Container margin top
      4: 35.0, // 4 MyAppBar IconButton iconSize
      5: 18.0, // 5 MyAppBar Text fontSize
      6: 35.0, // 6 MyAppBar SizedBox width
      7: 35.0, // 7 MyAppBar SizedBox height
      8: 12.0, // 8 ListView padding horizontal
      9: 20.0, // 9 ListView padding vertical
      10: 20.0, // 10 SizedBox height
      11: 16.0, // 11 Text fontSize
      12: 20.0, // 12 Text fontSize
      13: 20.0, // 13 Text fontSize
      14: 20.0, // 14 SizedBox height
      15: 0.0, // 15 FlatButton padding all
      16: 18.0, // 16 Text fontSize
      17: 0.0, // 17 SizedBox height
      18: 20.0, // 18 SizedBox height
      26: 20.0, // 26 Text fontSize
      27: 16.0, // 27 Text fontSize
      28: 18.0, // 28 Text fontSize
      29: 30.0, // 29 Container margin top
      30: 20.0, // 30 Container margin bottom
      31: 0.5, // 31 MyButton buttonWidth
      32: 160.0, //width of floating action button
      33: 40.0, //height of floating action button
      34: 58.0, //margin of map search container
    };
  } else {
    myValues = {
      1: 100.0, // 1 MyAppBar appBarHight
      2: 10.0, // 2 MyAppBar appBarPadding
      3: 20.0, // 3 MyAppBar Container margin top
      4: 35.0, // 4 MyAppBar IconButton iconSize
      5: 18.0, // 5 MyAppBar Text fontSize
      6: 35.0, // 6 MyAppBar SizedBox width
      7: 35.0, // 7 MyAppBar SizedBox height
      8: 12.0, // 8 ListView padding horizontal
      9: 20.0, // 9 ListView padding vertical
      10: 20.0, // 10 SizedBox height
      11: 16.0, // 11 Text fontSize
      12: 20.0, // 12 Text fontSize
      13: 20.0, // 13 Text fontSize
      14: 20.0, // 14 SizedBox height
      15: 0.0, // 15 FlatButton padding all
      16: 18.0, // 16 Text fontSize
      17: 0.0, // 17 SizedBox height
      18: 20.0, // 18 SizedBox height
      26: 20.0, // 26 Text fontSize
      27: 16.0, // 27 Text fontSize
      28: 18.0, // 28 Text fontSize
      29: 30.0, // 29 Container margin top
      30: 20.0, // 30 Container margin bottom
      31: 0.5, // 31 MyButton buttonWidth
      32: 160.0, //width of floating action button
      33: 40.0, //height of floating action button
      34: 58.0, //margin of map search container
    };
  }

  return myValues;
}
