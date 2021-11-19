import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:shanbwrog/Settings/MySettings.dart';
import 'package:shanbwrog/models/basic.dart';
import 'package:shanbwrog/models/category.dart';
import 'package:shanbwrog/models/offer.dart';
import 'package:shanbwrog/server/dionetwork.dart';
import 'package:shanbwrog/server/endpoints.dart';

class ServiceProviderOffersProvider with ChangeNotifier {
  String token = '';
  bool isloadingaddingoffer = false;
  bool isloadingEditingoffer = false;
  bool isloadingCategory = false;
  String? errorCategory = null;
  bool isloadingOffers = false;
  bool isloadingDeleting = false;
  List<Offer> providerOffers = [];
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

  Future<Map<String, dynamic>> getProviderOffers(
      BuildContext context, String lang) async {
    Future.delayed(Duration(milliseconds: 1), () {
      isloadingOffers = true;
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
        url: EndPoints.baseurl + EndPoints.segments['provideroffers']);
    isloadingOffers = false;
    notifyListeners();
    if (response['status'] == false) {
      return {'status': false, 'error': response['msg']};
    } else {
      providerOffers = (response['data']['data'] as List)
          .map((e) => Offer.fromJson(e))
          .toList();
      print(providerOffers.length);
      notifyListeners();
      return {
        'status': true,
      };
    }
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
    print(img);
    print(img2);
    print(img3);
    print(img4);

    Future.delayed(Duration(milliseconds: 1), () {
      isloadingaddingoffer = true;
      notifyListeners();
    });
    Map<String, dynamic> headers = {
      "Accept-Language": lang,
      "Authorization": token,
    };
    Map<String, dynamic> mapdata = {
      "title": title,
      "details": details,
      "price": price,
      "old_price": old_price,
      "category_id": category_id.toString(),
      "img": await MultipartFile.fromFile(img, filename: img.split('/').last),
      "img2":
          await MultipartFile.fromFile(img2, filename: img2.split('/').last),
      "img3":
          await MultipartFile.fromFile(img3, filename: img3.split('/').last),
      "img4":
          await MultipartFile.fromFile(img4, filename: img4.split('/').last),
    };
    FormData data = FormData.fromMap(mapdata);
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

  Future<Map<String, dynamic>> editOffer(
    int id, {
    required BuildContext context,
    required String lang,
    required String title,
    required String details,
    required String price,
    required String old_price,
    required int category_id,
    String? img,
    String? img2,
    String? img3,
    String? img4,
  }) async {
    Future.delayed(Duration(milliseconds: 1), () {
      isloadingEditingoffer = true;
      notifyListeners();
    });
    Map<String, dynamic> headers = {
      "Accept-Language": lang,
      "Authorization": token
    };
    Map<String, dynamic> mapdata = {
      "title": title,
      "details": details,
      "price": price,
      "old_price": old_price,
      "category_id": category_id.toString(),
    };
    if (img != null) {
      mapdata['img'] = await MultipartFile.fromFile(img, filename: img);
    }
    if (img2 != null) {
      mapdata['img2'] = await MultipartFile.fromFile(img2, filename: img2);
    }
    if (img3 != null) {
      mapdata['img3'] = await MultipartFile.fromFile(img3, filename: img3);
    }
    if (img4 != null) {
      mapdata['img4'] = await MultipartFile.fromFile(img4, filename: img4);
    }
    var data = FormData.fromMap(mapdata);
    Map<dynamic, dynamic> response = await dioNetWork(
        appLanguage: lang,
        dioHeaders: headers,
        methodType: 'post',
        dioBody: data,
        netWorkWorking: MySettings.netWorkWorking(),
        url: EndPoints.baseurl +
            EndPoints.segments['offer'] +
            '/${id.toString()}');
    isloadingEditingoffer = false;
    notifyListeners();
    if (response['status'] == false) {
      return {'status': false, 'error': response['msg']};
    } else {
      return {
        'status': true,
      };
    }
  }

  Future<Map<String, dynamic>> deleteOffer(
      BuildContext context, String lang, int id) async {
    Future.delayed(Duration(milliseconds: 1), () {
      isloadingDeleting = true;
      notifyListeners();
    });
    Map<String, dynamic> headers = {
      "Accept-Language": lang,
      "Authorization": token
    };
    Map<dynamic, dynamic> response = await dioNetWork(
        appLanguage: lang,
        dioHeaders: headers,
        methodType: 'delete',
        netWorkWorking: MySettings.netWorkWorking(),
        url: EndPoints.baseurl +
            EndPoints.segments['offer'] +
            '/${id.toString()}');
    isloadingDeleting = false;
    notifyListeners();
    if (response['status'] == false) {
      return {'status': false, 'error': response['msg']};
    } else {
      providerOffers.removeWhere((element) => element.id == id);
      notifyListeners();
      return {
        'status': true,
      };
    }
  }

  Future<Map<String, dynamic>> getCategories(BuildContext context, String lang,
      {bool updatePage = false, Category? selectedCategoryItem}) async {
    errorCategory = null;
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
    if (response['status'] == false) {
      errorCategory = response['msg'];
      notifyListeners();
      return {'status': false, 'error': response['msg']};
    } else {
      categories = [];
      selectedCategory = null;
      categories = (response['data']['data'] as List)
          .map((e) => Category.fromJson(e))
          .toList();
      if (updatePage) {
        try{ selectedCategory = categories
            .firstWhere((element) => element.id == selectedCategoryItem!.id);}catch(error){
          selectedCategory=null;
        }

      }
      notifyListeners();

      return {
        'status': true,
      };
    }
  }
}
