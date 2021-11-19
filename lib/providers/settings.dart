import 'package:flutter/cupertino.dart';
import 'package:shanbwrog/Settings/MySettings.dart';
import 'package:shanbwrog/server/dionetwork.dart';
import 'package:shanbwrog/server/endpoints.dart';

class SettingsProvider with ChangeNotifier {
  String token = '';
  String polices = '';
  String rules = '';
  String aboutus = '';
  bool isloadingPolces = false;
  bool isloadingRoles = false;
  bool isloadingaboutus = false;
  bool isloadingAddingContact = false;

  void update({
    String? newtoken,
  }) {
    token = newtoken!;
  }

  Future<Map<String, dynamic>> getPolices(
      BuildContext context, String lang) async {
    Future.delayed(Duration(microseconds: 3), () {
      isloadingPolces = true;
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
        url: EndPoints.baseurl + EndPoints.segments['getpolices']);
    isloadingPolces = false;
    if (response['status'] == false) {
      notifyListeners();

      return {'status': false, 'error': response['msg']};
    } else {
      polices = response['data']['data']['policy'];
      notifyListeners();
      return {
        'status': true,
      };
    }
  }

  Future<Map<String, dynamic>> getrules(
      BuildContext context, String lang) async {
    Future.delayed(Duration(microseconds: 3), () {
      isloadingRoles = true;
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
        url: EndPoints.baseurl + EndPoints.segments['getroles']);
    isloadingRoles = false;
    if (response['status'] == false) {
      notifyListeners();

      return {'status': false, 'error': response['msg']};
    } else {
      rules = response['data']['data']['rules'];
      notifyListeners();
      return {
        'status': true,
      };
    }
  }

  Future<Map<String, dynamic>> getAboutUs(
      BuildContext context, String lang) async {
    Future.delayed(Duration(microseconds: 3), () {
      isloadingaboutus = true;
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
        url: EndPoints.baseurl + EndPoints.segments['getaboutus']);
    isloadingaboutus = false;
    if (response['status'] == false) {
      notifyListeners();

      return {'status': false, 'error': response['msg']};
    } else {
      aboutus = response['data']['data']['aboutus'];
      notifyListeners();
      return {
        'status': true,
      };
    }
  }

  Future<Map<String, dynamic>> addContact(
      BuildContext context, String lang, Map<String, dynamic> bodyform) async {
    Future.delayed(Duration(microseconds: 3), () {
      isloadingAddingContact = true;
      notifyListeners();
    });
    Map<String, dynamic> headers = {
      "Accept-Language": lang,
      "Authorization": token
    };
    Map<dynamic, dynamic> response = await dioNetWork(
        appLanguage: lang,
        dioHeaders: headers,
        methodType: 'post',
        dioBody: bodyform,
        netWorkWorking: MySettings.netWorkWorking(),
        url: EndPoints.baseurl + '/contact');
    isloadingAddingContact = false;
    notifyListeners();

    if (response['status'] == false) {
      return {'status': false, 'error': response['msg']};
    } else {
      return {'status': true, 'msg': response['data']['msg']};
    }
  }
}
