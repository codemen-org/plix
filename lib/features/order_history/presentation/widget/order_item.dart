import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plix/constants/app_color.dart';
import 'package:plix/helpers/ui_helpers.dart';

import '../../../../helpers/dateuitl.dart';
import '../../model/orderdata.dart';


class OrderItem extends StatefulWidget {
  final Function() onTap;
  final Datum? item;

  OrderItem({required this.onTap, required this.item});

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        padding: EdgeInsets.only(
          top: 10,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                UIHelper.horizontalSpaceSmall,
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Image.network(
                    widget.item!.restaurant!.imageFullPath ?? "",
                    height: 60,
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                ),
              UIHelper.horizontalSpaceSmall,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormatedUtils.getFormatedDate(
                            widget.item!.deliveryDate!, "yyy-MM-dd"),
                        style: GoogleFonts.lato(
                          color: AppColors.appColor9B9B9B,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                  UIHelper.verticalSpaceSmall,
                      Container(
                        width: 200,
                        child: Text(
                          widget.item!.restaurant!.name!,
                          style: GoogleFonts.lato(
                            color: AppColors.appColor2C303E,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                 UIHelper.verticalSpaceSmall,
                      widget.item!.restaurant!.description == null
                          ? SizedBox()
                          : Text(
                              widget.item!.restaurant!.description ?? "",
                              style: GoogleFonts.lato(
                                color: AppColors.appColorF4A4A4A,
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                      widget.item!.restaurant!.description == null
                          ? SizedBox()
                          : UIHelper.verticalSpaceSmall,
                      Text(
                        widget.item!.totalPrice!,
                        style: GoogleFonts.lato(
                          color: AppColors.appColor000000,
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    UIHelper.verticalSpaceSmall,
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.appColor000000,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Text(
                          widget.item!.statusText!,
                          style: GoogleFonts.lato(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.appColor67605F,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Text(
                    "VEJA DETALHES".tr,
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              UIHelper.horizontalSpaceSmall,
              ],
            ),
            UIHelper.verticalSpaceSmall,
            Divider(
              height: 1,
            ),
          ],
        ),
      ),
    );
  }
}
