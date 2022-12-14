import 'package:badges/badges.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:plix/constants/app_color.dart';
import 'package:plix/features/dashboard/presentation/home_screen.dart';
import 'package:plix/helpers/all_routes.dart';
import 'package:plix/helpers/navigation_service.dart';
import 'package:plix/helpers/toast.dart';
import 'package:plix/networks/api_acess.dart';

import 'constants/app_constants.dart';
import 'features/categories/presentation/category_search_screen.dart';
import 'features/orders/order_screen.dart';
import 'features/profile/presentation/profle_screen.dart';

class NavigationScreen extends StatefulWidget {
  final Widget? pageNum;
  const NavigationScreen({
    Key? key,
    this.pageNum,
  }) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  final appdata = GetStorage();
  //Variable for navigation Index
  int _currentIndex = 0;
  //Variable for navigation Color Index
  int _colorIndex = 0;

  bool _isFisrtBuild = true;
  bool _navigationOn = true;
  //final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  final List<StatefulWidget> _screens = [
    HomeScreen(),
    CategorySearch(allCategories: false, catname: "All Item"),
    OrderScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();

    // WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
    //   if (Platform.isIOS) {
    //     _firebaseMessaging.requestPermission();
    //     // _firebaseMessaging!.requestNotificationPermissions(
    //     //     const IosNotificationSettings(sound: true, badge: true, alert: true));
    //     _firebaseMessaging.getNotificationSettings();
    //   }
    // });

    // FirebaseMessaging.instance.getToken().then(
    //   (value) async {
    //     if (kDebugMode) {
    //       print("FCM -- > token [ $value ]");
    //     }
    //   },
    // );
    // FirebaseMessaging.instance.subscribeToTopic('blog');

    // 1. This method call when app in terminated state and you get a notification
    // when you click on notification app open from terminated state and you can get notification data in this method
    // FirebaseMessaging.instance.getInitialMessage().then(
    //   (message) async {
    //     if (kDebugMode) {
    //       print("${FirebaseMessaging.instance.getInitialMessage}");
    //     }
    //     if (message != null) {
    //       if (kDebugMode) {
    //         print("New Notification");
    //       }
    //       if (message.data['_id'] != null) {
    //         await getBloagDetailsRXobj
    //             .fetchBlogDetailsData(message.data['_id'].toString());
    //         Navigator.pushNamed(
    //           context,
    //           Routes.navigation,
    //           arguments: const PublicationDetailsScreen(),
    //         );
    //         if (kDebugMode) {
    //           print("${message.data['_id']}");
    //         }
    //       }
    //     }
    //   },
    // );
    // // 2. This method only call when App in forground it mean app must be opened
    // FirebaseMessaging.onMessage.listen((message) async {
    //   if (kDebugMode) {
    //     print("FirebaseMessaging.onMessage.listen");
    //   }
    //   if (message.notification != null) {
    //     if (kDebugMode) {
    //       print(message.notification!.title);
    //       print(message.notification!.body);
    //       print("message.data11 ${message.data}");
    //     }
    //     LocalNotificationService.createanddisplaynotification(message);
    //   }
    // });

    // // 3. This method only call when App in background and not terminated(not closed)
    // FirebaseMessaging.onMessageOpenedApp.listen((message) async {
    //   if (kDebugMode) {
    //     print("FirebaseMessaging.onMessageOpenedApp.listen");
    //   }
    //   if (message.notification != null) {
    //     if (kDebugMode) {
    //       print(message.notification!.title);
    //       print(message.notification!.body);
    //       print("message.data22 ${message.data['_id']}");
    //     }

    //     if (message.data['_id'] != null) {
    //       await getBloagDetailsRXobj
    //           .fetchBlogDetailsData(message.data['_id'].toString());
    //       Navigator.pushNamed(
    //         context,
    //         Routes.navigation,
    //         arguments: const PublicationDetailsScreen(),
    //       );
    //     }
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    Object? args;
    StatefulWidget? screenPage;
    if (_isFisrtBuild) {
      args = ModalRoute.of(context)!.settings.arguments;
    }
    if (args != null) {
      _colorIndex = 5;
      screenPage = args as StatefulWidget;
      var newColorindex = -1;

      for (var element in _screens) {
        newColorindex++;
        if (element.toString() == screenPage.toString()) {
          _colorIndex = newColorindex;
          _currentIndex = newColorindex;
          break;
        }
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      //appBar: const MainAppBarWidget(),
      // drawer: const AppDrawer(),
      onDrawerChanged: (isOpened) => setState(() {
        _navigationOn = !isOpened;
      }),
      body: Center(
          child: (screenPage != null)
              ? screenPage
              : _screens.elementAt(_currentIndex)),

      // ClipRRect(
      //   borderRadius: BorderRadius.all(
      //     Radius.circular(10.r),
      //   ),
      //   child: BottomNavigationBar(
      //     type: BottomNavigationBarType.fixed,
      //     showSelectedLabels: true,
      //     showUnselectedLabels: true,
      //     // selectedItemColor: AppColors.primaryColor,
      //     // unselectedItemColor: AppColors.linkColor,
      //     selectedLabelStyle: TextStyle(
      //         fontSize: 12.sp,
      //         fontWeight: FontWeight.bold,
      //         color: AppColors.primaryColor),
      //     unselectedLabelStyle: TextStyle(
      //         fontSize: 12.sp,
      //         fontWeight: FontWeight.normal,
      //         color: AppColors.linkColor),
      //     onTap: (index) {
      //       setState(() {
      //         screenPage = null;
      //         _isFisrtBuild = false;
      //         _currentIndex = index;
      //         _colorIndex = index;
      //       });
      //     },
      //     currentIndex: _currentIndex,
      //     items: <BottomNavigationBarItem>[
      //       BottomNavigationBarItem(
      //           icon: SvgPicture.asset(
      //             'assets/icons/home.svg',
      //             height: 25,
      //             width: 25,
      //             color: (_colorIndex == 0)
      //                 ? AppColors.primaryColor
      //                 : AppColors.linkColor,
      //           ),
      //           label: 'Home'),
      //       BottomNavigationBarItem(
      //           icon: SvgPicture.asset(
      //             'assets/icons/content.svg',
      //             height: 25,
      //             width: 25,
      //             color: (_colorIndex == 1)
      //                 ? AppColors.primaryColor
      //                 : AppColors.linkColor,
      //           ),
      //           label: 'Contestar'),
      //       BottomNavigationBarItem(
      //           icon: SvgPicture.asset(
      //             'assets/icons/publication.svg',
      //             height: 25,
      //             width: 25,
      //             color: (_colorIndex == 2)
      //                 ? AppColors.primaryColor
      //                 : AppColors.linkColor,
      //           ),
      //           label: 'Publicações'),
      //       BottomNavigationBarItem(
      //           icon: SvgPicture.asset(
      //             'assets/icons/faq.svg',
      //             height: 25,
      //             width: 25,
      //             color: (_colorIndex == 3)
      //                 ? AppColors.primaryColor
      //                 : AppColors.linkColor,
      //           ),
      //           label: 'Faqs'),
      //       BottomNavigationBarItem(
      //           icon: SvgPicture.asset(
      //             'assets/icons/contact.svg',
      //             width: 22.w,
      //             height: 22.h,
      //             color: (_colorIndex == 4)
      //                 ? AppColors.primaryColor
      //                 : AppColors.linkColor,
      //           ),
      //           label: 'Contactos'),
      //     ],
      //   ),
      // ),
      bottomNavigationBar: CustomNavigationBar(
        iconSize: 40.r,
        selectedColor: Colors.white,
        strokeColor: Colors.transparent,
        unSelectedColor: AppColors.appColorEDBB43,
        backgroundColor: AppColors.appColor4D3E39,
        items: [
          CustomNavigationBarItem(
            icon: SvgPicture.asset(
              AssetIcons.home,
              color: (_currentIndex == 0)
                  ? AppColors.appColorFFFFFF
                  : AppColors.appColorEDBB43,
            ),
          ),
          CustomNavigationBarItem(
            icon: SvgPicture.asset(
              AssetIcons.search,
              color: (_currentIndex == 1)
                  ? AppColors.appColorFFFFFF
                  : AppColors.appColorEDBB43,
            ),
          ),
          CustomNavigationBarItem(
            icon: Badge(
              position: BadgePosition(start: 25, top: -5),
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
                      "0",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    );
                  }
                  return SizedBox.shrink();
                },
              ),
              child: SvgPicture.asset(
                AssetIcons.cart,
                color: (_currentIndex == 2)
                    ? AppColors.appColorFFFFFF
                    : AppColors.appColorEDBB43,
              ),
            ),
          ),
          CustomNavigationBarItem(
            icon: SvgPicture.asset(
              AssetIcons.profile,
              color: (_currentIndex == 3)
                  ? AppColors.appColorFFFFFF
                  : AppColors.appColorEDBB43,
            ),
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          if (appdata.read(kKeyIsLoggedIn) || index == 1 || index == 0) {
            setState(() {
              _currentIndex = index;
            });
          } else {
            ToastUtil.showLongToast("You need to log in first");
          }
        },
      ),
    );
  }
}
