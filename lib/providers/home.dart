import 'package:flutter/cupertino.dart';
import 'package:shanbwrog/Settings/MySettings.dart';
import 'package:shanbwrog/models/category.dart';
import 'package:shanbwrog/models/serviceProviderOffer.dart';
import 'package:shanbwrog/models/userModel.dart';
import 'package:shanbwrog/server/dionetwork.dart';
import 'package:shanbwrog/server/endpoints.dart';

class HomeProvider with ChangeNotifier {
  String token = '';
  bool isloadingHomeData = false;
  bool isloadingofferdetails = false;
  bool isloadingcategorydetails = false;

  void update({
    String? newtoken,
  }) {
    token = newtoken!;
  }

  List<ServiceProviderOffer> availableservices = [];
  List<ServiceProviderOffer> serviceprovideroffers = [];
  ServiceProviderOffer serviceProviderOfferDetails = ServiceProviderOffer();
  List<Category> categories = [];
  Category categoryDetails = Category();
  List<UserModel> serviceproviders = [];

  Future<Map<String, dynamic>> getHomeDate(
      BuildContext context, String lang) async {
    Future.delayed(Duration(microseconds: 3), () {
      isloadingHomeData = true;
      notifyListeners();
    });
    Map<String, dynamic> headers = {
      "Accept-Language": lang,
      "Authorization": token
    };
    Map<dynamic, dynamic> response = await dioNetWork(
        appLanguage: lang,
        dioHeaders: headers,
        methodType: 'get',
        netWorkWorking: MySettings.netWorkWorking(),
        url: EndPoints.baseurl + EndPoints.segments['gethomedata']);
    isloadingHomeData = false;
    notifyListeners();
    if (response['status'] == false) {
      return {'status': false, 'error': response['msg']};
    } else {
      categories = (response['data']['data']['categories'] as List)
          .map((e) => Category.fromJson(e))
          .toList();
      serviceprovideroffers = (response['data']['data']['offers'] as List)
          .map((e) => ServiceProviderOffer.fromJson(e))
          .toList();
      serviceproviders = (response['data']['data']['users'] as List)
          .map((e) => UserModel.fromJson(e))
          .toList();
      notifyListeners();
      return {
        'status': true,
      };
    }
  }

  Future<Map<String, dynamic>> getserviceProviderOfferDetails(
      BuildContext context, String lang, int offerId) async {
    Future.delayed(Duration(microseconds: 3), () {
      isloadingofferdetails = true;
      notifyListeners();
    });
    Map<String, dynamic> headers = {
      "Accept-Language": lang,
      "Authorization": token
    };
    Map<dynamic, dynamic> response = await dioNetWork(
        appLanguage: lang,
        dioHeaders: headers,
        methodType: 'get',
        netWorkWorking: MySettings.netWorkWorking(),
        url: EndPoints.baseurl +
            EndPoints.segments['offerdetails'] +
            offerId.toString());
    isloadingofferdetails = false;
    notifyListeners();
    if (response['status'] == false) {
      return {'status': false, 'error': response['msg']};
    } else {
      serviceProviderOfferDetails =
          ServiceProviderOffer.fromJson(response['data']['data']);
      notifyListeners();
      return {
        'status': true,
      };
    }
  }

  Future<Map<String, dynamic>> getCategoryDetails(
      BuildContext context, String lang, int categorydetails) async {
    Future.delayed(Duration(microseconds: 3), () {
      isloadingcategorydetails = true;
      notifyListeners();
    });
    Map<String, dynamic> headers = {
      "Accept-Language": lang,
      "Authorization": token
    };
    Map<dynamic, dynamic> response = await dioNetWork(
        appLanguage: lang,
        dioHeaders: headers,
        methodType: 'get',
        netWorkWorking: MySettings.netWorkWorking(),
        url: EndPoints.baseurl +
            EndPoints.segments['categorydetails'] +
            categoryDetails.toString());
    isloadingcategorydetails = false;
    notifyListeners();
    if (response['status'] == false) {
      return {'status': false, 'error': response['msg']};
    } else {
      categoryDetails = Category.fromJson(response['data']['data']);
      notifyListeners();
      return {
        'status': true,
      };
    }
  }
}
