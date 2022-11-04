import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:plix/navigation_screen.dart';
import 'package:plix/features/authentication/presentation/login/login_screen.dart';
import 'package:plix/features/address/presentation/address_screen.dart';
import 'package:plix/features/product/presentation/product_detail_screen.dart';

import '../features/authentication/presentation/forget_pw/forget_pw_screen.dart';
import '../features/authentication/presentation/forget_pw/insertmail_screen.dart';
import '../features/authentication/presentation/signup/verifyotp/otp.dart';
import '../features/categories/presentation/category_search_screen.dart';
import '../features/checkout/presentation/payment_option.dart';
import '../features/authentication/presentation/signup/signup_screen.dart';
import '../features/dashboard/presentation/slider_webview.dart';
import '../loading_screen.dart';
import '../features/dashboard/presentation/home_screen.dart';

class Routes {
  static const String logInScreen = '/logIn';
  static const String signUpScreen = '/signUp';
  static const String home = '/home';
  static const String productDetailScreen = '/ProductDetailScreen';
  static const String addressScreen = '/assdessScreen';
  static const String paymentScreen = '/paymentScreen';
  static const String naviGationScreen = '/navigationScreen';
  static const String categorySearch = '/categorySearch';
  static const String verifyOtpScreen = '/verifyOtpScreen';
  static const String emailEntryScreen = '/emailEntryScreen';
  static const String loadingScreen = '/loadingScreen';
  static const String forgotPWScreen = '/forgotPWScreen';
  static const String sliderWebViewPage = '/sliderWebViewPage';
}

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return Platform.isAndroid
            ? _FadedTransitionRoute(widget: HomeScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => HomeScreen());
      case Routes.signUpScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const SignUpScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => const SignUpScreen());
      case Routes.logInScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const LogeinScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => const LogeinScreen());
      case Routes.loadingScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const Loading(),
                settings:
                    settings) //_FadedTransitionRoute(builder: (context)=> const SobrenosScreen())
            : CupertinoPageRoute(builder: (context) => const Loading());
      case Routes.productDetailScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const ProductDetailScreen(),
                settings:
                    settings) //_FadedTransitionRoute(builder: (context)=> const SobrenosScreen())
            : CupertinoPageRoute(
                builder: (context) => const ProductDetailScreen());
      case Routes.addressScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const AddressScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => const AddressScreen());
      case Routes.paymentScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const PaymentScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => const PaymentScreen());
      case Routes.naviGationScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const NavigationScreen(), settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const NavigationScreen());
      case Routes.categorySearch:
        final args = settings.arguments as Map;

        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: CategorySearch(
                  allCategories: args["allCategories"],
                  catname: args["name"],
                ),
                settings: settings)
            : CupertinoPageRoute(
                builder: (context) => CategorySearch(
                      allCategories: args["allCategories"],
                      catname: args["name"],
                    ));
      case Routes.verifyOtpScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const VerifyOtpScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => const VerifyOtpScreen());
      case Routes.emailEntryScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: InsertEmailScreen(),
                settings:
                    settings) //_FadedTransitionRoute(builder: (context)=> const SobrenosScreen())
            : CupertinoPageRoute(builder: (context) => InsertEmailScreen());
      case Routes.forgotPWScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: ForgotPWScreen(),
                settings:
                    settings) //_FadedTransitionRoute(builder: (context)=> const SobrenosScreen())
            : CupertinoPageRoute(builder: (context) => ForgotPWScreen());
      case Routes.sliderWebViewPage:
        final args = settings.arguments as Map;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget:
                    SliderWebViewPage(title: args["title"], url: args["url"]),
                settings:
                    settings) //_FadedTransitionRoute(builder: (context)=> const SobrenosScreen())
            : CupertinoPageRoute(
                builder: (context) =>
                    SliderWebViewPage(title: args["title"], url: args["url"]));

      default:
        return null;
    }
  }
}

class _FadedTransitionRoute extends PageRouteBuilder {
  final Widget widget;
  @override
  final RouteSettings settings;

  _FadedTransitionRoute({required this.widget, required this.settings})
      : super(
          settings: settings,
          reverseTransitionDuration: const Duration(milliseconds: 600),
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return widget;
          },
          transitionDuration: const Duration(microseconds: 100),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              ),
              child: child,
            );
          },
        );
}