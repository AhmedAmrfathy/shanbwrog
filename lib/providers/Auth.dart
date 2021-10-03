import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:shanbwrog/Settings/MySettings.dart';
import 'package:shanbwrog/models/basic.dart';
import 'package:shanbwrog/models/category.dart';
import 'package:shanbwrog/models/userModel.dart';
import 'package:shanbwrog/server/endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../server/dionetwork.dart';

class AuthProvider with ChangeNotifier {
  UserModel userModel = UserModel();
  List<Basic> countries = [];
  Basic? selectedCountry;
  bool isloadingCountries = false;
  bool isloadingRegister = false;
  bool isloadingLogin = false;
  bool isloadingSendCode = false;
  bool isloadingCheckCode = false;
  bool isloadingChangePassword = false;

  List<Basic> cities = [];
  Basic? selectedCity;
  bool isloadingCities = false;

  List<Basic> periods = [
    Basic(name: tr('3month'), id: 3),
    Basic(name: tr('6month'), id: 6),
    Basic(name: tr('9month'), id: 12)
  ];
  Basic? selectedPeriod;

  List<Category> categories = [];
  List<int> selectedCategories = [];

  Basic? selected;

  Future<Map<String, dynamic>> getCountries(
      BuildContext context, String lang) async {
    Future.delayed(Duration(milliseconds: 1), () {
      isloadingCountries = true;
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
        url: EndPoints.baseurl + EndPoints.segments['countries']);
    isloadingCountries = false;
    notifyListeners();
    if (response['status'] == false) {
      return {'status': false, 'error': response['msg']};
    } else {
      Map<String, dynamic> getCategorie = await getCategories(context, lang);
      if (getCategorie['status'] == false) {
        return {'status': false, 'error': getCategorie['error']};
      } else {
        countries = [];
        selectedCountry = null;
        countries = (response['data']['data'] as List)
            .map((e) => Basic.fromJson(e))
            .toList();
        notifyListeners();
        return {
          'status': true,
        };
      }
    }
  }

  Future<Map<String, dynamic>> getCities(BuildContext context, int? countryid,
      {String? lang}) async {
    Map<String, dynamic> headers = {
      "Accept-Language": lang,
    };
    Map<dynamic, dynamic> response = await dioNetWork(
        appLanguage: lang,
        dioHeaders: headers,
        methodType: 'get',
        netWorkWorking: MySettings.netWorkWorking(),
        url: EndPoints.baseurl +
            EndPoints.segments['cities'] +
            '?country_id=${countryid.toString()}');
    isloadingCountries = false;
    notifyListeners();
    if (response['status'] == false) {
      return {'status': false, 'error': response['msg']};
    } else {
      cities = [];
      selectedCity = null;
      cities = (response['data']['data'] as List)
          .map((e) => Basic.fromJson(e))
          .toList();
      notifyListeners();
      return {
        'status': true,
      };
    }
  }

  Future<Map<String, dynamic>> getCategories(
      BuildContext context, String lang) async {
    Map<String, dynamic> headers = {
      "Accept-Language": lang,
    };
    Map<dynamic, dynamic> response = await dioNetWork(
        appLanguage: lang,
        dioHeaders: headers,
        methodType: 'get',
        netWorkWorking: MySettings.netWorkWorking(),
        url: EndPoints.baseurl + EndPoints.segments['categories']);
    if (response['status'] == false) {
      return {'status': false, 'error': response['msg']};
    } else {
      categories = (response['data']['data'] as List)
          .map((e) => Category.fromJson(e))
          .toList();
      return {
        'status': true,
      };
    }
  }

  Future<Map<String, dynamic>> register(
      {String? lang,
      bool normaluser = false,
      required Map<String, dynamic> formdata}) async {
    Future.delayed(Duration(milliseconds: 1), () {
      isloadingRegister = true;
      notifyListeners();
    });
    Map<String, dynamic> headers = {
      "Accept-Language": lang,
    };
    String url = normaluser
        ? EndPoints.baseurl + EndPoints.segments['registernormal']
        : EndPoints.baseurl + EndPoints.segments['registerprovider'];
    var data = FormData.fromMap(formdata);
    print(formdata.toString());

    Map<dynamic, dynamic> response = await dioNetWork(
        appLanguage: lang,
        dioHeaders: headers,
        methodType: 'post',
        dioBody: data,
        netWorkWorking: MySettings.netWorkWorking(),
        url: url);
    isloadingRegister = false;
    notifyListeners();
    if (response['status'] == false) {
      return {'status': false, 'error': response['msg']};
    } else {
      userModel = UserModel.fromJson(response['data']['data']);
      saveUserDataToSharedPref(response['data']['data']);
      notifyListeners();
      return {
        'status': true,
      };
    }
  }

  Future<Map<String, dynamic>> login(
      BuildContext context, String lang, String email, String password) async {
    Future.delayed(Duration(milliseconds: 1), () {
      isloadingLogin = true;
      notifyListeners();
    });
    Map<String, dynamic> headers = {
      "Accept-Language": lang,
    };
    Map<String, dynamic> body = {"email": email, "password": password};

    Map<dynamic, dynamic> response = await dioNetWork(
        appLanguage: lang,
        dioHeaders: headers,
        methodType: 'post',
        dioBody: body,
        netWorkWorking: MySettings.netWorkWorking(),
        url: EndPoints.baseurl + EndPoints.segments['login']);
    isloadingLogin = false;
    notifyListeners();
    if (response['status'] == false) {
      return {'status': false, 'error': response['msg']};
    } else {
      userModel = UserModel.fromJson(response['data']['data']);
      saveUserDataToSharedPref(response['data']['data']);
      notifyListeners();
      return {
        'status': true,
      };
    }
  }

  Future<Map<String, dynamic>> sendCode(
      BuildContext context, String lang, String Phone) async {
    Future.delayed(Duration(milliseconds: 1), () {
      isloadingSendCode = true;
      notifyListeners();
    });
    Map<String, dynamic> headers = {
      "Accept-Language": lang,
    };
    Map<String, dynamic> body = {"phone": Phone};

    Map<dynamic, dynamic> response = await dioNetWork(
        appLanguage: lang,
        dioHeaders: headers,
        methodType: 'post',
        dioBody: body,
        netWorkWorking: MySettings.netWorkWorking(),
        url: EndPoints.baseurl + EndPoints.segments['sendcode']);
    isloadingSendCode = false;
    notifyListeners();
    if (response['status'] == false) {
      return {'status': false, 'error': response['msg']};
    } else {
      return {
        'status': true,
      };
    }
  }

  Future<Map<String, dynamic>> checkCode(
      BuildContext context, String lang, String Phone, String Code) async {
    Future.delayed(Duration(milliseconds: 1), () {
      isloadingCheckCode = true;
      notifyListeners();
    });
    Map<String, dynamic> headers = {
      "Accept-Language": lang,
    };
    Map<String, dynamic> body = {"phone": Phone, "code": Code};

    Map<dynamic, dynamic> response = await dioNetWork(
        appLanguage: lang,
        dioHeaders: headers,
        methodType: 'post',
        dioBody: body,
        netWorkWorking: MySettings.netWorkWorking(),
        url: EndPoints.baseurl + EndPoints.segments['checkcode']);
    isloadingCheckCode = false;
    notifyListeners();
    if (response['status'] == false) {
      return {'status': false, 'error': response['msg']};
    } else {
      return {
        'status': true,
      };
    }
  }

  Future<Map<String, dynamic>> changePassword(BuildContext context, String lang,
      String phone, String password, String passwordconfirm) async {
    Future.delayed(Duration(milliseconds: 1), () {
      isloadingChangePassword = true;
      notifyListeners();
    });
    Map<String, dynamic> headers = {
      "Accept-Language": lang,
    };
    Map<String, dynamic> body = {
      "phone": phone,
      "password": password,
      "confirmation_password": passwordconfirm
    };

    Map<dynamic, dynamic> response = await dioNetWork(
        appLanguage: lang,
        dioHeaders: headers,
        methodType: 'post',
        dioBody: body,
        netWorkWorking: MySettings.netWorkWorking(),
        url: EndPoints.baseurl + EndPoints.segments['changepassword']);
    isloadingChangePassword = false;
    notifyListeners();
    if (response['status'] == false) {
      return {'status': false, 'error': response['msg']};
    } else {
      return {
        'status': true,
      };
    }
  }

  Future<String> saveUserDataToSharedPref(Map<String, dynamic> userdata) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences pref = await _prefs;
    pref.setString('token', userdata['token']);
    return userdata['token'];
  }
}
