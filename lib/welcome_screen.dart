import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '/constants/app_color.dart';

import 'constants/app_constants.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(color: AppColors.appColorEDBB43),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 40.h,
                ),
                SvgPicture.asset(AssetIcons.splash,
                    color: AppColors.appColor2C303E),
                SizedBox(
                  height: 20.h,
                ),
              ]),
        ),
      ),
    );
  }
}
