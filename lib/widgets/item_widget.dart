import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plix/constants/app_color.dart';
import 'package:plix/helpers/ui_helpers.dart';
import 'package:plix/helpers/all_routes.dart';
import 'package:plix/navigation_screen.dart';
import 'package:plix/networks/api_acess.dart';

import '../constants/text_font_style.dart';
import '../helpers/navigation_service.dart';

class ItemWidget extends StatelessWidget {
  final Map item;

  const ItemWidget({required this.item});

  @override
  Widget build(BuildContext context) {
    //final body = json.decode(Item?.name.toString());
    return GestureDetector(
      onTap: () async {
        await getProductDetailRXObj.fetchProductDetail(item["slug"]);
        NavigationService.navigateTo(Routes.productDetailScreen);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        height: .3.sh,
        width: .4.sw,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              child: Image.network(
                item['image_full_path'] ?? "",
                height: .3.sh,
                width: .4.sw,
                fit: BoxFit.fitHeight,
              ),
            ),
            Positioned(
              top: 8,
              left: 10,
              child: Container(
                width: .12.sw,
                height: .03.sh,
                decoration: BoxDecoration(
                  color: AppColors.appColorEDBB43,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                    child: Text(
                  '3.5',
                  style: TextFontStyle.headline9StyleInter,
                )),
              ),
            ),
            Positioned(
                bottom: 0,
                left: .025.sw,
                child: Container(
                  height: .10.sh,
                  width: .35.sw,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withAlpha(100),
                          blurRadius: 10.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                      border: Border.all(color: Colors.white10.withAlpha(80)),
                      color: Colors.black.withOpacity(0.25),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15))),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(.12.sw, .03.sh, 0, 0),
                    child: Text(
                      item['name'],
                      style: TextFontStyle.headline6StyleInter
                          .copyWith(color: AppColors.appColor2C303E),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
