import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:plix/constants/app_color.dart';
import 'package:plix/constants/text_font_style.dart';
import 'package:plix/helpers/all_routes.dart';
import 'package:plix/helpers/navigation_service.dart';
import 'package:plix/helpers/toast.dart';
import 'package:plix/networks/api_acess.dart';

import '../../../helpers/ui_helpers.dart';
import '../model/orderdata.dart';
import 'order_details_screen.dart';
import 'widget/order_item.dart';

class OrderHistoryScreen extends StatefulWidget {
  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
} 

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(

          leading: BackButton(
            color: Colors.white,
          ),
          centerTitle: true,
          backgroundColor: Get.theme.primaryColorDark,
          title: Text(
            "Order Historys".tr,
            style: TextFontStyle.headline2StyleArial,
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
          
            UIHelper.verticalSpaceSmall,
            Expanded(
                child: StreamBuilder(
                    stream: getOrderListRXObj.getOrderListDataRes,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List ordersList =
                            snapshot.data["data"]["orders"]["data"];
                        return LiveList(
                          showItemInterval: Duration(milliseconds: 150),
                          showItemDuration: Duration(milliseconds: 350),
                          reAnimateOnVisibility: true,
                          scrollDirection: Axis.vertical,
                          itemCount: ordersList.length,
                          itemBuilder: animationItemBuilder(
                            (index) {
                              return OrderItem(
                                onTap: () async {
                                  await getOrderDetailRXObj
                                      .getGetOrderDetailData(
                                          ordersList[index]["order_code"]);
                                  NavigationService.navigateTo(
                                      Routes.orderDetailsScreen);
                                  ToastUtil.showShortToast(
                                      "working not done yet".tr);
                                  // Get.to(OrderDetailsScreen(
                                  //   orderCode: ordersList[index].orderCode,
                                  // ));
                                },
                                item: Datum.fromJson(ordersList[index]),
                              );
                            },
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Container(
                          height: Get.height,
                          child: Center(
                            child: Text(
                              "No items found".tr,
                              style: TextStyle(
                                  color: AppColors.appColorB7242A,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                        );
                      }
                      return SizedBox.shrink();
                    })),
          ],
        ));
  }
}
