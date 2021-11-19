import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shanbwrog/Settings/MySettings.dart';
import 'package:shanbwrog/models/basic.dart';
import 'package:shanbwrog/models/category.dart';
import 'package:shanbwrog/providers/Auth.dart';
import 'package:shanbwrog/providers/serviceprovider/service_provider_offers.dart';
import 'package:shanbwrog/providers/serviceprovider/service_provider_services.dart';
import 'package:shanbwrog/ui/general/appbar.dart';
import 'package:shanbwrog/ui/screens/main/mainActivity.dart';
import 'package:shanbwrog/ui/widgets/customButton.dart';
import 'package:shanbwrog/ui/widgets/formitem.dart';
import 'package:shanbwrog/ui/widgets/myToast.dart';
import 'package:shanbwrog/ui/widgets/my_loading_widget.dart';

class AddService extends StatefulWidget {
  bool updatePage;
  Category? category;

  AddService({this.updatePage = false, this.category});

  @override
  _AddServiceState createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  Future getFutureData() async {
    await Provider.of<ServiceProviderServicesProvider>(context, listen: false)
        .getCategories(
            context, EasyLocalization.of(context)!.currentLocale!.languageCode,
            updatePage: widget.updatePage,
            selectedCategoryItem: widget.updatePage ? widget.category : null);
  }

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

  TextEditingController servicename = TextEditingController();

  TextEditingController servicedetails = TextEditingController();

  TextEditingController serviceprice = TextEditingController();

  TextEditingController serviceimage = TextEditingController();

  TextEditingController serviceimage2 = TextEditingController();

  TextEditingController serviceimage3 = TextEditingController();

  TextEditingController serviceimage4 = TextEditingController();
  File? _image;

  File? _imag2;

  File? _imag3;

  File? _imag4;

  final picker = ImagePicker();

  var _formkey = GlobalKey<FormState>();

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
    servicedetails.text = widget.category!.details!;
    serviceprice.text = widget.category!.price!;
    serviceimage.text = widget.category!.img!;
    serviceimage2.text = widget.category!.img2!;
    serviceimage3.text = widget.category!.img3!;
    serviceimage4.text = widget.category!.img4!;
    servicename.text = widget.category!.name!;
  }

  @override
  Widget build(BuildContext context) {
    final devicesize = MediaQuery.of(context).size;
    final authlistener = Provider.of<AuthProvider>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        body:
            Consumer<ServiceProviderServicesProvider>(builder: (ctx, data, ch) {
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
                                text: tr('addservice'),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Image.asset(
                                'assets/images/addservice.png',
                                fit: BoxFit.fill,
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Container(
                                width: devicesize.width * .8,
                                child: DropdownButtonFormField(
                                    isExpanded: true,
                                    hint: Text(
                                      tr('service'),
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 17),
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
                                        ;
                                      }
                                    }),
                              ),
                              SizedBox(
                                height: 18,
                              ),
                              Container(
                                width: devicesize.width * .8,
                                child: DropdownButtonFormField(
                                    isExpanded: true,
                                    hint: Text(
                                      tr('category'),
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 17),
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
                                    value: data.selectedSection,
                                    items: data.sections
                                        .map<DropdownMenuItem<Basic>>(
                                            (item) => DropdownMenuItem(
                                                  child: Text(item.name!),
                                                  value: item,
                                                ))
                                        .toList(),
                                    onChanged: (Basic? section) {
                                      data.selectedSection = section;
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
                                label: tr('name'),
                                labelStyle:
                                    TextStyle(color: Colors.grey, fontSize: 19),
                                textEditingController: servicename,
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
                                label: tr('price'),
                                labelStyle:
                                    TextStyle(color: Colors.grey, fontSize: 19),
                                textEditingController: serviceprice,
                                keyboardtype: TextInputType.number,
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
                                label: tr('servicedetails'),
                                labelStyle:
                                    TextStyle(color: Colors.grey, fontSize: 19),
                                textEditingController: servicedetails,
                              ),
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
                                        label: tr('serviceimage'),
                                        readonly: true,
                                        labelStyle: TextStyle(
                                            color: Colors.grey, fontSize: 19),
                                        textEditingController: serviceimage,
                                        suffixicon: IconButton(
                                          icon: Icon(
                                            Icons.image,
                                            color: MySettings.secondarycolor,
                                          ),
                                          onPressed: () async {
                                            getImage(
                                                setitemState, serviceimage, 1);
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
                                                        widget.category!.img!,
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
                                        label: tr('serviceimage') + ' 2',
                                        labelStyle: TextStyle(
                                            color: Colors.grey, fontSize: 19),
                                        textEditingController: serviceimage2,
                                        readonly: true,
                                        suffixicon: IconButton(
                                          icon: Icon(
                                            Icons.image,
                                            color: MySettings.secondarycolor,
                                          ),
                                          onPressed: () async {
                                            await getImage(
                                                setitemState, serviceimage2, 2);
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
                                                        widget.category!.img2!,
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
                                        label: tr('serviceimage') + ' 3',
                                        readonly: true,
                                        labelStyle: TextStyle(
                                            color: Colors.grey, fontSize: 19),
                                        textEditingController: serviceimage3,
                                        suffixicon: IconButton(
                                          icon: Icon(
                                            Icons.image,
                                            color: MySettings.secondarycolor,
                                          ),
                                          onPressed: () async {
                                            await getImage(
                                                setitemState, serviceimage3, 3);
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
                                                        widget.category!.img3!,
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
                                        label: tr('serviceimage') + ' 4',
                                        readonly: true,
                                        labelStyle: TextStyle(
                                            color: Colors.grey, fontSize: 19),
                                        textEditingController: serviceimage4,
                                        suffixicon: IconButton(
                                          icon: Icon(
                                            Icons.image,
                                            color: MySettings.secondarycolor,
                                          ),
                                          onPressed: () async {
                                            await getImage(
                                                setitemState, serviceimage4, 4);
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
                                                        widget.category!.img3!,
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
                              Consumer<ServiceProviderServicesProvider>(
                                builder: (ctx, data, ch) {
                                  return data.isloadingaddingservice ||
                                          data.isloadingEditingService
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
                                              await Provider.of<ServiceProviderServicesProvider>(
                                                      context,
                                                      listen: false)
                                                  .editService(
                                                      widget.category!.id!,
                                                      context: context,
                                                      lang: EasyLocalization
                                                              .of(context)!
                                                          .currentLocale!
                                                          .languageCode,
                                                      name: servicename.text,
                                                      type:
                                                          data.selectedSection!
                                                              .id!,
                                                      details:
                                                          servicedetails.text,
                                                      price: serviceprice.text,
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
                                                          ServiceProviderServicesProvider>(
                                                      context,
                                                      listen: false)
                                                  .addService(
                                                      context: context,
                                                      lang: EasyLocalization
                                                              .of(context)!
                                                          .currentLocale!
                                                          .languageCode,
                                                      name: servicename.text,
                                                      type: data
                                                          .selectedSection!.id!,
                                                      details:
                                                          servicedetails.text,
                                                      price: serviceprice.text,
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
        }),
      ),
    );
  }
}
