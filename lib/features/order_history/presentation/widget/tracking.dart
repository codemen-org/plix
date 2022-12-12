import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plix/constants/app_color.dart';
import 'package:plix/helpers/ui_helpers.dart';

// ignore: must_be_immutable
class TrackingWidget extends StatelessWidget {
  TrackingWidget(
      {Key? key,
      required this.title,
      required this.time,
      required this.lastVal})
      : super(key: key);

  String title;
  String time;
  bool lastVal;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        lastVal
            ? SvgPicture.asset(
                "assets/images/shortLine.svg",
                width: 8,
              )
            : SvgPicture.asset(
                "assets/images/line.svg",
                width: 8,
              ),
        UIHelper.horizontalSpaceMedium,
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.lato(
                color: AppColors.appColor4D3E39,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            UIHelper.verticalSpaceSmall,
            Text(
              time,
              style: GoogleFonts.poppins(
                  color: AppColors.appColor2C303E,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ],
    );
  }
}
