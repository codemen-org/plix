import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';

import '../constants/app_color.dart';
import '../constants/app_constants.dart';

Widget loadingIndicatorCircle({
  required BuildContext context,
  Color? color,
  double? size,
}) {
  double loaderSize = 50.sp;
  return Center(
    child: SpinKitFadingCircle(
      color: color ?? AppColors.appColor4D3E39,
      size: size ?? loaderSize,
    ),
  );
}

Widget shimmer({
  required BuildContext context,
  Color? color,
  double? size,
}) {
  return Align(
    alignment: Alignment.bottomCenter,
    child: Lottie.asset(AssetIcons.lottie_food_loading),
  );
}
