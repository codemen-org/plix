import 'package:auto_animated/auto_animated.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:plix/constants/app_color.dart';
import 'package:plix/constants/text_font_style.dart';
import 'package:plix/features/categories/presentation/category_search_screen.dart';
import 'package:plix/helpers/all_routes.dart';
import 'package:plix/helpers/navigation_service.dart';
import 'package:plix/networks/api_acess.dart';
import 'package:plix/widgets/loading_indicators.dart';

import '../../../constants/app_constants.dart';
import '../../../helpers/ui_helpers.dart';
import '../../../widgets/category_widget.dart';
import '../../../widgets/item_widget.dart';
import '../../../widgets/popup_item_widget.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> slider = [];
  bool isloading = true;
  final appData = GetStorage();
  final CarouselController _controller = CarouselController();
  //List<dynamic> slider = getSliderRXObj.getSliderData.value["data"]["sliders"];
  final TextEditingController languageTextController = TextEditingController();

  @override
  void initState() {
    getSliderRXObj.getSliderData.listen(
      (event) {
        setState(() {
          slider = getSliderRXObj.getSliderData.value["data"]["sliders"];
          isloading = false;
        });
      },
    );
    super.initState();
  }

  var _current;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: .06.sh,
          centerTitle: true,
          title: Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: Text(
              "Plix",
              textScaleFactor: 2,
              style: TextFontStyle.headline1StyleArial
                  .copyWith(color: Colors.amber),
            ),
          ),
          leading: Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: Image.asset(AssetIcons.splash, height: 40.h, width: 40.w),
          ),
          actions: [
            if (!appData.read(kKeyIsLoggedIn))
              InkWell(
                onTap: () {
                  NavigationService.navigateToReplacement(Routes.logInScreen);
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 10, 5),
                  child: Row(
                    children: [
                      Text(
                        "Log In",
                        style: TextFontStyle.headline2StyleArial
                            .copyWith(color: AppColors.appColorEDBB43),
                      ),
                      const Icon(
                        Icons.login_rounded,
                        color: AppColors.appColorEDBB43,
                      ),
                    ],
                  ),
                ),
              )
            // Padding(
            //   padding: EdgeInsets.only(bottom: 10),
            //   child: PopupWidget(
            //     language: languageTextController,
            //   ),
            // ),
          ],
        ),
        body: isloading
            ? loadingIndicatorCircle(context: context)
            : SingleChildScrollView(
                child: Column(children: [
                  // Container(
                  //   decoration: BoxDecoration(
                  //     boxShadow: [
                  //       BoxShadow(
                  //         color: Colors.white.withAlpha(100),
                  //         blurRadius: 10.0,
                  //         spreadRadius: 0.0,
                  //       ),
                  //     ],
                  //     border: Border.all(color: Colors.white10.withAlpha(80)),
                  //     color: Colors.black.withOpacity(0.1),
                  //   ),
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: Row(
                  //       children: [
                  //         Image.asset(AssetIcons.splash,
                  //             height: 40.h, width: 40.w),
                  //         UIHelper.horizontalSpaceSmall,
                  //         Text(
                  //           "Plix",
                  //           style: TextFontStyle.headline10StyleInter
                  //               .copyWith(color: AppColors.appColor4D3E39),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Column(children: [
                      CarouselSlider.builder(
                        itemCount: slider.length,
                        itemBuilder: (context, index, realIndex) =>
                            GestureDetector(
                          onTap: () {
                            NavigationService.navigateToWithArgs(
                                Routes.sliderWebViewPage, {
                              "title": "Details",
                              "url": slider[index]["link"] ?? ""
                            });
                          },
                          child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              child: Stack(
                                children: <Widget>[
                                  Image.network(slider[index]["img_full_path"],
                                      fit: BoxFit.cover),
                                ],
                              )),
                        ),
                        carouselController: _controller,
                        options: CarouselOptions(
                            autoPlayAnimationDuration:
                                const Duration(seconds: 3),
                            pageSnapping: false,
                            autoPlay: true,
                            enlargeCenterPage: true,
                            height: 150.h,
                            aspectRatio: 16 / 10,
                            viewportFraction: .7,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _current = index;
                              });
                            }),
                      ),
                    ]),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: slider.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () => _controller.animateToPage(entry.key),
                        child: Container(
                          width: 10.0,
                          height: 10.0,
                          margin: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 4.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                (Theme.of(context).brightness == Brightness.dark
                                        ? Colors.white
                                        : Colors.black)
                                    .withOpacity(
                                        _controller == entry.key ? 0.9 : 0.4),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  UIHelper.customDivider(),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Categorias".tr,
                          style: TextFontStyle.headline10StyleInter,
                        ),
                        GestureDetector(
                          child: Text(
                            "Ver todas".tr,
                            style: TextFontStyle.headline6StyleInter
                                .copyWith(color: AppColors.appColorFF9500A),
                          ),
                          onTap: () {
                            NavigationService.navigateToWithArgs(
                              Routes.categorySearch,
                              {"allCategories": true, "name": ""},
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 120,
                    child: StreamBuilder(
                        stream: getShopCategoriRXObj.getCategoryData,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List catList =
                                snapshot.data['data']['categories']['data'];
                            return LiveList(
                              showItemInterval: Duration(milliseconds: 100),
                              showItemDuration: Duration(milliseconds: 300),
                              reAnimateOnVisibility: true,
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  catList.length > 9 ? 10 : catList.length,
                              itemBuilder: animationItemBuilder(
                                (index) {
                                  return CategoryWidget(
                                    item: catList[index],
                                  );
                                },
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return SizedBox.shrink();
                          } else {
                            return SizedBox.shrink();
                          }
                        }),
                  ),
                  UIHelper.customDivider(),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Lista de comida".tr,
                          style: TextFontStyle.headline10StyleInter,
                        ),
                        GestureDetector(
                          child: Text("Ver todas".tr,
                              style: TextFontStyle.headline6StyleInter
                                  .copyWith(color: AppColors.appColorFF9500A)),
                          onTap: () {
                            NavigationService.navigateToWithArgs(
                              Routes.categorySearch,
                              {"allCategories": false, "name": "All Item"},
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  StreamBuilder(
                      stream: getShopItemRXObj.getItemData,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List catList = snapshot.data['data']['foods']['data'];
                          return SizedBox(
                            height: .3.sh,
                            child: LiveList(
                              showItemInterval: Duration(milliseconds: 100),
                              showItemDuration: Duration(milliseconds: 300),
                              reAnimateOnVisibility: true,
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  catList!.length > 9 ? 10 : catList.length,
                              itemBuilder: animationItemBuilder(
                                (index) {
                                  return ItemWidget(
                                    item: catList[index],
                                  );
                                },
                              ),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return SizedBox.shrink();
                        }
                        return SizedBox.shrink();
                      }),
                  UIHelper.verticalSpaceLarge,
                ]),
              ));
  }
}
