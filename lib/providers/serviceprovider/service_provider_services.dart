import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:shanbwrog/Settings/MySettings.dart';
import 'package:shanbwrog/models/basic.dart';
import 'package:shanbwrog/models/category.dart';
import 'package:shanbwrog/models/offer.dart';
import 'package:shanbwrog/server/dionetwork.dart';
import 'package:shanbwrog/server/endpoints.dart';

class ServiceProviderServicesProvider with ChangeNotifier {
  String token = '';
  bool isloadingaddingservice = false;
  bool isloadingEditingService = false;
  bool isloadingCategory = false;
  String? errorCategory = null;
  bool isloadingServces = false;
  bool isloadingDeleting = false;
  List<Category> providerServices = [];
  List<Category> categories = [];
  List<Basic> sections = [
    Basic(name: tr('rog'), id: 1),
    Basic(name: tr('shanb'), id: 2)
  ];
  Basic? selectedSection;

  Category? selectedCategory;

  void update({
    String? newtoken,
  }) {
    token = newtoken!;
  }

  Future<Map<String, dynamic>> getProviderServices(
      BuildContext context, String lang) async {
    Future.delayed(Duration(milliseconds: 1), () {
      isloadingServces = true;
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
        url: EndPoints.baseurl + EndPoints.segments['providercategories']);
    isloadingServces = false;
    notifyListeners();
    if (response['status'] == false) {
      return {'status': false, 'error': response['msg']};
    } else {
      providerServices = (response['data']['data'] as List)
          .map((e) => Category.fromJson(e))
          .toList();
      notifyListeners();
      return {
        'status': true,
      };
    }
  }

  Future<Map<String, dynamic>> addService(
      {required BuildContext context,
      required String lang,
      required String name,
      required String details,
      required String price,
      required int category_id,
      required String img,
      required String img2,
      required String img3,
      required String img4,
      required int type}) async {
    Future.delayed(Duration(milliseconds: 1), () {
      isloadingaddingservice = true;
      notifyListeners();
    });
    Map<String, dynamic> headers = {
      "Accept-Language": lang,
      "Authorization": token
    };
    Map<String, dynamic> mapdata = {
      "name": name,
      "details": details,
      "price": price,
      "category_id": category_id.toString(),
      "type": type,
      "img": await MultipartFile.fromFile(img, filename: img),
      "img2": await MultipartFile.fromFile(img2, filename: img2),
      "img3": await MultipartFile.fromFile(img3, filename: img3),
      "img4": await MultipartFile.fromFile(img4, filename: img4),
    };
    var data = FormData.fromMap(mapdata);
    Map<dynamic, dynamic> response = await dioNetWork(
        appLanguage: lang,
        dioHeaders: headers,
        methodType: 'post',
        dioBody: data,
        netWorkWorking: MySettings.netWorkWorking(),
        url: EndPoints.baseurl + EndPoints.segments['category']);
    isloadingaddingservice = false;
    notifyListeners();
    if (response['status'] == false) {
      return {'status': false, 'error': response['msg']};
    } else {
      return {
        'status': true,
      };
    }
  }

  Future<Map<String, dynamic>> editService(
    int id, {
    required BuildContext context,
    required String lang,
    required String name,
    required String details,
    required String price,
    required int category_id,
    required int type,
    String? img,
    String? img2,
    String? img3,
    String? img4,
  }) async {
    Future.delayed(Duration(milliseconds: 1), () {
      isloadingEditingService = true;
      notifyListeners();
    });
    Map<String, dynamic> headers = {
      "Accept-Language": lang,
      "Authorization": token
    };
    Map<String, dynamic> mapdata = {
      "name": name,
      "details": details,
      "price": price,
      "category_id": category_id.toString(),
      "type": type,
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
            EndPoints.segments['category'] +
            '/${id.toString()}');
    isloadingEditingService = false;
    notifyListeners();
    if (response['status'] == false) {
      return {'status': false, 'error': response['msg']};
    } else {
      return {
        'status': true,
      };
    }
  }

  Future<Map<String, dynamic>> deleteService(
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
            EndPoints.segments['category'] +
            '/${id.toString()}');
    isloadingDeleting = false;
    notifyListeners();
    if (response['status'] == false) {
      return {'status': false, 'error': response['msg']};
    } else {
      providerServices.removeWhere((element) => element.id == id);
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
        print(selectedCategoryItem!.category_id);
        try {
          selectedCategory = categories.firstWhere((element) =>
              element.id.toString() == selectedCategoryItem!.category_id);
        } catch (error) {
          selectedCategory = null;
        }

        selectedSection =
            selectedCategoryItem!.type == '1' ? sections[0] : sections[1];
      }
      notifyListeners();

      return {
        'status': true,
      };
    }
  }
}
