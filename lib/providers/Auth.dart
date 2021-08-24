import 'package:flutter/cupertino.dart';
import 'package:shanbwrog/models/basic.dart';

class AuthProvider with ChangeNotifier {
  List<Basic> countries = [
    Basic(name: 'مصر', id: 1),
    Basic(name: 'السعوديه', id: 2),
    Basic(name: 'الامارات', id: 3)
  ];
  Basic? selected;
}
