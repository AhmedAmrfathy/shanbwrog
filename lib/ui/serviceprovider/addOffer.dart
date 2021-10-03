import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shanbwrog/Settings/MySettings.dart';
import 'package:shanbwrog/models/basic.dart';
import 'package:shanbwrog/models/category.dart';
import 'package:shanbwrog/providers/Auth.dart';
import 'package:shanbwrog/providers/serviceprovider/service_provider_offers.dart';
import 'package:shanbwrog/ui/general/appbar.dart';
import 'package:shanbwrog/ui/screens/main/mainActivity.dart';
import 'package:shanbwrog/ui/widgets/customButton.dart';
import 'package:shanbwrog/ui/widgets/formitem.dart';
import 'package:shanbwrog/ui/widgets/futurebuilder.dart';
import 'package:shanbwrog/ui/widgets/myToast.dart';
import 'package:shanbwrog/ui/widgets/my_loading_widget.dart';

class AddOffer extends StatelessWidget {
  TextEditingController offeraddress = TextEditingController();
  TextEditingController offerdetails = TextEditingController();
  TextEditingController offerimage = TextEditingController();
  TextEditingController offerimage2 = TextEditingController();
  TextEditingController offerimage3 = TextEditingController();
  TextEditingController offerimage4 = TextEditingController();
  TextEditingController offerpriceafter = TextEditingController();
  TextEditingController offerpricebefore = TextEditingController();
  TextEditingController title = TextEditingController();
  File? _image;
  File? _imag2;
  File? _imag3;
  File? _imag4;

  final picker = ImagePicker();
  var _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final devicesize = MediaQuery.of(context).size;
    final authlistener = Provider.of<AuthProvider>(context, listen: false);

    return SafeArea(
      child: Scaffold(
          body: ApiFutureBuilder(
        future:
            Provider.of<ServiceProviderOffersProvider>(context, listen: false)
                .getCategories(context,
                    EasyLocalization.of(context)!.currentLocale!.languageCode),
        consumer: Consumer<ServiceProviderOffersProvider>(
          builder: (ctx, data, ch) {
            return data.isloadingCategory
                ? myLoadingWidget(context, MySettings.maincolor)
                : Padding(
                    padding: EdgeInsets.all(15),
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            NewAppbar(
                              devicesize: devicesize,
                              text: tr('addoffer'),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Image.asset(
                              'assets/images/offer.png',
                              fit: BoxFit.fill,
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            FormItemWidget(
                                fill: true,
                                fillingcolor: Colors.white,
                                bordercolor: Colors.grey,
                                enablingborder: true,
                                borderRadious: 12,
                                label: tr('title'),
                                labelStyle:
                                    TextStyle(color: Colors.grey, fontSize: 19),
                                textEditingController: title,
                                validation: (value) {
                                  if (value == null) {
                                    return tr('requiredfield');
                                  }
                                }),
                            SizedBox(
                              height: 18,
                            ),
                            Container(
                              width: devicesize.width * .8,
                              child: DropdownButtonFormField(
                                  hint: Text(
                                    tr('service'),
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 19),
                                  decoration: InputDecoration(
                                      contentPadding: devicesize.width < 768
                                          ? EdgeInsets.all(15)
                                          : EdgeInsets.all(24),
                                      filled: true,
                                      fillColor: Colors.white,
                                      errorBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.red),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color:
                                                  Colors.grey.withOpacity(.8)),
                                          borderRadius:
                                              BorderRadius.circular(12))),
                                  value: data.selectedCategory,
                                  items: data.categories
                                      .map<DropdownMenuItem<Category>>(
                                          (item) => DropdownMenuItem(
                                                child: Text(item.name!),
                                                value: item,
                                              ))
                                      .toList(),
                                  onChanged: (Category? category) {
                                    data.selectedCategory = category;
                                  },
                                  validator: (value) {
                                    if (value == null) {
                                      return tr('requiredfield');
                                    }
                                  }),
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
                                label: tr('offeraddress'),
                                labelStyle:
                                    TextStyle(color: Colors.grey, fontSize: 19),
                                textEditingController: offeraddress,
                                validation: (value) {
                                  if (value == null) {
                                    return tr('requiredfield');
                                  }
                                }),
                            SizedBox(
                              height: 18,
                            ),
                            FormItemWidget(
                                fill: true,
                                fillingcolor: Colors.white,
                                bordercolor: Colors.grey,
                                enablingborder: true,
                                borderRadious: 12,
                                label: tr('offerdetails'),
                                labelStyle:
                                    TextStyle(color: Colors.grey, fontSize: 19),
                                textEditingController: offerdetails,
                                validation: (value) {
                                  if (value == null) {
                                    return tr('requiredfield');
                                  }
                                }),
                            SizedBox(
                              height: 18,
                            ),
                            StatefulBuilder(builder: (ctx, setitemState) {
                              return FormItemWidget(
                                  fill: true,
                                  fillingcolor: Colors.white,
                                  bordercolor: Colors.grey,
                                  enablingborder: true,
                                  borderRadious: 12,
                                  label: tr('offerimage'),
                                  labelStyle: TextStyle(
                                      color: Colors.grey, fontSize: 19),
                                  textEditingController: offerimage,
                                  suffixicon: IconButton(
                                    icon: Icon(
                                      Icons.image,
                                      color: MySettings.secondarycolor,
                                    ),
                                    onPressed: () async {
                                      await MySettings.getImage(
                                          imagecontroller: offerimage,
                                          image: _image,
                                          picker: picker,
                                          updateState: setitemState);
                                    },
                                  ),
                                  validation: (value) {
                                    if (value == null) {
                                      return tr('requiredfield');
                                    }
                                  });
                            }),
                            SizedBox(
                              height: 18,
                            ),
                            StatefulBuilder(builder: (ctx, setitemState) {
                              return FormItemWidget(
                                  fill: true,
                                  fillingcolor: Colors.white,
                                  bordercolor: Colors.grey,
                                  enablingborder: true,
                                  borderRadious: 12,
                                  label: tr('offerimage') + ' 2',
                                  labelStyle: TextStyle(
                                      color: Colors.grey, fontSize: 19),
                                  textEditingController: offerimage2,
                                  suffixicon: IconButton(
                                    icon: Icon(
                                      Icons.image,
                                      color: MySettings.secondarycolor,
                                    ),
                                    onPressed: () async {
                                      await MySettings.getImage(
                                          imagecontroller: offerimage2,
                                          image: _imag2,
                                          picker: picker,
                                          updateState: setitemState);
                                    },
                                  ),
                                  validation: (value) {
                                    if (value == null) {
                                      return tr('requiredfield');
                                    }
                                  });
                            }),
                            SizedBox(
                              height: 18,
                            ),
                            StatefulBuilder(builder: (ctx, setitemState) {
                              return FormItemWidget(
                                  fill: true,
                                  fillingcolor: Colors.white,
                                  bordercolor: Colors.grey,
                                  enablingborder: true,
                                  borderRadious: 12,
                                  label: tr('offerimage') + ' 3',
                                  labelStyle: TextStyle(
                                      color: Colors.grey, fontSize: 19),
                                  textEditingController: offerimage3,
                                  suffixicon: IconButton(
                                    icon: Icon(
                                      Icons.image,
                                      color: MySettings.secondarycolor,
                                    ),
                                    onPressed: () async {
                                      await MySettings.getImage(
                                          imagecontroller: offerimage3,
                                          image: _imag3,
                                          picker: picker,
                                          updateState: setitemState);
                                    },
                                  ),
                                  validation: (value) {
                                    if (value == null) {
                                      return tr('requiredfield');
                                    }
                                  });
                            }),
                            SizedBox(
                              height: 18,
                            ),
                            StatefulBuilder(builder: (ctx, setitemState) {
                              return FormItemWidget(
                                  fill: true,
                                  fillingcolor: Colors.white,
                                  bordercolor: Colors.grey,
                                  enablingborder: true,
                                  borderRadious: 12,
                                  label: tr('offerimage') + ' 4',
                                  labelStyle: TextStyle(
                                      color: Colors.grey, fontSize: 19),
                                  textEditingController: offerimage4,
                                  suffixicon: IconButton(
                                    icon: Icon(
                                      Icons.image,
                                      color: MySettings.secondarycolor,
                                    ),
                                    onPressed: () async {
                                      await MySettings.getImage(
                                          imagecontroller: offerimage4,
                                          image: _imag4,
                                          picker: picker,
                                          updateState: setitemState);
                                    },
                                  ),
                                  validation: (value) {
                                    if (value == null) {
                                      return tr('requiredfield');
                                    }
                                  });
                            }),
                            SizedBox(
                              height: 18,
                            ),
                            FormItemWidget(
                                fill: true,
                                fillingcolor: Colors.white,
                                bordercolor: Colors.grey,
                                enablingborder: true,
                                borderRadious: 12,
                                label: tr('offerpriceafter'),
                                labelStyle:
                                    TextStyle(color: Colors.grey, fontSize: 19),
                                textEditingController: offerpriceafter,
                                validation: (value) {
                                  if (value == null) {
                                    return tr('requiredfield');
                                  }
                                }),
                            SizedBox(
                              height: 18,
                            ),
                            FormItemWidget(
                                fill: true,
                                fillingcolor: Colors.white,
                                bordercolor: Colors.grey,
                                enablingborder: true,
                                borderRadious: 12,
                                label: tr('offerpricebefore'),
                                labelStyle:
                                    TextStyle(color: Colors.grey, fontSize: 19),
                                textEditingController: offerpricebefore,
                                validation: (value) {
                                  if (value == null) {
                                    return tr('requiredfield');
                                  }
                                }),
                            SizedBox(
                              height: 26,
                            ),
                            Consumer<ServiceProviderOffersProvider>(
                              builder: (ctx, data, ch) {
                                return data.isloadingaddingoffer
                                    ? myLoadingWidget(
                                        context, MySettings.maincolor)
                                    : CustomButton(tr('add'), () async {
                                        if (_formkey.currentState!.validate()) {
                                          await Provider.of<
                                                      ServiceProviderOffersProvider>(
                                                  context,
                                                  listen: false)
                                              .addOffer(
                                                  context: context,
                                                  lang: EasyLocalization
                                                          .of(context)!
                                                      .currentLocale!
                                                      .languageCode,
                                                  title: title.text,
                                                  details: offerdetails.text,
                                                  price: offerpriceafter.text,
                                                  old_price:
                                                      offerpricebefore.text,
                                                  category_id: data
                                                      .selectedCategory!.id!,
                                                  img: offerimage.text,
                                                  img2: offerimage2.text,
                                                  img3: offerimage3.text,
                                                  img4: offerimage4.text)
                                              .then((value) {
                                            if (value['status'] == true) {
                                              Navigator.of(context)
                                                  .pushAndRemoveUntil(
                                                      MaterialPageRoute(
                                                          builder: (ctx) =>
                                                              MainActivity(
                                                                  'provider')),
                                                      (route) => false);
                                            } else {
                                              showMyToast(context,
                                                  value['error'], 'error');
                                            }
                                          });
                                        }
                                      });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
          },
        ),
      )),
    );
  }
}
