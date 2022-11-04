import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:plix/helpers/ui_helpers.dart';
import 'package:plix/networks/api_acess.dart';

import '../../../constants/app_color.dart';
import '../../../constants/app_constants.dart';
import '../../../constants/text_font_style.dart';
import '../../../helpers/navigation_service.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool checkbox = true;
  String radioValue = "";
  bool validation = false;
  List<int> selectedAddOns = [];
  TextEditingController noteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: SingleChildScrollView(
        child: StreamBuilder(
            stream: getProductDetailRXObj.getProductDetailData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Map foodData = snapshot.data['data']["food"];
                List options = snapshot.data['data']["food"]["options"];
                List addOns = snapshot.data['data']["food"]["addons"];
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(children: [
                        Image.network(
                          foodData["image_full_path"] ?? "",
                          height: .38.sh,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                            top: 10,
                            left: 10,
                            child: InkWell(
                              child:
                                  Icon(Icons.arrow_back, color: Colors.white),
                              onTap: () {
                                NavigationService.goBack;
                              },
                            )),
                      ]),
                      UIHelper.verticalSpaceSmall,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.r),
                        child: Text(
                          "Descrição Produto",
                          style: TextFontStyle.headline2StyleInter
                              .copyWith(color: AppColors.appColor000000),
                        ),
                      ),
                      UIHelper.verticalSpaceMedium,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.r),
                        child: Text(
                          "Selecione uma opção",
                          style: TextFontStyle.headline7StyleInter
                              .copyWith(color: AppColors.appColor9B9B9B),
                        ),
                      ),
                      UIHelper.verticalSpaceMedium,
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: options.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          if (radioValue == "" &&
                              options[index]["is_default"] == 1) {
                            radioValue = options[index]["name"];
                          }
                          return RadioListTile(
                            secondary: Text(options[index]["price_in_euro"]),
                            title: Text(
                              options[index]["name"],
                              style: TextFontStyle.headline5StyleInter
                                  .copyWith(color: AppColors.appColor2C303E),
                            ),
                            subtitle: Text(
                              options[index]["description"],
                              style: TextFontStyle.headline7StyleInter
                                  .copyWith(color: AppColors.appColor9B9B9B),
                            ),
                            value: options[index]["name"],
                            selected: radioValue == options[index]["name"],
                            groupValue: radioValue,
                            onChanged: (value) {
                              setState(() {
                                radioValue = value as String;
                              });
                              log(radioValue);
                            },
                          );
                        },
                      ),
                      UIHelper.verticalSpaceMedium,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.r),
                        child: Text(
                          "Selecione uma opção ingrediente extra",
                          style: TextFontStyle.headline7StyleInter
                              .copyWith(color: AppColors.appColor9B9B9B),
                        ),
                      ),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: addOns.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            trailing: Text(addOns[index]["price_in_euro"]),
                            leading: Checkbox(
                              value:
                                  selectedAddOns.contains(addOns[index]["id"]),
                              onChanged: (value) {
                                setState(() {
                                  if (selectedAddOns
                                      .contains(addOns[index]["id"]))
                                    selectedAddOns.remove(addOns[index]["id"]);
                                  else
                                    selectedAddOns.add(addOns[index]["id"]);
                                  // calculateTotal();
                                });
                                setState(() {
                                  checkbox = value!;
                                });
                              },
                            ),
                            title: Text(
                              addOns[index]["name"],
                              style: TextFontStyle.headline5StyleInter
                                  .copyWith(color: AppColors.appColor2C303E),
                            ),
                            subtitle: Text(
                              addOns[index]["description"],
                              style: TextFontStyle.headline7StyleInter
                                  .copyWith(color: AppColors.appColor9B9B9B),
                            ),
                          );
                        },
                      ),
                      // ListTile(
                      //   leading: Checkbox(
                      //     value: checkbox,
                      //     onChanged: (value) {
                      //       setState(() {
                      //         checkbox = value!;
                      //       });
                      //     },
                      //   ),
                      //   title: Text(
                      //     "Azeitonas",
                      //     style: TextFontStyle.headline5StyleInter
                      //         .copyWith(color: AppColors.appColor2C303E),
                      //   ),
                      //   subtitle: Text(
                      //     "Detalhes",
                      //     style: TextFontStyle.headline7StyleInter
                      //         .copyWith(color: AppColors.appColor9B9B9B),
                      //   ),
                      // ),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.r),
                        child: TextFormField(
                          autovalidateMode: validation
                              ? AutovalidateMode.always
                              : AutovalidateMode.disabled,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter email';
                            }
                            return null;
                          },
                          controller: noteController,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                            letterSpacing: 1.5,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w100,
                            fontStyle: FontStyle.normal,
                            color: AppColors.headLine2Color,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Introduza a sua nota',
                            hintStyle: TextFontStyle.headline5StyleInter
                                .copyWith(color: AppColors.appColor9B9B9B),
                            labelText: 'Notas',
                            labelStyle: TextFontStyle.headline7StyleInter
                                .copyWith(color: AppColors.appColor9B9B9B),
                            errorStyle: TextStyle(
                              letterSpacing: 1,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              color: AppColors.warningColor,
                            ),
                          ),
                        ),
                      ),
                      UIHelper.verticalSpaceMedium,
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.w, vertical: 3.h),
                        width: double.infinity,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                child: Icon(
                                  CupertinoIcons.minus_square_fill,
                                  size: 30.sp,
                                  color: AppColors.appColor9B9B9B,
                                ),
                                onTap: () {
                                  // if (_page >= 2) {
                                  //   setState(() {
                                  //     _page -= 1;
                                  //     int record = int.parse(
                                  //         numberController.value.text);
                                  //     getItemListRXobj.fetchItemListData(
                                  //         record: record, page: _page);
                                  //   });
                                  // }
                                },
                              ),
                              UIHelper.horizontalSpaceSmall,
                              Text(
                                '1',
                                style: TextFontStyle.headline5StyleInter
                                    .copyWith(color: AppColors.appColor000000),
                              ),
                              UIHelper.horizontalSpaceSmall,
                              InkWell(
                                child: Icon(
                                  Icons.add_box_rounded,
                                  size: 30.sp,
                                  color: AppColors.inactiveColor,
                                ),
                                onTap: () {
                                  // int record =
                                  //     int.parse(numberController.value.text);
                                  // if (items.length == record) {
                                  //   setState(() {
                                  //     _page += 1;
                                  //     getItemListRXobj.fetchItemListData(
                                  //         record: record, page: _page);
                                  //   });
                                  // } else {
                                  //   const snackBar = SnackBar(
                                  //     content: Text('No more records to show'),
                                  //   );
                                  //   ScaffoldMessenger.of(context)
                                  //       .showSnackBar(snackBar);
                                  // }
                                },
                              ),
                            ]),
                      ),
                      UIHelper.verticalSpaceMedium,
                      Container(
                        color: AppColors.primaryColor,
                        height: .10.sh,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text.rich(TextSpan(children: [
                                  TextSpan(
                                      text: 'Total Price\n',
                                      style: TextFontStyle.headline4StyleArial),
                                  TextSpan(
                                      text: '19,00€',
                                      style: TextFontStyle.headline2StyleArial),
                                ])),
                                Container(
                                  height: .05.sh,
                                  width: .3.sw,
                                  decoration: BoxDecoration(
                                    color: AppColors.inactiveColor,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Center(
                                      child: Text(
                                    "Adicionar",
                                    style: TextFontStyle.headline4StyleInter
                                        .copyWith(
                                            color: AppColors.appColor4D3E39),
                                  )),
                                )
                              ]),
                        ),
                      )
                    ]);
              } else if (snapshot.hasError) {
                return SizedBox.shrink();
              }
              return Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Lottie.asset(AssetIcons.lottie_food_loading),
                ),
              );
            }),
      ),
    );
  }
}
