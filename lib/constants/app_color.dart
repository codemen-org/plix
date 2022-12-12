import 'dart:core';

import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // static const Color allPrimaryColor = Color(0xFFb7242a);

  static const Color appColorFFFFFF = Color(0xFFFFFFFF);
  static const Color appColor2C303E = Color(0xFF2C303E);
  static const Color appColorEDBB43 = Color(0xFFEDBB43);
  static const Color appColor9B9B9B = Color(0xFF9B9B9B);
  static const Color appColor000000 = Color(0xFF000000);
  static const Color appColor4D3E39 = Color(0xFF4D3E39);
  static const Color appColor67605F = Color(0xFF67605F);
  static const Color appColorB7242A = Color(0xFFB7242A);
  static const Color appColorE4E4E4 = Color(0xFFE4E4E4);
  static const Color appColorFF9500A = Color(0xFFF9500A);
  static const Color appColorF4A4A4A = Color(0xFF4A4A4A);
  static const Color appColorFE65934 = Color(0xFFE65934);
  static const Color appColorFFBFBFB = Color(0xFFFBFBFB);
  static const Color appColorF707070 = Color(0xFF707070);
  static const Color appColorFF7F2E5 = Color(0xFFF7F2E5);
  static const Color appColorFD9D9D9 = Color(0xFFD9D9D9);
  static const Color appColorFDDDDDD = Color(0xFFDDDDDD);
  static const Color appColorFE8E8E8 = Color(0xFFE8E8E8);
  static const Color appColorFF6F6F6 = Color(0xFFF6F6F6);

  static const Color scaffoldColor = Color(0xFFFBFBFB);
  static const Color primaryColor = Color(0xFF4d3e39);
  static const Color activeColor = Color(0xFF326144);
  static const Color debitHigheColor = Color(0xFFb7242a);
  static const Color inactiveColor = Color(0xFFEDBB43);
  static const Color linkColor = Color(0xFFf0e0c1);
  static const Color loginBackground = Color(0xFFf4d68e);
  static const Color warningColor = Color(0xFFb7242a);
  static const Color ratingColor = Color(0xFFE65934);
  static const Color bgColor = Color(0xFFFBFBFB);

  static const Color headLine1Color = Color(0xFF4A4A4A);
  static const Color headLine2Color = Color.fromARGB(255, 19, 19, 20);
  static const Color disabledColor = Color(0xFF9B9B9B);
  static const Color unselectedButtonTextColor = Color(0xFF2C303E);

  static const Color creditHighliteColor = Color(0xFF709B72);

  static const Color penIconColor = Color(0xFF00A7FF);
  static const Color alertButtonColor = Color(0xFFFEFFFB);

  static const Color white = Color(0xFFFFFFFF);
  static const Color borderColor = Color(0xFFDDDDDD);

  static const Color secondaryColor = Color(0xFF444242);

  // static const Color expandedList = Color(0xFFECECEC);
  static const Color shadowText = Color(0xFFF1F2F7);
  static const Color shadowText2 = Color(0xFFB0B0B0);
  // static const Color linkColor = Color(0xFFf0e0c1);
  // static const Color appDrawerTextColor = Color(0xFF4D4D4D);
  // static const Color publicationTextColor = Color(0xFF3B566E);
  // static const Color loaderColor = Color(0xFFD8D8D8);
  // static const Color bookNameColor = Color(0xFFD8D8D8);
  // static const Color tudoColor = Color(0xFFDEAB52);
  // static const Color dateColor = Color(0xFF979797);
  // static const Color beginGradient = Color(0xFFA48F73);
  // static const Color endGradient = Color(0xFF887357);
  // static const Color buttonColor = Color.fromARGB(255, 240, 158, 50);
  // static const Color deviderColor = Color.fromARGB(255, 93, 155, 139);
  // static const Color textFieldBorderColor = Color(0xFFE5E5E5);
  // static const Color expandedTilebgColor = Colors.white;
  // static const Color drawerLogoColor = Color(0xFFC68A39);
  // static const Color drawerLineColor = Color(0xFFEDF5F3);

  static const MaterialColor kToDark = MaterialColor(
    0xFF4d3e39, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xFF4d3e39), //10%
      100: Color(0xFF4d3e39), //20%
      200: Color(0xFF4d3e39), //30%
      300: Color(0xFF4d3e39), //40%
      400: Color(0xFF4d3e39), //50%
      500: Color(0xFF4d3e39), //60%
      600: Color(0xFF4d3e39), //70%
      700: Color(0xFF4d3e39), //80%
      800: Color(0xFF4d3e39), //80%
      900: Color(0xFF4d3e39), //80%
    },
  );
}

class OrderStatusColor {
  //Order Status Color Code
  static const Color kPENDING = Color(0xFF6c757d);
  static const Color kACCEPTED = Color(0xFF0b79fa);
  static const Color kFOODPROCESSING = Color(0xFF31a2b8);
  static const Color kFOODREADY = Color(0xFFffc234);
  static const Color kFOODPICKED = Color(0xFF6658dd);
  static const Color kFOODDELIVERED = Color(0xFF4fa744);
  static const Color kCANCELLED = Color(0xFFdd4246);
  static const Color kREJECTEDBYSHOP = Color(0xFFdd4246);
  static const Color kFAILED = Color(0xFFdd4246);
}

class DeliveryStatusColor {
  //Delivery Status Color Code
  static const Color kPENDING = Color(0xFF6c757d);
  static const Color kDELIVERYMANCONFIRMED = Color(0xFF0b79fa);
  static const Color kDELIVERYSTARTED = Color(0xFF6658dd);
  static const Color kARRIVEDATSHOP = Color(0xFFffc234);
  static const Color kONTRANSIT = Color(0xFF31a2b8);
  static const Color kDELIVERED = Color(0xFF4fa744);
}
