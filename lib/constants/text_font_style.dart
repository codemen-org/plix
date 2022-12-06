import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_color.dart';

class TextFontStyle {
//Initialising Constractor
  TextFontStyle._();

  //new
  static final headline1StyleInter = GoogleFonts.inter(
      color: AppColors.appColorFFFFFF,
      fontSize: 50.sp,
      fontWeight: FontWeight.w400);
  static final headline2StyleInter = GoogleFonts.inter(
      color: AppColors.appColorFFFFFF,
      fontSize: 20.sp,
      fontWeight: FontWeight.w400);
  static final headline3StyleInter = GoogleFonts.inter(
      color: AppColors.appColorFFFFFF,
      fontSize: 16.sp,
      fontWeight: FontWeight.w400);
  static final headline4StyleInter = GoogleFonts.inter(
      color: AppColors.appColorFFFFFF,
      fontSize: 14.sp,
      fontWeight: FontWeight.w400);
  static final headline10StyleInter = GoogleFonts.inter(
      color: AppColors.appColor000000,
      fontSize: 14.sp,
      fontWeight: FontWeight.bold);
  static final headline5StyleInter = GoogleFonts.inter(
      color: AppColors.appColorFFFFFF,
      fontSize: 12.sp,
      fontWeight: FontWeight.w400);
  static final headline6StyleInter = GoogleFonts.inter(
      color: AppColors.appColorFFFFFF,
      fontSize: 10.sp,
      fontWeight: FontWeight.bold);
  static final headline7StyleInter = GoogleFonts.inter(
      color: AppColors.appColorFFFFFF,
      fontSize: 10.sp,
      fontWeight: FontWeight.w400);
  static final headline8StyleInter = GoogleFonts.inter(
      color: AppColors.appColorFFFFFF,
      fontSize: 8.sp,
      fontWeight: FontWeight.w400);
  static final headline9StyleInter = GoogleFonts.inter(
      color: AppColors.appColorFFFFFF,
      fontSize: 7.sp,
      fontWeight: FontWeight.bold);

  static final headline1StyleArial = TextStyle(
      fontFamily: "Arial",
      color: AppColors.appColorFFFFFF,
      fontSize: 16.sp,
      fontWeight: FontWeight.bold);
  static final headline2StyleArial = TextStyle(
      fontFamily: "Arial",
      color: AppColors.appColorFFFFFF,
      fontSize: 12.sp,
      fontWeight: FontWeight.bold);
  static final headline3StyleArial = TextStyle(
      fontFamily: "Arial",
      color: AppColors.appColorFFFFFF,
      fontSize: 10.sp,
      fontWeight: FontWeight.bold);
  static final headline4StyleArial = TextStyle(
      fontFamily: "Arial",
      color: AppColors.appColorFFFFFF,
      fontSize: 8.sp,
      fontWeight: FontWeight.bold);
}
