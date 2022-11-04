import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_color.dart';

/// Contains useful consts to reduce boilerplate and duplicate code
class UIHelper {
  // Vertical spacing constants. Adjust to your liking.
  static final double _verticalSpaceSmall = 10.0.w;
  static final double _verticalSpaceMedium = 20.0.w;
  static final double _verticalSpaceSemiLarge = 40.0.w;
  static final double _verticalSpaceLarge = 60.0.w;
  static final double _verticalSpaceExtraLarge = 100.0.w;

  // Vertical spacing constants. Adjust to your liking.
  static final double _horizontalSpaceSmall = 10.0.h;
  static final double _horizontalSpaceMedium = 20.0.h;
  static final double _horizontalSpaceSemiLarge = 40.0.h;
  static final double _horizontalSpaceLarge = 60.0.h;

  static Widget verticalSpaceSmall = SizedBox(height: _verticalSpaceSmall);
  static Widget verticalSpaceMedium = SizedBox(height: _verticalSpaceMedium);
  static Widget verticalSpaceSemiLarge =
      SizedBox(height: _verticalSpaceSemiLarge);
  static Widget verticalSpaceLarge = SizedBox(height: _verticalSpaceLarge);
  static Widget verticalSpaceExtraLarge =
      SizedBox(height: _verticalSpaceExtraLarge);

  static Widget horizontalSpaceSmall = SizedBox(width: _horizontalSpaceSmall);
  static Widget horizontalSpaceMedium = SizedBox(width: _horizontalSpaceMedium);
  static Widget horizontalSpaceSemiLarge =
      SizedBox(width: _horizontalSpaceSemiLarge);
  static Widget horizontalSpaceLarge = SizedBox(width: _horizontalSpaceLarge);

  static Widget horizontalSpace(double width) => SizedBox(width: width);
  static Widget verticalSpace(double height) => SizedBox(height: height);

  static Widget customDivider() => Container(
        height: .06.h,
        color: AppColors.appColorF707070,
        width: double.infinity,
      );
  static double kDefaulutPadding() => 10.w;
}

class VerticalItem extends StatelessWidget {
  const VerticalItem({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) => Container(
        height: 96,
        child: Card(
          child: Text(
            '$title a long title',
            style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
          ),
        ),
      );
}

class HorizontalItem extends StatelessWidget {
  const HorizontalItem({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) => Container(
        width: 140,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Material(
            color: Colors.white,
            child: Center(
              child: Text(
                title,
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ),
        ),
      );
}

/// Wrap Ui item with animation & padding
Widget Function(
  BuildContext context,
  int index,
  Animation<double> animation,
) animationItemBuilder(
  Widget Function(int index) child, {
  EdgeInsets padding = EdgeInsets.zero,
}) =>
    (
      BuildContext context,
      int index,
      Animation<double> animation,
    ) =>
        FadeTransition(
          opacity: Tween<double>(
            begin: 0,
            end: 1,
          ).animate(animation),
          child: SlideTransition(
            position: Tween<Offset>(
              begin: Offset(0, -0.1),
              end: Offset.zero,
            ).animate(animation),
            child: Padding(
              padding: padding,
              child: child(index),
            ),
          ),
        );

Widget Function(
  BuildContext context,
  Animation<double> animation,
) animationBuilder(
  Widget child, {
  double xOffset = 0,
  EdgeInsets padding = EdgeInsets.zero,
}) =>
    (
      BuildContext context,
      Animation<double> animation,
    ) =>
        FadeTransition(
          opacity: Tween<double>(
            begin: 0,
            end: 1,
          ).animate(animation),
          child: SlideTransition(
            position: Tween<Offset>(
              begin: Offset(xOffset, 0.1),
              end: Offset.zero,
            ).animate(animation),
            child: Padding(
              padding: padding,
              child: child,
            ),
          ),
        );
