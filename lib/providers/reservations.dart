import 'package:flutter/cupertino.dart';
import 'package:shanbwrog/Settings/MySettings.dart';
import 'package:shanbwrog/models/reservation.dart';
import 'package:shanbwrog/server/dionetwork.dart';
import 'package:shanbwrog/server/endpoints.dart';

class ReservationsProvider with ChangeNotifier {
  String token = '';
  bool isloadingAddingReservation = false;
  bool isloadingMyReservations = false;
  bool isloadingDeleting = false;
  List<Reservation> currentmyReservations = [];
  List<Reservation> finishedmyReservations = [];

  void update({
    String? newtoken,
  }) {
    token = newtoken!;
  }

  Future<Map<String, dynamic>> getMyReservations(
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
            EndPoints.segments['userreservations'] +
            '?type=$type');
    isloadingMyReservations = false;
    notifyListeners();
    if (response['status'] == false) {
      return {'status': false, 'error': response['msg']};
    } else {
      if (type == 'current') {
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

  Future<Map<String, dynamic>> addReservation(
      {BuildContext? context,
      String? lang,
      required Map<String, dynamic> bodydata}) async {
    Future.delayed(Duration(microseconds: 3), () {
      isloadingAddingReservation = true;
      notifyListeners();
    });
    Map<String, dynamic> headers = {
      "Accept-Language": lang,
      "Authorization": token
    };
    Map<String, dynamic> body = {
      'reservation_date': bodydata['reservation_date'],
      'reservation_time': bodydata['reservation_time'],
      'name': bodydata['name'],
      'address': bodydata['address'],
      'lat': bodydata['lat'],
      'lng': bodydata['lng'],
      'phone': bodydata['phone'],
      'category_id': bodydata['category_id'],
      'payment_method': bodydata['payment_method']
    };

    print(body.toString());
    Map<dynamic, dynamic> response = await dioNetWork(
        appLanguage: lang,
        dioHeaders: headers,
        dioBody: body,
        methodType: 'post',
        netWorkWorking: MySettings.netWorkWorking(),
        url: EndPoints.baseurl + EndPoints.segments['addreserve']);
    print(response.toString());
    isloadingAddingReservation = false;
    notifyListeners();
    if (response['status'] == false) {
      return {'status': false, 'error': response['msg']};
    } else {
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
      return {
        'status': true,
      };
    }
  }
}
