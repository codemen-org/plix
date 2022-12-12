import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:lottie/lottie.dart';
import 'package:plix/constants/text_font_style.dart';
import 'package:plix/helpers/ui_helpers.dart';
import 'package:plix/helpers/all_routes.dart';
import 'package:plix/helpers/navigation_service.dart';
import 'package:plix/networks/api_acess.dart';
import 'package:plix/widgets/loading_indicators.dart';
import 'package:provider/provider.dart';

import '../../constants/app_color.dart';
import '../../constants/app_constants.dart';
import '../../provider/order_date_time.dart';
import '../../widgets/custom_button.dart';
import '../cart/model/dateslot.dart';
import '../cart/presentation/time_slot.dart';

class OrderScreen extends StatefulWidget {
  OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  String? selectdDate;
  DateSlot? dateSlot;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getCartRXObj.getCartData();
      getTimeSlotRXObj.getTimeSlotData();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: getCartRXObj.getCartDataRes,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Map data = snapshot.data["data"];
            List carts = data["carts"];
            if (carts.length == 0) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Lottie.asset(
                      AssetIcons.itemnotfound,
                    ),
                  ),
                  UIHelper.horizontalSpaceSmall,
                  Text(
                    'No item in Cart'.tr,
                    style: TextFontStyle.headline7StyleInter
                        .copyWith(color: AppColors.appColor9B9B9B),
                  )
                ],
              );
            }
            return SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UIHelper.verticalSpaceMedium,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 13.w),
                      child: Text(
                        'Morada'.tr,
                        style: TextFontStyle.headline7StyleInter
                            .copyWith(color: AppColors.appColor9B9B9B),
                      ),
                    ),
                    UIHelper.verticalSpaceMedium,
                    StreamBuilder(
                        stream: getDefaultAddressRXObj.getDefaultAddressRes,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List address = snapshot.data["data"]["addresses"];
                            return ListTile(
                              title: Text(
                                address[0]['address_name'],
                                style: TextFontStyle.headline5StyleInter
                                    .copyWith(color: AppColors.appColor2C303E),
                              ),
                              tileColor: Colors.white,
                              subtitle: Text(
                                address[0]['address'],
                                style: TextFontStyle.headline7StyleInter
                                    .copyWith(color: AppColors.appColor67605F),
                              ),
                              trailing: Icon(
                                Icons.arrow_forward_rounded,
                                color: Colors.amberAccent[400],
                              ),
                              onTap: () {
                                NavigationService.navigateTo(
                                  Routes.profileScreen,
                                );
                              },
                            );
                          } else if (snapshot.hasError) {
                            return loadingIndicatorCircle(context: context);
                          }
                          return SizedBox.shrink();
                        }),
                    UIHelper.verticalSpaceMedium,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 13.w),
                      child: Text('Hora de Entrega'.tr,
                          style: TextFontStyle.headline7StyleInter
                              .copyWith(color: AppColors.appColor9B9B9B)),
                    ),
                    UIHelper.verticalSpaceMedium,
                    InkWell(
                      child: ListTile(
                        title: Text(
                          'Agora'.tr,
                          style: TextFontStyle.headline5StyleInter
                              .copyWith(color: AppColors.appColor2C303E),
                        ),
                        tileColor: Colors.white,
                        subtitle: Text(
                          context.watch<DateTimeProvider>().selectedSlot != null
                              ? context
                                      .watch<DateTimeProvider>()
                                      .selectedSlot!
                                      .slotDisplay +
                                  ' H / ' +
                                  context.watch<DateTimeProvider>().selectedDate
                              : "Select Delivery Time".tr,
                          style: TextFontStyle.headline7StyleInter
                              .copyWith(color: AppColors.appColor67605F),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.amberAccent[400],
                        ),
                      ),
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return CartBottomSheet();
                            });
                      },
                    ),
                    UIHelper.verticalSpaceMedium,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 13.w),
                      child: Text('Detalhes do Pedido'.tr,
                          style: TextFontStyle.headline7StyleInter
                              .copyWith(color: AppColors.appColor9B9B9B)),
                    ),
                    UIHelper.verticalSpaceMedium,
                    StreamBuilder(
                        stream: getCartRXObj.getCartDataRes,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            Map data = snapshot.data["data"];
                            List carts = data["carts"];
                            return Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(horizontal: 13),
                              decoration: BoxDecoration(color: Colors.white),
                              child: ListView.builder(
                                padding: EdgeInsets.all(0),
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: carts.length,
                                itemBuilder: (context, index) {
                                  List addOns = carts[index]["cart_addons"];
                                  return Slidable(
                                    key: const ValueKey(0),

                                    // The start action pane is the one at the left or the top side.
                                    startActionPane: ActionPane(
                                      // A motion is a widget used to control how the pane animates.
                                      motion: const ScrollMotion(),

                                      // A pane can dismiss the Slidable.
                                      dismissible:
                                          DismissiblePane(onDismissed: () {
                                        postDeleteCartRXObj.postCartData(
                                            carts[index]["code"].toString());
                                      }),

                                      // All actions are defined in the children parameter.
                                      children: [
                                        // A SlidableAction can have an icon and/or a label.
                                        SlidableAction(
                                          onPressed: (context) {
                                            postDeleteCartRXObj.postCartData(
                                                carts[index]["code"]
                                                    .toString());
                                          },
                                          backgroundColor: Color(0xFFFE4A49),
                                          foregroundColor: Colors.white,
                                          icon: Icons.delete,
                                          label: 'Delete'.tr,
                                        ),
                                      ],
                                    ),

                                    child: Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: .5.sw,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        carts[index]
                                                                ["food_option"]
                                                            ["name"],
                                                        style: TextFontStyle
                                                            .headline5StyleInter
                                                            .copyWith(
                                                                color: AppColors
                                                                    .appColor2C303E,
                                                                overflow:
                                                                    TextOverflow
                                                                        .clip),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 8),
                                                        child: Text(
                                                          carts[index][
                                                                      "quantity"]
                                                                  .toString() +
                                                              ' Unidade',
                                                          style: TextFontStyle
                                                              .headline3StyleArial
                                                              .copyWith(
                                                                  color: AppColors
                                                                      .appColor2C303E),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Text(
                                                  carts[index]["food_option"]
                                                      ["description"],
                                                  style: TextFontStyle
                                                      .headline7StyleInter
                                                      .copyWith(
                                                          color: AppColors
                                                              .appColor67605F),
                                                ),
                                                if (addOns.isNotEmpty)
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Add One : ".tr,
                                                        style: TextFontStyle
                                                            .headline7StyleInter
                                                            .copyWith(
                                                                color: AppColors
                                                                    .appColor67605F),
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                        width: .5.sw,
                                                        child: ListView.builder(
                                                          shrinkWrap: true,
                                                          itemCount:
                                                              addOns.length,
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          itemBuilder:
                                                              (context, i) {
                                                            if (addOns.length -
                                                                    1 ==
                                                                i) {
                                                              return Text(
                                                                addOns[i][
                                                                        "addon"]
                                                                    ["name"],
                                                                style: TextFontStyle
                                                                    .headline7StyleInter
                                                                    .copyWith(
                                                                        color: AppColors
                                                                            .appColor67605F),
                                                              );
                                                            } else {
                                                              return Text(
                                                                addOns[i]["addon"]
                                                                        [
                                                                        "name"] +
                                                                    ", ",
                                                                style: TextFontStyle
                                                                    .headline7StyleInter
                                                                    .copyWith(
                                                                        color: AppColors
                                                                            .appColor67605F),
                                                              );
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                              ],
                                            ),
                                            Spacer(),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8),
                                              child: Text(
                                                carts[index]["total"],
                                                style: TextFontStyle
                                                    .headline7StyleInter
                                                    .copyWith(
                                                        color: AppColors
                                                            .appColor2C303E),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Divider(
                                          thickness: .5,
                                          color: AppColors.appColor67605F,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return Align(
                              alignment: Alignment.bottomCenter,
                              child:
                                  Lottie.asset(AssetIcons.lottie_food_loading),
                            );
                          }
                          return SizedBox.shrink();
                        }),
                    UIHelper.verticalSpaceSmall,
                    ListTile(
                        tileColor: Colors.white,
                        leading: Text("Total".tr,
                            style: TextFontStyle.headline7StyleInter
                                .copyWith(color: AppColors.appColor2C303E)),
                        trailing: StreamBuilder(
                            stream: getCartRXObj.getCartDataRes,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                Map data = snapshot.data["data"];
                                return Text(data["cart_totals"]["total_price"],
                                    style: TextFontStyle.headline5StyleInter
                                        .copyWith(
                                            color: AppColors.appColor2C303E));
                              } else if (snapshot.hasError) {
                                SizedBox.shrink();
                              }
                              return Text("Loading".tr,
                                  style: TextFontStyle.headline5StyleInter
                                      .copyWith(
                                          color: AppColors.appColor2C303E));
                            })),
                    UIHelper.verticalSpaceSmall,
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 13.w),
                        child: customeButton(
                          name: 'Fazer pedido'.tr,
                          height: .075.sh,
                          minWidth: double.infinity,
                          borderRadius: 5.r,
                          color: AppColors.inactiveColor,
                          textStyle: TextFontStyle.headline4StyleInter
                              .copyWith(color: AppColors.appColor4D3E39),
                          context: context,
                          onCallBack: () async {
                            String date =
                                context.read<DateTimeProvider>().selectedDate;
                            DateSlot? slot =
                                context.read<DateTimeProvider>().selectedSlot;
                            if (date != "" && slot != null) {
                              postCreateOrderRXObj.postCreateOrder(
                                  deliveryDate: date,
                                  timeSllot: slot.slotValue);
                            } else {
                              ScaffoldMessenger.of(NavigationService.context)
                                  .showSnackBar(SnackBar(
                                content: Text("Select Time Slot To Deliver".tr),
                              ));
                            }
                          },
                        ),
                      ),
                    ),
                    UIHelper.verticalSpaceLarge,
                  ]),
            );
          } else if (snapshot.hasError) {
            return Text(
              "0",
              style: TextStyle(
                color: Colors.white,
              ),
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
