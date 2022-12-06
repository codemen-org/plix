import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plix/constants/app_color.dart';
import 'package:plix/constants/text_font_style.dart';
import 'package:plix/helpers/ui_helpers.dart';
import 'package:plix/helpers/all_routes.dart';
import 'package:plix/helpers/navigation_service.dart';

import '../networks/api_acess.dart';

class CategoryWidget extends StatelessWidget {
  final Map item;

  const CategoryWidget({required this.item});

  @override
  Widget build(BuildContext context) {
    //final body = json.decode(category?.name.toString());
    return GestureDetector(
      onTap: () {
        getProductsByCategoriesRXObj.fetchItemByShopCategoryData(item["slug"]);
        NavigationService.navigateToWithArgs(
          Routes.categorySearch,
          {"allCategories": false, "name": item["name"]},
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4),
        height: 100,
        width: 80,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              child: Image.network(
                item["image_full_path"] ?? "",
                height: 90,
                width: 80,
                fit: BoxFit.fitHeight,
              ),
            ),
            UIHelper.verticalSpaceSmall,
            Text(
              item['name'],
              style: TextFontStyle.headline6StyleInter
                  .copyWith(color: AppColors.appColor000000),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
