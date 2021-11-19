import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shanbwrog/Settings/MySettings.dart';
import 'package:shanbwrog/models/basic.dart';
import 'package:shanbwrog/models/notification.dart' as not;
import 'package:shanbwrog/models/reservation.dart';
import 'package:shanbwrog/models/userModel.dart';
import 'package:shanbwrog/server/dionetwork.dart';
import 'package:shanbwrog/server/endpoints.dart';

class ProfileProvider with ChangeNotifier {
  String token = '';
  UserModel userprofile = UserModel();
  bool isLoadingUserProfile = false;
  bool isLoadingUpdatingProfile = false;
  bool isLoadingAddingRate = false;
  bool isLoadingFavouriteUsers = false;
  String? isLoadingFavouriteUsersError = null;

  bool isLoadingNotifications = false;
  String? LoadingNotificationError = null;

  String? getProfileError = null;
  List<Basic> countries = [];
  Basic? selectedCountry;
  List<Basic> cities = [];
  Basic? selectedCity;
  List<UserModel> favouriteUsers = [];
  List<not.Notification> notifications = [];

  void update({
    String? newtoken,
  }) {
    token = newtoken!;
  }

  Future<Map<String, dynamic>> getUserProfile(
      BuildContext context, String lang, int userid,
      {bool? getprofile = false, Future Function()? fill}) async {
    getProfileError = null;
    Future.delayed(Duration(microseconds: 3), () {
      isLoadingUserProfile = true;
      notifyListeners();
    });
    Map<String, dynamic> headers;
    String url;
    if (getprofile!) {
      headers = {"Accept-Language": lang, "Authorization": token};
      url = EndPoints.baseurl +
          EndPoints.segments['getprofile'] +
          '?user_id=${userid.toString()}';
    } else {
      headers = {"Accept-Language": lang, "Authorization": token};
      url = EndPoints.baseurl +
          EndPoints.segments['getprofile'] +
          '?user_id=${userid.toString()}';
    }

    Map<dynamic, dynamic> response = await dioNetWork(
        appLanguage: lang,
        dioHeaders: headers,
        methodType: 'get',
        netWorkWorking: MySettings.netWorkWorking(),
        url: url);

    if (response['status'] == false) {
      getProfileError = response['msg'];
      notifyListeners();
      return {'status': false, 'error': response['msg']};
    } else {
      userprofile = UserModel.fromJson((response['data']['data']));
      //for countries
      countries = [];
      selectedCountry = null;
      countries = (response['data']['countries'] as List)
          .map((e) => Basic.fromJson(e))
          .toList();
      selectedCountry = countries.firstWhere(
          (country) => country.id.toString() == userprofile.countryId);
      ///////////////////
      //for citites
      cities = [];
      selectedCity = null;
      cities = (response['data']['cities'] as List)
          .map((e) => Basic.fromJson(e))
          .toList();
      selectedCity =
          cities.firstWhere((city) => city.id.toString() == userprofile.cityId);

      //////////
      if (getprofile) {
        await fill!();
      }
      isLoadingUserProfile = false;
      notifyListeners();
      return {
        'status': true,
      };
    }
  }

  Future<Map<String, dynamic>> updateProfile(
      {String? lang,
      bool normaluser = false,
      required Map<String, dynamic> formdata}) async {
    Future.delayed(Duration(milliseconds: 1), () {
      isLoadingUpdatingProfile = true;
      notifyListeners();
    });
    Map<String, dynamic> headers = {
      "Accept-Language": lang,
      "Authorization": token
    };
    String url = EndPoints.baseurl + EndPoints.segments['getprofile'];

    var data = FormData.fromMap(formdata);
    print(formdata.toString());

    Map<dynamic, dynamic> response = await dioNetWork(
        appLanguage: lang,
        dioHeaders: headers,
        methodType: 'post',
        dioBody: data,
        netWorkWorking: MySettings.netWorkWorking(),
        url: url);
    isLoadingUpdatingProfile = false;
    notifyListeners();
    if (response['status'] == false) {
      return {'status': false, 'error': response['msg']};
    } else {
      notifyListeners();
      return {
        'status': true,
      };
    }
  }

  Future<Map<String, dynamic>> addRate(
      {String? lang, required Map<String, dynamic> body}) async {
    Future.delayed(Duration(milliseconds: 1), () {
      isLoadingAddingRate = true;
      notifyListeners();
    });
    Map<String, dynamic> headers = {
      "Accept-Language": lang,
      "Authorization": token
    };
    String url = EndPoints.baseurl + '/rate';

    Map<dynamic, dynamic> response = await dioNetWork(
        appLanguage: lang,
        dioHeaders: headers,
        methodType: 'post',
        dioBody: body,
        netWorkWorking: MySettings.netWorkWorking(),
        url: url);
    isLoadingAddingRate = false;
    notifyListeners();
    if (response['status'] == false) {
      return {'status': false, 'error': response['msg']};
    } else {
      userprofile.rates!.add(Rate.fromJson(response['data']['data']));
      notifyListeners();
      return {'status': true, 'msg': response['data']['msg']};
    }
  }

  removImageFromProfile(
      {int? id, void Function(void Function())? updateGridState}) {
    updateGridState!(() {
      userprofile.images!.removeWhere((element) => element.id == id);
    });
  }

  addImageFromProfile(
      {void Function(void Function())? updateGridState, String? imagePath}) {
    updateGridState!(() {
      userprofile.images!.add(Images(localImage: true, img: imagePath));
    });
  }

  Future<Map<String, dynamic>> getFvouriteUsers(
      BuildContext context, String lang) async {
    isLoadingFavouriteUsersError = null;
    Future.delayed(Duration(microseconds: 3), () {
      isLoadingFavouriteUsers = true;
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
        url: EndPoints.baseurl + '/likes');
    isLoadingFavouriteUsers = false;
    if (response['status'] == false) {
      isLoadingFavouriteUsersError = response['msg'];
      notifyListeners();

      return {'status': false, 'error': response['msg']};
    } else {
      favouriteUsers = (response['data']['data'] as List)
          .map((e) => UserModel.fromJson(e))
          .toList();
      notifyListeners();
      return {
        'status': true,
      };
    }
  }

  void removeFromFavourite(int id) {
    favouriteUsers.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  Future<Map<String, dynamic>> getNotifications(
      BuildContext context, String lang) async {
    LoadingNotificationError = null;
    Future.delayed(Duration(microseconds: 3), () {
      isLoadingNotifications = true;
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
        url: EndPoints.baseurl + '/notifications');
    isLoadingNotifications = false;
    if (response['status'] == false) {
      LoadingNotificationError = response['msg'];
      notifyListeners();

      return {'status': false, 'error': response['msg']};
    } else {
      notifications = (response['data']['data'] as List)
          .map((e) => not.Notification.fromJson(e))
          .toList();
      notifyListeners();
      return {
        'status': true,
      };
    }
  }
}
