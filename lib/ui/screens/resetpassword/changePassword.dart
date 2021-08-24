import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shanbwrog/ui/general/appbar.dart';
import 'package:shanbwrog/ui/widgets/customButton.dart';
import 'package:shanbwrog/ui/widgets/formitem.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController _password = TextEditingController();
  bool _showpassword = false;
  TextEditingController _npassword = TextEditingController();
  bool _shownpassword = false;
  TextEditingController _cnpassword = TextEditingController();
  bool _cshownpassword = false;

  @override
  Widget build(BuildContext context) {
    final devicesize = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: Padding(padding: EdgeInsets.all(20),
        child: Column(
          children: [
            NewAppbar(
              devicesize: devicesize,
              text: tr('changepassword'),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 18,
            ),
            FormItemWidget(
              fill: true,
              fillingcolor: Colors.white,
              bordercolor: Colors.grey,
              enablingborder: true,
              borderRadious: 12,
              hidepassword: _showpassword ? false : true,
              label: tr('currentpassword'),
              labelStyle: TextStyle(color: Colors.grey, fontSize: 19),
              textEditingController: _password,
              suffixicon: IconButton(
                icon: Icon(Icons.remove_red_eye),
                color: Colors.grey,
                onPressed: () {
                  setState(() {
                    _showpassword = !_showpassword;
                  });
                },
              ),
            ),
            SizedBox(
              height: 18,
            ),
            FormItemWidget(
              fill: true,
              fillingcolor: Colors.white,
              bordercolor: Colors.grey,
              enablingborder: true,
              borderRadious: 12,
              hidepassword: _shownpassword ? false : true,
              label: tr('newpassword'),
              labelStyle: TextStyle(color: Colors.grey, fontSize: 19),
              textEditingController: _npassword,
              suffixicon: IconButton(
                icon: Icon(Icons.remove_red_eye),
                color: Colors.grey,
                onPressed: () {
                  setState(() {
                    _shownpassword = !_shownpassword;
                  });
                },
              ),
            ),
            SizedBox(
              height: 18,
            ),
            FormItemWidget(
              fill: true,
              fillingcolor: Colors.white,
              bordercolor: Colors.grey,
              enablingborder: true,
              borderRadious: 12,
              hidepassword: _cshownpassword ? false : true,
              label: tr('confirmnewpassword'),
              labelStyle: TextStyle(color: Colors.grey, fontSize: 19),
              textEditingController: _cnpassword,
              suffixicon: IconButton(
                icon: Icon(Icons.remove_red_eye),
                color: Colors.grey,
                onPressed: () {
                  setState(() {
                    _cshownpassword = !_cshownpassword;
                  });
                },
              ),
            ),
            SizedBox(
              height: 18,
            ),
            CustomButton(tr('save'), () {})
          ],
        ),
      ),
    ));
  }
}
