import 'package:flutter/cupertino.dart';
import 'package:shanbwrog/Settings/MySettings.dart';
import 'package:shanbwrog/models/userModel.dart';
import 'package:shanbwrog/server/dionetwork.dart';
import 'package:shanbwrog/server/endpoints.dart';

class SearchProvider with ChangeNotifier {
  String token = '';
  bool isloadingsearch = false;
  String? searcherror = null;
  List<UserModel>? searchedProvider = null;

  bool isloadingProvidersOfCategory = false;
  String? ProvidersOfCategorError = null;
  List<UserModel>? providersofcategory = null;

  void update({
    String? newtoken,
  }) {
    token = newtoken!;
  }

  Future<Map<String, dynamic>> search(
      BuildContext context, String lang, String name,
      {bool filter = false,
      int? category_id,
      String? rate,
      String? price}) async {
    searcherror = null;
    Future.delayed(Duration(microseconds: 3), () {
      isloadingsearch = true;
      notifyListeners();
    });
    Map<String, dynamic> headers = {
      "Accept-Language": lang,
    };
    String url = filter
        ? EndPoints.baseurl + '/search' + '?name=$name&rate=$rate&price=$price'
        : EndPoints.baseurl + '/search' + '?name=$name';
    Map<dynamic, dynamic> response = await dioNetWork(
        appLanguage: lang,
        dioHeaders: headers,
        methodType: 'get',
        netWorkWorking: MySettings.netWorkWorking(),
        url: url);
    print(response.toString());
    isloadingsearch = false;
    notifyListeners();
    if (response['status'] == false) {
      searcherror = response['msg'];
      notifyListeners();
      return {'status': false, 'error': response['msg']};
    } else {
      searchedProvider = (response['data']['data'] as List)
          .map((e) => UserModel.fromJson(e))
          .toList();
      notifyListeners();
      return {
        'status': true,
      };
    }
  }

  Future<Map<String, dynamic>> getProvidersOfCategory(
      BuildContext context, String lang, int categoryid) async {
    ProvidersOfCategorError = null;
    Future.delayed(Duration(microseconds: 3), () {
      isloadingProvidersOfCategory = true;
      notifyListeners();
    });
    // Map<String, dynamic> headers = {
    //   "Accept-Language": lang,
    //   "Authorization": token
    // };
    Map<dynamic, dynamic> response = await dioNetWork(
        appLanguage: lang,
        methodType: 'get',
        netWorkWorking: MySettings.netWorkWorking(),
        url: EndPoints.baseurl +
            '/providersByCategory?category_id=${categoryid.toString()}');
    isloadingProvidersOfCategory = false;
    notifyListeners();
    if (response['status'] == false) {
      ProvidersOfCategorError = response['msg'];
      notifyListeners();
      return {'status': false, 'error': response['msg']};
    } else {
      providersofcategory = (response['data']['data'] as List)
          .map((e) => UserModel.fromJson(e))
          .toList();
      notifyListeners();
      return {
        'status': true,
      };
    }
  }
}
