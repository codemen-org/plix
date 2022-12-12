// import 'package:auto_animated/auto_animated.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:plix/constants/app_color.dart';
// import 'package:plix/helpers/ui_helpers.dart';
// import 'package:plix/networks/api_acess.dart';
// import 'package:plix/widgets/loading_indicators.dart';

// import 'package:get/get.dart';

// import '../model/order_details_response.dart' as det;
// import 'widget/order_item.dart';
// import 'widget/tracking.dart';

// class OrderDetailsScreen extends StatefulWidget {
//   @override
//   _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
// }

// class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
//   String orderStatusInfo = '';

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           elevation: 0,
//           leading: BackButton(
//             color: AppColors.appColor000000,
//           ),
//           title: Text(
//             "Back".tr,
//             style: TextStyle(
//               color: AppColors.appColor000000,
//             ),
//           ),
//         ),
//         body: StreamBuilder(
//             stream: getOrderDetailRXObj.getGetOrderDetailDataRes,
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 final orderres = snapshot.data["data"]["order"];
//                 final order = orderres.order;
//                 // List<det.OrderStatus>? orderHistory =
//                 //     order!.order_status_history;
//                 return SingleChildScrollView(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Row(
//                           children: [
//                             Text(
//                               "VEJA DETALHES".tr,
//                               style: GoogleFonts.lato(
//                                 color: Colors.black,
//                                 fontSize: 12,
//                               ),
//                             ),
//                             Spacer(),
//                             Text(
//                               "Order No : " + orderres["order_code"].toString(),
//                               style: GoogleFonts.lato(
//                                 color: AppColors.appColor000000,
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                               maxLines: 2,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ],
//                         ),
//                       ),
//                       orderres["delivery_man"] == null
//                           ? Container()
//                           : Container(
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                               ),
//                               padding: EdgeInsets.only(left: 12, top: 12),
//                               width: Get.width,
//                               child: Row(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   ClipRRect(
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(10)),
//                                     child: Image.network(
//                                       order.deliveryMan!.profilePhotoFullPath ??
//                                           "",
//                                       height: 60,
//                                       width: 60,
//                                       fit: BoxFit.cover,
//                                     ),
//                                   ),
//                                   UIHelper.horizontalSpaceSmall,
//                                   Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Container(
//                                         child: Text(
//                                           order.deliveryMan!.firstName! +
//                                               " " +
//                                               order.deliveryMan!.lastName!,
//                                           style: GoogleFonts.lato(
//                                             color: AppColors.appColor4D3E39,
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                           maxLines: 2,
//                                           overflow: TextOverflow.ellipsis,
//                                         ),
//                                       ),
//                                       UIHelper.horizontalSpaceSmall,
//                                       Container(
//                                         child: Text(
//                                           order.deliveryAddress.toString(),
//                                           style: GoogleFonts.lato(
//                                             color: AppColors.appColor000000,
//                                             fontSize: 12,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                           maxLines: 2,
//                                           overflow: TextOverflow.ellipsis,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                       Container(
//                         padding: const EdgeInsets.symmetric(vertical: 16),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                         ),
//                         child: LiveList(
//                           showItemInterval: Duration(milliseconds: 150),
//                           showItemDuration: Duration(milliseconds: 350),
//                           reAnimateOnVisibility: true,
//                           shrinkWrap: true,
//                           scrollDirection: Axis.vertical,
//                           itemCount: order!.orderItems!.length,
//                           itemBuilder: animationItemBuilder(
//                             (index) {
//                               return itemWallet(order.orderItems![index]);
//                             },
//                           ),
//                         ),
//                       ),
//                       UIHelper.verticalSpaceSmall,
//                       Container(
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                         ),
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 16.0, vertical: 16),
//                         child: Column(
//                           children: [
//                             Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   "Item Total Price".tr,
//                                   style: GoogleFonts.poppins(
//                                       color: AppColors.appColor000000,
//                                       fontSize: 12.0,
//                                       fontWeight: FontWeight.w300),
//                                 ),
//                                 Text(
//                                   order.itemTotalPriceInEuro!,
//                                   style: GoogleFonts.poppins(
//                                       color: AppColors.appColor4D3E39,
//                                       fontSize: 12.0,
//                                       fontWeight: FontWeight.w400),
//                                 ),
//                               ],
//                             ),
//                             UIHelper.verticalSpaceSmall,
//                             Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   "Delivery Charge".tr,
//                                   style: GoogleFonts.poppins(
//                                       color: AppColors.appColor000000,
//                                       fontSize: 12.0,
//                                       fontWeight: FontWeight.w300),
//                                 ),
//                                 Text(
//                                   order.deliveryChargeInEuro!,
//                                   style: GoogleFonts.poppins(
//                                       color: AppColors.appColor000000,
//                                       fontSize: 12.0,
//                                       fontWeight: FontWeight.w400),
//                                 ),
//                               ],
//                             ),
//                             UIHelper.verticalSpaceSmall,
//                             Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   "Total".tr,
//                                   style: GoogleFonts.poppins(
//                                       color: AppColors.appColor000000,
//                                       fontSize: 12.0,
//                                       fontWeight: FontWeight.w300),
//                                 ),
//                                 Text(
//                                   order.totalPriceInEuro!,
//                                   style: GoogleFonts.poppins(
//                                       color: AppColors.appColor4D3E39,
//                                       fontSize: 12.0,
//                                       fontWeight: FontWeight.w400),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                       UIHelper.verticalSpaceSmall,
//                       Container(
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                         ),
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 16.0, vertical: 16),
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             // if (order.deliveredat == null)
//                             //   Text(
//                             //     "Predicted Delivery Time".tr,
//                             //     style: GoogleFonts.poppins(
//                             //         color: black,
//                             //         fontSize: 12.0,
//                             //         fontWeight: FontWeight.w300),
//                             //   ),
//                             // if (order.deliveredat != null)
//                             Text(
//                               "Delivery Time".tr,
//                               style: GoogleFonts.poppins(
//                                   color: AppColors.appColor000000,
//                                   fontSize: 12.0,
//                                   fontWeight: FontWeight.w300),
//                             ),
//                             Text(
//                               order.deliveredat ??
//                                   order.calculatedPredictedTime ??
//                                   order.expectedDeliveryTime ??
//                                   order.statusText!,
//                               style: GoogleFonts.poppins(
//                                   color: AppColors.appColor9B9B9B,
//                                   fontSize: 12.0,
//                                   fontWeight: FontWeight.w400),
//                             ),
//                           ],
//                         ),
//                       ),
//                       UIHelper.verticalSpaceSmall,
//                       Container(
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                         ),
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 16.0, vertical: 16),
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               "Delivery Status".tr,
//                               style: GoogleFonts.poppins(
//                                   color: AppColors.appColor000000,
//                                   fontSize: 12.0,
//                                   fontWeight: FontWeight.w300),
//                             ),
//                             Text(
//                               order.deliveryStatusText!,
//                               style: GoogleFonts.poppins(
//                                   color: AppColors.appColor9B9B9B,
//                                   fontSize: 12.0,
//                                   fontWeight: FontWeight.w400),
//                             ),
//                           ],
//                         ),
//                       ),
//                       UIHelper.verticalSpaceSmall,
//                       Container(
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                         ),
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 16.0, vertical: 16),
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               "Track Order".tr,
//                               style: GoogleFonts.lato(
//                                 color: AppColors.appColor000000,
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             UIHelper.verticalSpaceLarge,
//                           ],
//                         ),
//                       ),
//                       Container(
//                         color: Colors.white,
//                         padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                         child: TrackingWidget(
//                             title: 'Order Placed'.tr,
//                             time: order.order_placed.toString(),
//                             lastVal: false),
//                       ),
//                       // ListView.builder(
//                       //     itemCount: orderHistory!.length,
//                       //     physics: const NeverScrollableScrollPhysics(),
//                       //     shrinkWrap: true,
//                       //     itemBuilder: (context, index) {
//                       //       bool lastVal = false;
//                       //       if (orderHistory[index].orderStatus != null) {
//                       //         switch (
//                       //             orderHistory[index].orderStatus.toString()) {
//                       //           case '0':
//                       //             orderStatusInfo = 'Order Placed'.tr;

//                       //             break;
//                       //           case '10':
//                       //             orderStatusInfo = 'Accepted'.tr;
//                       //             break;
//                       //           case '20':
//                       //             orderStatusInfo = 'Processing'.tr;

//                       //             break;
//                       //           case '21':
//                       //             orderStatusInfo = 'Product Ready'.tr;
//                       //             break;
//                       //           case '30':
//                       //             orderStatusInfo = 'Picked'.tr;

//                       //             break;
//                       //           case '40':
//                       //             orderStatusInfo = 'Delivered'.tr;

//                       //             break;
//                       //           case '80':
//                       //             orderStatusInfo = 'Cancle'.tr;

//                       //             break;
//                       //           case '90':
//                       //             orderStatusInfo = 'Rejected by Shop';

//                       //             break;
//                       //           case '100':
//                       //             orderStatusInfo = 'Failed'.tr;
//                       //             break;
//                       //         }

//                       //         if (orderHistory!.length - 1 == index) {
//                       //           lastVal = true;
//                       //         }

//                       //         return Container(
//                       //           color: Colors.white,
//                       //           padding: const EdgeInsets.symmetric(
//                       //               horizontal: 16.0),
//                       //           child: TrackingWidget(
//                       //               title: orderStatusInfo,
//                       //               time: (orderHistory[index].orderStatus !=
//                       //                       null)
//                       //                   ? orderHistory[index]
//                       //                       .createdAt
//                       //                       .toString()
//                       //                   : '00:00',
//                       //               lastVal: lastVal),
//                       //         );
//                       //       }
//                       //       return Container();
//                       //     }),
//                       // UIHelper.verticalSpaceMedium,
//                     ],
//                   ),
//                 );
//               } else if (snapshot.hasError) {
//                 return SizedBox.shrink();
//               }
//               return loadingIndicatorCircle(context: context);
//             }));
//   }

//   Widget itemWallet(det.OrderItem order) {
//     return Container(
//       width: Get.width,
//       child: Column(
//         children: [
//           UIHelper.verticalSpaceSmall,
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   order.food!.name!,
//                   style: GoogleFonts.poppins(
//                       color: AppColors.appColor000000,
//                       fontSize: 12.0,
//                       fontWeight: FontWeight.w500),
//                 ),
//                 Text(
//                   order.quantity.toString() + " Unidade",
//                   style: GoogleFonts.poppins(
//                       color: AppColors.appColor000000,
//                       fontSize: 12.0,
//                       fontWeight: FontWeight.w400),
//                 ),
//                 Text(
//                   order.unitPriceInEuro!,
//                   style: GoogleFonts.poppins(
//                       color: AppColors.activeColor,
//                       fontSize: 12.0,
//                       fontWeight: FontWeight.w400),
//                 ),
//               ],
//             ),
//           ),
//           UIHelper.verticalSpaceSmall,
//           Divider(
//             height: 1,
//             color: AppColors.debitHigheColor,
//           ),
//         ],
//       ),
//     );
//   }
// }
