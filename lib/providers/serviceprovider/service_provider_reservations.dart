import 'package:flutter/cupertino.dart';
import 'package:shanbwrog/Settings/MySettings.dart';
import 'package:shanbwrog/models/reservation.dart';
import 'package:shanbwrog/server/dionetwork.dart';
import 'package:shanbwrog/server/endpoints.dart';

class ServiceProviderReservationsProvider with ChangeNotifier {
  String token = '';
  List<Reservation> newmyReservations = [];
  List<Reservation> currentmyReservations = [];
  List<Reservation> finishedmyReservations = [];
  bool isloadingMyReservations = false;
  bool isloadingaccepting = false;
  bool isloadingrefusing = false;
  bool isloadingDeleting = false;

  void update({
    String? newtoken,
  }) {
    token = newtoken!;
  }

  Future<Map<String, dynamic>> getProviderReservations(
      BuildContext context, String lang, String type) async {
    Future.delayed(Duration(microseconds: 3), () {
      isloadingMyReservations = true;
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
            EndPoints.segments['reservationforp'] +
            '?type=$type');
    isloadingMyReservations = false;
    notifyListeners();
    if (response['status'] == false) {
      return {'status': false, 'error': response['msg']};
    } else {
      if (type == 'current') {
        newmyReservations = (response['data']['data'] as List)
            .map((e) => Reservation.fromJson(e))
            .toList();
        notifyListeners();
      } else if (type == 'processing') {
        currentmyReservations = (response['data']['data'] as List)
            .map((e) => Reservation.fromJson(e))
            .toList();
        notifyListeners();
      } else {
        finishedmyReservations = (response['data']['data'] as List)
            .map((e) => Reservation.fromJson(e))
            .toList();
        notifyListeners();
      }

      return {
        'status': true,
      };
    }
  }

  Future<Map<String, dynamic>> acceptReservation(
      {BuildContext? context, String? lang, required String id}) async {
    Future.delayed(Duration(microseconds: 3), () {
      isloadingaccepting = true;
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
        dioBody: {"reservation_id": id},
        netWorkWorking: MySettings.netWorkWorking(),
        url: EndPoints.baseurl + EndPoints.segments['acceptResrve']);
    print(response.toString());
    isloadingaccepting = false;
    notifyListeners();
    if (response['status'] == false) {
      return {'status': false, 'error': response['msg']};
    } else {
      return {
        'status': true,
      };
    }
  }

  Future<Map<String, dynamic>> refuseReservation(
      {BuildContext? context, String? lang, required String id}) async {
    Future.delayed(Duration(microseconds: 3), () {
      isloadingrefusing = true;
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
        dioBody: {"reservation_id": id},
        netWorkWorking: MySettings.netWorkWorking(),
        url: EndPoints.baseurl + EndPoints.segments['refuserReserve']);
    print(response.toString());
    isloadingrefusing = false;
    notifyListeners();
    if (response['status'] == false) {
      return {'status': false, 'error': response['msg']};
    } else {
      return {
        'status': true,
      };
    }
  }

  Future<Map<String, dynamic>> finsihReservation(
      {BuildContext? context, String? lang, required String id}) async {
    Map<String, dynamic> headers = {
      "Accept-Language": lang,
      "Authorization": token
    };
    Map<dynamic, dynamic> response = await dioNetWork(
        appLanguage: lang,
        dioHeaders: headers,
        methodType: 'post',
        dioBody: {"reservation_id": id},
        netWorkWorking: MySettings.netWorkWorking(),
        url: EndPoints.baseurl + '/finishReservation');
    print(response.toString());

    if (response['status'] == false) {
      return {'status': false, 'error': response['msg']};
    } else {
      currentmyReservations
          .removeWhere((element) => element.id.toString() == id);
      notifyListeners();
      return {
        'status': true,
      };
    }
  }

  Future<Map<String, dynamic>> deleteReservation(
      {BuildContext? context, String? lang, required int reservationId}) async {
    Future.delayed(Duration(microseconds: 3), () {
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
            EndPoints.segments['addreserve'] +
            '/${reservationId.toString()}');
    print(response.toString());
    isloadingDeleting = false;
    notifyListeners();
    if (response['status'] == false) {
      return {'status': false, 'error': response['msg']};
    } else {
      finishedmyReservations
          .removeWhere((element) => element.id == reservationId);
      notifyListeners();
      return {
        'status': true,
      };
    }
  }
}
