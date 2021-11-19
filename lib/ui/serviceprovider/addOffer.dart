import 'dart:io';

import 'package:async/async.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shanbwrog/Settings/MySettings.dart';
import 'package:shanbwrog/models/basic.dart';
import 'package:shanbwrog/models/category.dart';
import 'package:shanbwrog/models/offer.dart';
import 'package:shanbwrog/providers/Auth.dart';
import 'package:shanbwrog/providers/serviceprovider/service_provider_offers.dart';
import 'package:shanbwrog/ui/general/appbar.dart';
import 'package:shanbwrog/ui/screens/main/mainActivity.dart';
import 'package:shanbwrog/ui/widgets/customButton.dart';
import 'package:shanbwrog/ui/widgets/formitem.dart';
import 'package:shanbwrog/ui/widgets/futurebuilder.dart';
import 'package:shanbwrog/ui/widgets/myToast.dart';
import 'package:shanbwrog/ui/widgets/my_loading_widget.dart';

class AddOffer extends StatefulWidget {
  bool updatePage;
  Offer? offer;

  AddOffer({this.updatePage = false, this.offer});

  @override
  _AddOfferState createState() => _AddOfferState();
}

class _AddOfferState extends State<AddOffer> {
  Future getFutureData() async {
    await Provider.of<ServiceProviderOffersProvider>(context, listen: false)
        .getCategories(
            context, EasyLocalization.of(context)!.currentLocale!.languageCode,
            updatePage: widget.updatePage,
            selectedCategoryItem:
                widget.updatePage ? widget.offer!.category : null);
  }

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

  Future getImage(Function? updateState, TextEditingController controller,
      int imgNum) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    updateState!(() {
      if (imgNum == 1) {
        _image = File(pickedFile!.path);
      } else if (imgNum == 2) {
        _imag2 = File(pickedFile!.path);
      } else if (imgNum == 3) {
        _imag3 = File(pickedFile!.path);
      } else if (imgNum == 4) {
        _imag4 = File(pickedFile!.path);
      }
      controller.text = _image!.path;
      print(_image!.path);
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 0), () {
      getFutureData();
    });
    if (widget.updatePage) {
      fillDataBeforeUpdate();
    }
  }

  fillDataBeforeUpdate() {
    offerdetails.text = widget.offer!.details!;
    offerimage.text = widget.offer!.img!;
    offerimage2.text = widget.offer!.img2!;
    offerimage3.text = widget.offer!.img3!;
    offerimage4.text = widget.offer!.img4!;
    offerpriceafter.text = widget.offer!.price!;
    offerpricebefore.text = widget.offer!.oldPrice!;
    title.text = widget.offer!.title!;
  }

  @override
  Widget build(BuildContext context) {
    final devicesize = MediaQuery.of(context).size;
    final authlistener = Provider.of<AuthProvider>(context, listen: false);

    return SafeArea(
      child: Scaffold(body: Consumer<ServiceProviderOffersProvider>(
        builder: (ctx, data, ch) {
          return data.isloadingCategory
              ? myLoadingWidget(context, MySettings.maincolor)
              : data.errorCategory != null
                  ? Center(
                      child: Text(data.errorCategory!),
                    )
                  : Padding(
                      padding: EdgeInsets.all(15),
                      child: SingleChildScrollView(
                        child: Form(
                          key: _formkey,
                          child: Column(
                            children: [
                              NewAppbar(
                                devicesize: devicesize,
                                text: widget.updatePage
                                    ? tr('editoffer')
                                    : tr('addoffer'),
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
                                  labelStyle: TextStyle(
                                      color: Colors.grey, fontSize: 19),
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
                                                color: Colors.grey
                                                    .withOpacity(.8)),
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
                              // FormItemWidget(
                              //     fill: true,
                              //     fillingcolor: Colors.white,
                              //     bordercolor: Colors.grey,
                              //     enablingborder: true,
                              //     borderRadious: 12,
                              //     label: tr('offeraddress'),
                              //     labelStyle: TextStyle(
                              //         color: Colors.grey, fontSize: 19),
                              //     textEditingController: offeraddress,
                              //     validation: (value) {
                              //       if (value == null) {
                              //         return tr('requiredfield');
                              //       }
                              //     }),
                              // SizedBox(
                              //   height: 18,
                              // ),
                              FormItemWidget(
                                  fill: true,
                                  fillingcolor: Colors.white,
                                  bordercolor: Colors.grey,
                                  enablingborder: true,
                                  borderRadious: 12,
                                  label: tr('offerdetails'),
                                  labelStyle: TextStyle(
                                      color: Colors.grey, fontSize: 19),
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
                                return Column(
                                  children: [
                                    FormItemWidget(
                                        fill: true,
                                        fillingcolor: Colors.white,
                                        bordercolor: Colors.grey,
                                        enablingborder: true,
                                        borderRadious: 12,
                                        label: tr('offerimage'),
                                        keyboardtype: TextInputType.number,
                                        readonly: true,
                                        labelStyle: TextStyle(
                                            color: Colors.grey, fontSize: 19),
                                        textEditingController: offerimage,
                                        suffixicon: IconButton(
                                          icon: Icon(
                                            Icons.image,
                                            color: MySettings.secondarycolor,
                                          ),
                                          onPressed: () async {
                                            getImage(
                                                setitemState, offerimage, 1);
                                          },
                                        ),
                                        validation: (value) {
                                          if (value == null || value == '') {
                                            return tr('requiredfield');
                                          }
                                        }),
                                    widget.updatePage == false && _image == null
                                        ? Container()
                                        : SizedBox(
                                            height: 18,
                                          ),
                                    widget.updatePage == false && _image == null
                                        ? Container()
                                        : Container(
                                            width: devicesize.width * .6,
                                            height: devicesize.height * .3,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: ClipRRect(
                                                child: widget.updatePage &&
                                                        _image == null
                                                    ? Image.network(
                                                        widget.offer!.img!,
                                                        fit: BoxFit.fill,
                                                      )
                                                    : Image.file(
                                                        File(_image!.path),
                                                        fit: BoxFit.fill,
                                                      )),
                                          ),
                                  ],
                                );
                              }),
                              SizedBox(
                                height: 18,
                              ),
                              StatefulBuilder(builder: (ctx, setitemState) {
                                return Column(
                                  children: [
                                    FormItemWidget(
                                        fill: true,
                                        fillingcolor: Colors.white,
                                        bordercolor: Colors.grey,
                                        enablingborder: true,
                                        borderRadious: 12,
                                        label: tr('offerimage') + ' 2',
                                        keyboardtype: TextInputType.number,
                                        labelStyle: TextStyle(
                                            color: Colors.grey, fontSize: 19),
                                        textEditingController: offerimage2,
                                        suffixicon: IconButton(
                                          icon: Icon(
                                            Icons.image,
                                            color: MySettings.secondarycolor,
                                          ),
                                          onPressed: () async {
                                            await getImage(
                                                setitemState, offerimage2, 2);
                                          },
                                        ),
                                        validation: (value) {
                                          if (value == null || value == '') {
                                            return tr('requiredfield');
                                          }
                                        }),
                                    widget.updatePage == false && _imag2 == null
                                        ? Container()
                                        : SizedBox(
                                            height: 18,
                                          ),
                                    widget.updatePage == false && _imag2 == null
                                        ? Container()
                                        : Container(
                                            width: devicesize.width * .6,
                                            height: devicesize.height * .3,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: ClipRRect(
                                                child: widget.updatePage &&
                                                        _imag2 == null
                                                    ? Image.network(
                                                        widget.offer!.img2!,
                                                        fit: BoxFit.fill,
                                                      )
                                                    : Image.file(
                                                        File(_imag2!.path),
                                                        fit: BoxFit.fill,
                                                      )),
                                          ),
                                  ],
                                );
                              }),
                              SizedBox(
                                height: 18,
                              ),
                              StatefulBuilder(builder: (ctx, setitemState) {
                                return Column(
                                  children: [
                                    FormItemWidget(
                                        fill: true,
                                        fillingcolor: Colors.white,
                                        bordercolor: Colors.grey,
                                        enablingborder: true,
                                        borderRadious: 12,
                                        label: tr('offerimage') + ' 3',
                                        keyboardtype: TextInputType.number,
                                        labelStyle: TextStyle(
                                            color: Colors.grey, fontSize: 19),
                                        textEditingController: offerimage3,
                                        suffixicon: IconButton(
                                          icon: Icon(
                                            Icons.image,
                                            color: MySettings.secondarycolor,
                                          ),
                                          onPressed: () async {
                                            await getImage(
                                                setitemState, offerimage3, 3);
                                          },
                                        ),
                                        validation: (value) {
                                          if (value == null || value == '') {
                                            return tr('requiredfield');
                                          }
                                        }),
                                    widget.updatePage == false && _imag3 == null
                                        ? Container()
                                        : SizedBox(
                                            height: 18,
                                          ),
                                    widget.updatePage == false && _imag3 == null
                                        ? Container()
                                        : Container(
                                            width: devicesize.width * .6,
                                            height: devicesize.height * .3,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: ClipRRect(
                                                child: widget.updatePage &&
                                                        _imag3 == null
                                                    ? Image.network(
                                                        widget.offer!.img3!,
                                                        fit: BoxFit.fill,
                                                      )
                                                    : Image.file(
                                                        File(_imag3!.path),
                                                        fit: BoxFit.fill,
                                                      )),
                                          ),
                                  ],
                                );
                              }),
                              SizedBox(
                                height: 18,
                              ),
                              StatefulBuilder(builder: (ctx, setitemState) {
                                return Column(
                                  children: [
                                    FormItemWidget(
                                        fill: true,
                                        fillingcolor: Colors.white,
                                        bordercolor: Colors.grey,
                                        enablingborder: true,
                                        borderRadious: 12,
                                        label: tr('offerimage') + ' 4',
                                        keyboardtype: TextInputType.number,
                                        labelStyle: TextStyle(
                                            color: Colors.grey, fontSize: 19),
                                        textEditingController: offerimage4,
                                        suffixicon: IconButton(
                                          icon: Icon(
                                            Icons.image,
                                            color: MySettings.secondarycolor,
                                          ),
                                          onPressed: () async {
                                            await getImage(
                                                setitemState, offerimage4, 4);
                                          },
                                        ),
                                        validation: (value) {
                                          if (value == null || value == '') {
                                            return tr('requiredfield');
                                          }
                                        }),
                                    widget.updatePage == false && _imag4 == null
                                        ? Container()
                                        : SizedBox(
                                            height: 18,
                                          ),
                                    widget.updatePage == false && _imag4 == null
                                        ? Container()
                                        : Container(
                                            width: devicesize.width * .6,
                                            height: devicesize.height * .3,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: ClipRRect(
                                                child: widget.updatePage &&
                                                        _imag4 == null
                                                    ? Image.network(
                                                        widget.offer!.img3!,
                                                        fit: BoxFit.fill,
                                                      )
                                                    : Image.file(
                                                        File(_imag4!.path),
                                                        fit: BoxFit.fill,
                                                      )),
                                          )
                                  ],
                                );
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
                                  keyboardtype: TextInputType.number,
                                  labelStyle: TextStyle(
                                      color: Colors.grey, fontSize: 19),
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
                                  labelStyle: TextStyle(
                                      color: Colors.grey, fontSize: 19),
                                  keyboardtype: TextInputType.number,
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
                                  return data.isloadingaddingoffer ||
                                          data.isloadingEditingoffer
                                      ? myLoadingWidget(
                                          context, MySettings.maincolor)
                                      : CustomButton(
                                          widget.updatePage
                                              ? tr('edit')
                                              : tr('add'), () async {
                                          FocusScope.of(context).unfocus();
                                          if (_formkey.currentState!
                                              .validate()) {
                                            if (widget.updatePage) {
                                              await Provider.of<
                                                          ServiceProviderOffersProvider>(
                                                      context,
                                                      listen: false)
                                                  .editOffer(widget.offer!.id!,
                                                      context: context,
                                                      lang: EasyLocalization
                                                              .of(context)!
                                                          .currentLocale!
                                                          .languageCode,
                                                      title: title.text,
                                                      details:
                                                          offerdetails.text,
                                                      price:
                                                          offerpriceafter.text,
                                                      old_price:
                                                          offerpricebefore.text,
                                                      category_id: data
                                                          .selectedCategory!
                                                          .id!,
                                                      img: _image != null
                                                          ? _image!.path
                                                          : null,
                                                      img2: _imag2 != null
                                                          ? _imag2!.path
                                                          : null,
                                                      img3: _imag3 != null
                                                          ? _imag3!.path
                                                          : null,
                                                      img4: _imag4 != null
                                                          ? _imag4!.path
                                                          : null)
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
                                            } else {
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
                                                      details:
                                                          offerdetails.text,
                                                      price:
                                                          offerpriceafter.text,
                                                      old_price:
                                                          offerpricebefore.text,
                                                      category_id: data
                                                          .selectedCategory!
                                                          .id!,
                                                      img: _image!.path,
                                                      img2: _imag2!.path,
                                                      img3: _imag3!.path,
                                                      img4: _imag4!.path)
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
      )),
    );
  }
}
