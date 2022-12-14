import 'dart:convert';
import 'dart:developer';

import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:plix/features/product/model/add_one_list.dart';
import 'package:plix/helpers/toast.dart';
import 'package:plix/helpers/ui_helpers.dart';
import 'package:plix/networks/api_acess.dart';
import 'package:plix/provider/product_id_provider.dart';
import 'package:provider/provider.dart';

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
  final appData = GetStorage();
  bool checkbox = false;
  String radioValue = "";
  bool validation = false;
  double itemPrice = 0.0;
  double totalPrice = 0.0;
  AddOneList selectedAddOns = AddOneList(addons: []);
  //cart variable
  int foodId = 0;
  int food_option_id = 0;
  int itemQty = 1;
  TextEditingController noteController = TextEditingController();
  List<int> addOneList = [];

  void calculateTotal() {
    totalPrice = itemPrice;
    selectedAddOns.addons.forEach(
      (element) {
        totalPrice += double.parse(element.price!);
      },
    );
    context.read<ProductPriceProvider>().changePrice(totalPrice);
  }

  bool alreadySelected(int id) {
    bool exist = false;
    final addOne = selectedAddOns.addons
        .singleWhere((element) => element.id == id, orElse: () {
      return Addon();
    });
    if (addOne.id != null) {
      exist = true;
    }
    return exist;
  }

  addRemovecart(Addon addon) {
    final ind =
        selectedAddOns.addons.indexWhere((element) => element.id == addon.id);
    if (ind >= 0) {
      selectedAddOns.addons.removeAt(ind);
    } else {
      selectedAddOns.addons.add(addon);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Container(
        child: StreamBuilder(
            stream: getProductDetailRXObj.getProductDetailData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Map foodData = snapshot.data['data']["food"];
                List options = snapshot.data['data']["food"]["options"];
                AddOneList addOns = AddOneList(addons: []);
                List<dynamic> addone = snapshot.data['data']["food"]["addons"];
                addone.forEach(
                  (element) {
                    addOns.addons.add(Addon.fromJson(element));
                  },
                );
                foodId = foodData["id"];
                if (itemPrice == 0.0) {
                  itemPrice = double.parse(foodData["price"]);
                  Future.delayed(Duration.zero).then(
                    (value) => calculateTotal(),
                  );
                }

                return SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: .38.sh,
                          width: 1.sw,
                          child: Stack(children: [
                            Positioned(
                              child: Image.network(
                                foodData["image_full_path"] ?? "",
                                height: .38.sh,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                                top: 10,
                                left: 10,
                                child: InkWell(
                                  child: Icon(Icons.arrow_back,
                                      color: Colors.white),
                                  onTap: () {
                                    NavigationService.goBack;
                                  },
                                )),
                            Positioned(
                              right: 10,
                              top: 10,
                              child: Badge(
                                position: BadgePosition(
                                  start: -5,
                                  bottom: -5,
                                ),
                                badgeContent: StreamBuilder(
                                  stream: getCartRXObj.getCartDataRes,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      Map data = snapshot.data["data"];
                                      List carts = data["carts"];
                                      return Text(
                                        carts.length.toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text(
                                        "",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      );
                                    }
                                    return SizedBox.shrink();
                                  },
                                ),
                                child: CircleAvatar(
                                  backgroundColor: AppColors.appColor4D3E39,
                                  radius: 20,
                                  child: IconButton(
                                    icon: SvgPicture.asset(
                                      AssetIcons.shop,
                                      color: AppColors.appColorB7242A,
                                      height: 25,
                                      width: 25,
                                    ),
                                    onPressed: () {
                                      //   final storarge = GetStorage();
                                      //   if (storarge.read(kKeyIsLoggedIn) ?? false) {
                                      //   Get.to(CartScreen());
                                      //    } else {
                                      // Get.to(LoginScreen(
                                      //   callFrom: 2,
                                      // ));
                                      //      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ]),
                        ),
                        UIHelper.verticalSpaceSmall,
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.r),
                          child: Text(
                            "Descrição Produto".tr,
                            style: TextFontStyle.headline2StyleInter
                                .copyWith(color: AppColors.appColor000000),
                          ),
                        ),
                        UIHelper.verticalSpaceMedium,
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.r),
                          child: Text(
                            "Selecione uma opção".tr,
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
                              food_option_id = options[index]["id"];
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
                                itemPrice =
                                    double.parse(options[index]["price"]);
                                food_option_id = options[index]["id"];
                                calculateTotal();
                                setState(() {
                                  radioValue = value as String;
                                  radioValue = options[index]["name"];

                                  log(radioValue);
                                });
                              },
                            );
                          },
                        ),
                        UIHelper.verticalSpaceMedium,
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.r),
                          child: Text(
                            "Selecione uma opção ingrediente extra".tr,
                            style: TextFontStyle.headline7StyleInter
                                .copyWith(color: AppColors.appColor9B9B9B),
                          ),
                        ),
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: addOns.addons.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              trailing: Text(addOns.addons[index].priceInEuro!),
                              leading: Checkbox(
                                value:
                                    alreadySelected(addOns.addons[index].id!),
                                onChanged: (value) {
                                  setState(() {
                                    addRemovecart(addOns.addons[index]);
                                    calculateTotal();
                                  });
                                },
                              ),
                              title: Text(
                                addOns.addons[index].name!,
                                style: TextFontStyle.headline5StyleInter
                                    .copyWith(color: AppColors.appColor2C303E),
                              ),
                              subtitle: Text(
                                addOns.addons[index].description ?? "",
                                style: TextFontStyle.headline7StyleInter
                                    .copyWith(color: AppColors.appColor9B9B9B),
                              ),
                            );
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.r),
                          child: TextFormField(
                            autovalidateMode: validation
                                ? AutovalidateMode.always
                                : AutovalidateMode.disabled,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter notes'.tr;
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
                              hintText: 'Introduza a sua nota'.tr,
                              hintStyle: TextFontStyle.headline5StyleInter
                                  .copyWith(color: AppColors.appColor9B9B9B),
                              labelText: 'Notas'.tr,
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
                                    if (itemQty >= 2) {
                                      setState(() {
                                        itemQty -= 1;
                                      });
                                    }
                                  },
                                ),
                                UIHelper.horizontalSpaceSmall,
                                Text(
                                  (itemQty).toString(),
                                  style: TextFontStyle.headline5StyleInter
                                      .copyWith(
                                          color: AppColors.appColor000000),
                                ),
                                UIHelper.horizontalSpaceSmall,
                                InkWell(
                                  child: Icon(
                                    Icons.add_box_rounded,
                                    size: 30.sp,
                                    color: AppColors.inactiveColor,
                                  ),
                                  onTap: () {
                                    setState(() {
                                      itemQty += 1;
                                    });
                                  },
                                ),
                              ]),
                        ),
                        UIHelper.verticalSpaceExtraLarge,
                      ]),
                );
              } else if (snapshot.hasError) {
                return SizedBox.shrink();
              }
              return Align(
                alignment: Alignment.bottomCenter,
                child: Lottie.asset(AssetIcons.lottie_food_loading),
              );
            }),
      ),
      bottomSheet: Container(
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
                      text: 'Total Price\n'.tr,
                      style: TextFontStyle.headline4StyleArial),
                  TextSpan(
                      text: (context.watch<ProductPriceProvider>().price *
                                  itemQty)
                              .toString() +
                          ' €',
                      style: TextFontStyle.headline2StyleArial),
                ])),
                InkWell(
                  onTap: () async {
                    if (appData.read(kKeyIsLoggedIn)) {
                      addOneList = [];
                      selectedAddOns.addons.forEach(
                        (element) {
                          addOneList.add(element.id!);
                        },
                      );
                      await postCartRXObj.postCartData(
                          foodId.toString(),
                          food_option_id.toString(),
                          itemQty.toString(),
                          noteController.text,
                          addOneList);
                      NavigationService.goBack;
                    } else {
                      ToastUtil.showLongToast("You need to log in first");
                    }
                  },
                  child: Container(
                    height: .05.sh,
                    width: .3.sw,
                    decoration: BoxDecoration(
                      color: AppColors.inactiveColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                        child: Text(
                      "Adicionar".tr,
                      style: TextFontStyle.headline4StyleInter
                          .copyWith(color: AppColors.appColor4D3E39),
                    )),
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
