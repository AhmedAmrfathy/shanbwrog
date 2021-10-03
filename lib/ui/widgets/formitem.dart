import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormItemWidget extends StatelessWidget {
  final String? Function(String? x)? validation;
  final String? Function(String? x)? onsave;
  final String? Function(String? x)? onchange;
  final Function()? oncomplete;
  final Function()? ontap;
  final double? width;
  final String? hinttext;
  final bool? fill;
  final bool enablingborder;
  final bool? hidepassword;
  final Color? fillingcolor;
  final Color? hintcolor;
  final Color? bordercolor;
  final TextEditingController? textEditingController;
  final Widget? prefixicon;
  final Widget? suffixicon;
  final TextInputType? keyboardtype;
  final bool readonly;
  final List<TextInputFormatter>? inputformatters;
  final TextDirection? textdirection;
  final String? initialvalue;
  final double? borderRadious;
  final String? label;
  final TextStyle? labelStyle;

  FormItemWidget({
    this.labelStyle,
    this.label,
    this.borderRadious,
    this.validation,
    this.onsave,
    this.ontap,
    this.oncomplete,
    this.width,
    this.hinttext,
    this.initialvalue,
    this.textEditingController,
    this.hidepassword = false,
    this.fill = false,
    this.fillingcolor,
    this.hintcolor,
    this.enablingborder = true,
    this.bordercolor,
    this.prefixicon,
    this.suffixicon,
    this.keyboardtype,
    this.readonly = false,
    this.onchange,
    this.inputformatters,
    this.textdirection,
  });

  @override
  Widget build(BuildContext context) {
    final devicesize = MediaQuery.of(context).size;
    Map<int, dynamic> myResp = getResponseve(context: context);
    return Container(
      width: devicesize.width * .8,
      child: TextFormField(
        initialValue: initialvalue,
        textDirection: textdirection,
        style: TextStyle(color: Color(0xFF4A4A4A)),
        readOnly: readonly,
        keyboardType: keyboardtype,
        validator: validation,
        inputFormatters: inputformatters,
        onSaved: onsave,
        onTap: ontap,
        onEditingComplete: oncomplete,
        controller: textEditingController,
        decoration: InputDecoration(
            labelStyle: labelStyle,
            labelText: label,
            hintText: hinttext,
            hintStyle: TextStyle(
                fontSize: 12, color: hintcolor == null ? null : hintcolor),
            contentPadding: EdgeInsets.symmetric(
                horizontal: myResp[1], vertical: myResp[1]),
            filled: fillingcolor == null ? false : true,
            fillColor: fillingcolor,
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.withOpacity(.3)),
                borderRadius: BorderRadius.circular(myResp[2])),
            focusedBorder: enablingborder
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadious!),
                    borderSide: BorderSide(
                        color: bordercolor == null
                            ? Color.fromRGBO(232, 232, 232, 1)
                            : bordercolor!))
                : null,
            enabledBorder: enablingborder
                ? OutlineInputBorder(
                    borderSide: BorderSide(
                        color: bordercolor == null
                            ? Color.fromRGBO(232, 232, 232, 1)
                            : bordercolor!),
                    borderRadius: BorderRadius.circular(borderRadious!))
                : null,
            prefixIcon: prefixicon == null ? null : prefixicon,
            suffixIcon: suffixicon == null ? null : suffixicon),
        obscureText: hidepassword == null
            ? false
            : hidepassword!
                ? true
                : false,
      ),
    );
  }
}

//=======================REsponsive====================================
/*
// on Genymotion
isSmall = width <= 330.0 ( width 320  Google Nexus S  480 x 800  )
isMedium 1 = width <= 410.0  ( width 360  Google Nexus 5  1080 x 1920  )
isMedium 2 = width <= 576.0  ( width 411  Google Nexus 6p  1440 x 2560  )
isNormal = width <= 768.0  ( width 600.938  Google Nexus 7  800 x 1280  )
isLarge = width <= 992.0  ( width 960.938  Sony Xperia Tablet Z  1920 x 1200  )
isXLarge = width <= 1500.0  ( width 1202  Google Nexus 10  2560 x 1600  )
*/
Map<int, dynamic> getResponseve({
  BuildContext? context,
  double wid = 0.0,
  double hieg = 0.0,
}) {
  late Map<int, dynamic> myValues;
  double width = 0.0;
  double height = 0.0;
  if (wid > 0.0 && hieg > 0.0) {
    width = wid;
    height = hieg;
  } else {
    width = MediaQuery.of(context!).size.width;
    height = MediaQuery.of(context).size.height;
  }
  //final double height = MediaQuery.of(cont).size.height;
  //final String orient = MediaQuery.of(cont).orientation.toString(,

  final bool isSmall = width <= 330.0; // small screen with portrait Orientation
  final bool isMedium1 = width <=
      410.0; // small screen with landscape Orientation and normall screen with portrait Orientation
  final bool isMedium2 = width <=
      576.0; // small screen with landscape Orientation and normall screen with portrait Orientation
  final bool isNormal = width <=
      768.0; // large screen with portrait Orientation and normall screen with landscape Orientation
  final bool isLarge = width <=
      992.0; // large screen with landscape Orientation and Xlarge screen with portrait Orientation
  final bool isXlarge =
      width <= 1550.0; // Xlarge screen with landscape Orientation

  if (isSmall) {
    // nuxes S
    myValues = {
      1: 14.0, //content padding vertical and horizontal
      2: 40.0, //border radius circular
    };
  } else if (isMedium1) {
    // nuxes 5
    myValues = {
      1: 17.0, //content padding vertical and horizontal
      2: 40.0, //border radius circular
    };
  } else if (isMedium2) {
    // nuxes 6p

    myValues = {
      1: 17.0, //content padding vertical and horizontal
      2: 40.0, //border radius circular
    };
  } else if (isNormal) {
    if (width > height) {
      // nuxes 5 rotation
      myValues = {
        1: 17.0, //content padding vertical and horizontal
        2: 40.0, //border radius circular
      };
    } else {
      // nuxes 7

      myValues = {
        1: 31.0, //content padding vertical and horizontal
        2: 40.0, //border radius circular
      };
    }
  } else if (isLarge) {
    // nuxes 7 rotation
    myValues = {
      1: 20.0, //content padding vertical and horizontal
      2: 40.0, //border radius circular
    };
  } else if (isXlarge) {
    //nuxes 10
    myValues = {
      1: 20.0, //content padding vertical and horizontal
      2: 40.0, //border radius circular
    };
  }
  return myValues;
}
