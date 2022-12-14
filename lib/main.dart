import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:plix/constants/app_color.dart';
import 'package:plix/features/dashboard/presentation/home_screen.dart';
import 'package:plix/features/address/presentation/address_screen.dart';
import 'package:plix/features/authentication/presentation/login/login_screen.dart';
import 'package:plix/provider/email.dart';
import 'package:provider/provider.dart';

import '/constants/custome_theme.dart';
import '/helpers/all_routes.dart';
import 'features/authentication/presentation/signup/verifyotp/otp.dart';
import 'networks/dio/dio.dart';
import 'constants/app_constants.dart';
import 'helpers/di.dart';
import 'helpers/helper.dart';
import 'helpers/language.dart';
import 'helpers/navigation_service.dart';
import 'helpers/notification_service.dart';
import 'navigation_screen.dart';
import 'provider/catpopup_status.dart';
import 'provider/order_date_time.dart';
import 'provider/product_id_provider.dart';
import 'provider/sub_category.dart';
import 'features/categories/presentation/category_search_screen.dart';
import 'loading_screen.dart';
import 'features/orders/order_screen.dart';
import 'features/checkout/presentation/payment_option.dart';
import 'features/product/presentation/product_detail_screen.dart';
import 'features/profile/presentation/profle_screen.dart';

Future<void> backgroundHandler(RemoteMessage message) async {}
void main() async {
  diSetup();
  await GetStorage.init();
  DioSingleton.instance.create();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.black,
    statusBarColor: AppColors.appColor4D3E39,
  ));
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  LocalNotificationService.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _rotation();
    setId();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<EmailProvider>(
            create: ((context) => EmailProvider())),
        ChangeNotifierProvider<ProductPriceProvider>(
          create: ((context) => ProductPriceProvider()),
        ),
        ChangeNotifierProvider<DateTimeProvider>(
          create: ((context) => DateTimeProvider()),
        )
      ],
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return const UtillScreenMobile();
          } else {
            return const UtillScreen();
          }
        },
      ),
    );
  }
}

class UtillScreen extends StatelessWidget {
  const UtillScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final storage = GetStorage();
    String language = storage.read(kKeyLanguage);
    String countryCode = storage.read(kKeyCountryCode);

    return ScreenUtilInit(
      designSize: const Size(1024, 768),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return SafeArea(
          child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            translations: LocalString(),
            locale: Locale(language, countryCode),
            theme: CustomTheme.mainTheme,
            builder: (context, widget) {
              return MediaQuery(data: MediaQuery.of(context), child: widget!);
            },
            navigatorKey: NavigationService.navigatorKey,
            onGenerateRoute: RouteGenerator.generateRoute,
            home: const Loading(),
          ),
        );
      },
    );
  }
}

class UtillScreenMobile extends StatelessWidget {
  const UtillScreenMobile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final storage = GetStorage();
    String language = storage.read(kKeyLanguage);
    String countryCode = storage.read(kKeyCountryCode);

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return SafeArea(
          child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            translations: LocalString(),
            locale: Locale(language, countryCode),
            theme: CustomTheme.mainTheme,
            builder: (context, widget) {
              return MediaQuery(data: MediaQuery.of(context), child: widget!);
            },
            navigatorKey: NavigationService.navigatorKey,
            onGenerateRoute: RouteGenerator.generateRoute,
            home: Loading(),
          ),
        );
      },
    );
  }
}

void _rotation() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}
