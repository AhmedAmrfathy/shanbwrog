import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:shanbwrog/Settings/MySettings.dart';
import 'package:shanbwrog/models/basic.dart';
import 'package:shanbwrog/models/category.dart';
import 'package:shanbwrog/server/dionetwork.dart';
import 'package:shanbwrog/server/endpoints.dart';

class ServiceProviderOffersProvider with ChangeNotifier {
  String token = '';
  bool isloadingaddingoffer = false;
  bool isloadingCategory = false;
  List<Category> categories = [];
  Category? selectedCategory;
  List<Basic> sections = [
    Basic(name: tr('rog'), id: 1),
    Basic(name: tr('shanb'), id: 2)
  ];
  Basic? selectedSection;

  void update({
    String? newtoken,
  }) {
    token = newtoken!;
  }

  Future<Map<String, dynamic>> addOffer({
    required BuildContext context,
    required String lang,
    required String title,
    required String details,
    required String price,
    required String old_price,
    required int category_id,
    required String img,
    required String img2,
    required String img3,
    required String img4,
  }) async {
    Future.delayed(Duration(milliseconds: 1), () {
      isloadingaddingoffer = true;
      notifyListeners();
    });
    Map<String, dynamic> headers = {
      "Accept-Language": lang,
    };
    var data = FormData.fromMap({
      "title": title,
      "details": details,
      "price": price,
      "old_price": old_price,
      "category_id": category_id,
      "img": MultipartFile.fromFileSync(img),
      "img2": MultipartFile.fromFileSync(img2),
      "img3": MultipartFile.fromFileSync(img3),
      "img4": MultipartFile.fromFileSync(img4),
    });

    Map<dynamic, dynamic> response = await dioNetWork(
        appLanguage: lang,
        dioHeaders: headers,
        methodType: 'post',
        dioBody: data,
        netWorkWorking: MySettings.netWorkWorking(),
        url: EndPoints.baseurl + EndPoints.segments['offer']);
    isloadingaddingoffer = false;
    notifyListeners();
    if (response['status'] == false) {
      return {'status': false, 'error': response['msg']};
    } else {
      return {
        'status': true,
      };
    }
  }

  Future<Map<String, dynamic>> getCategories(
      BuildContext context, String lang) async {
    Future.delayed(Duration(milliseconds: 1), () {
      isloadingCategory = true;
      notifyListeners();
    });
    Map<String, dynamic> headers = {
      "Accept-Language": lang,
    };
    Map<dynamic, dynamic> response = await dioNetWork(
        appLanguage: lang,
        dioHeaders: headers,
        methodType: 'get',
        netWorkWorking: MySettings.netWorkWorking(),
        url: EndPoints.baseurl + EndPoints.segments['categories']);
    isloadingCategory = false;
    notifyListeners();
    if (response['status'] == false) {
      return {'status': false, 'error': response['msg']};
    } else {
      categories = [];
      selectedCategory = null;
      categories = (response['data']['data'] as List)
          .map((e) => Category.fromJson(e))
          .toList();
      notifyListeners();
      return {
        'status': true,
      };
    }
  }
}
