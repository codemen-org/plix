import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:plix/features/categories/presentation/shimmer.dart';
import 'package:plix/helpers/all_routes.dart';
import 'package:plix/helpers/navigation_service.dart';
import 'package:plix/navigation_screen.dart';
import 'package:plix/widgets/loading_indicators.dart';
import 'package:shimmer/shimmer.dart';

import '/constants/app_color.dart';
import '/constants/text_font_style.dart';
import '/helpers/ui_helpers.dart';

import '../../../networks/api_acess.dart';

class CategorySearch extends StatefulWidget {
  final bool allCategories;
  final String catname;
  CategorySearch({required this.allCategories, required this.catname});

  @override
  State<CategorySearch> createState() => _CategorySearchState();
}

class _CategorySearchState extends State<CategorySearch> {
  bool isLoading = true;
  List<dynamic> catList = [];
  List<dynamic> serachList = [];
  TextEditingController searchEditingController = TextEditingController();
  @override
  void initState() {
    super.initState();
    searchEditingController.addListener(onSearchTextChanged);
    if (widget.allCategories == false && widget.catname == "All Item") {
      getShopItemRXObj.getItemData.listen(
        (data) {
          if (mounted) {
            setState(() {
              catList = data['data']['foods']['data'];
              serachList = data['data']['foods']['data'];
              isLoading = false;
            });
          }
        },
      );
    } else if (widget.allCategories) {
      getShopCategoriRXObj.getCategoryData.listen(
        (data) {
          if (mounted) {
            setState(() {
              catList = data['data']['categories']['data'];
              serachList = data['data']['categories']['data'];
              isLoading = false;
            });
          }
        },
      );
    } else if (!widget.allCategories) {
      getProductsByCategoriesRXObj.getItemByCategoryData.listen(
        (data) {
          if (mounted) {
            setState(() {
              catList = data['data']['foods'];
              serachList = data['data']['foods'];
              isLoading = false;
            });
          }
        },
      );
    }
    ;
  }

  onSearchTextChanged() async {
    String text = searchEditingController.value.text;

    List<dynamic> newItems = [];

    if (text.isNotEmpty) {
      for (var detail in serachList) {
        if (detail['name']
            .toString()
            .toLowerCase()
            .contains(text.toLowerCase())) {
          newItems.add(detail);
        }
      }
    }
    if (newItems.isNotEmpty) {
      setState(() {
        catList = newItems;
      });
    }

    if (text.isEmpty) {
      setState(() {
        catList = serachList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: .05.sh,
        centerTitle: true,
        title:
            widget.allCategories ? Text("Categories".tr) : Text(widget.catname),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: .07.sh,
              child: TextFormField(
                controller: searchEditingController,
                decoration: InputDecoration(
                  hintStyle: TextFontStyle.headline7StyleInter
                      .copyWith(color: AppColors.appColor9B9B9B),
                  hintText: "Search Product".tr,
                  prefixIcon:
                      Icon(Icons.search, color: AppColors.appColor9B9B9B),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0.r),
                    borderSide: const BorderSide(
                      color: AppColors.disabledColor,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0.r),
                    borderSide: const BorderSide(
                      color: AppColors.disabledColor,
                      width: 1,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0.r),
                    borderSide: const BorderSide(
                      color: AppColors.borderColor,
                      width: 1,
                    ),
                  ),
                ),
              ),
            ),
          ),
          UIHelper.verticalSpaceSmall,
          isLoading
              ? loadingIndicatorCircle(context: context)
              : Container(
                  height: .7.sh,
                  child: LiveList(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(bottom: 100),
                    itemCount: catList.length,
                    separatorBuilder: (context, index) {
                      return Column(
                        children: [
                          UIHelper.verticalSpaceSmall,
                          UIHelper.customDivider(),
                          UIHelper.verticalSpaceSmall,
                        ],
                      );
                    },
                    itemBuilder: animationItemBuilder(
                      (index) {
                        return InkWell(
                          onTap: () async {
                            if (widget.allCategories) {
                              getProductsByCategoriesRXObj
                                  .fetchItemByShopCategoryData(
                                      catList[index]["slug"]);
                              NavigationService.navigateToWithArgs(
                                Routes.categorySearch,
                                {
                                  "allCategories": false,
                                  "name": catList[index]["name"]
                                },
                              );
                            } else {
                              await getProductDetailRXObj
                                  .fetchProductDetail(catList[index]["slug"]);
                              NavigationService.navigateTo(
                                  Routes.productDetailScreen);
                            }
                          },
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              child: Image.network(
                                catList[index]['image_full_path'],
                                height: 50,
                                width: 50,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                            title: Text(
                              catList[index]['name'],
                              style: TextFontStyle.headline4StyleInter
                                  .copyWith(color: AppColors.appColor2C303E),
                            ),
                            trailing: Icon(Icons.arrow_forward_outlined,
                                color: AppColors.inactiveColor),
                          ),
                        );
                      },
                    ),
                  ),
                )
        ]),
      ),
    );
  }
}
