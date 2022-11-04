import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plix/constants/app_color.dart';
import 'package:plix/helpers/ui_helpers.dart';

import '../../../constants/text_font_style.dart';
import '../../../widgets/custom_button.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  var radioValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UIHelper.verticalSpaceSemiLarge,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 13.w),
          child: Text("Método de pagamento"),
        ),
        UIHelper.verticalSpaceSmall,
        RadioListTile(
          title: Text("Mbway",
              style: TextFontStyle.headline5StyleInter
                  .copyWith(color: AppColors.appColor4D3E39)),
          subtitle: Text("Detalhes",
              style: TextFontStyle.headline7StyleInter
                  .copyWith(color: AppColors.appColor9B9B9B)),
          value: "Mbway",
          activeColor: AppColors.inactiveColor,
          groupValue: radioValue,
          onChanged: (value) {
            setState(() {
              radioValue = value as String;
            });
            log(radioValue);
          },
        ),
        RadioListTile(
          title: Text("Cartão Débito/Crédito",
              style: TextFontStyle.headline5StyleInter
                  .copyWith(color: AppColors.appColor4D3E39)),
          subtitle: Text("Detalhes",
              style: TextFontStyle.headline7StyleInter
                  .copyWith(color: AppColors.appColor9B9B9B)),
          value: "Cartão Débito/Crédito",
          groupValue: radioValue,
          activeColor: AppColors.inactiveColor,
          onChanged: (value) {
            setState(() {
              radioValue = value as String;
            });
            log(radioValue);
          },
        ),
        RadioListTile(
          title: Text("ApplePay",
              style: TextFontStyle.headline5StyleInter
                  .copyWith(color: AppColors.appColor4D3E39)),
          subtitle: Text("Detalhes",
              style: TextFontStyle.headline7StyleInter
                  .copyWith(color: AppColors.appColor9B9B9B)),
          activeColor: AppColors.inactiveColor,
          value: "ApplePay",
          groupValue: radioValue,
          onChanged: (value) {
            setState(() {
              radioValue = value as String;
            });
            log(radioValue);
          },
        ),
        RadioListTile(
          title: Text("GooglePay",
              style: TextFontStyle.headline5StyleInter
                  .copyWith(color: AppColors.appColor4D3E39)),
          subtitle: Text("Detalhes",
              style: TextFontStyle.headline7StyleInter
                  .copyWith(color: AppColors.appColor9B9B9B)),
          activeColor: AppColors.inactiveColor,
          value: "GooglePay",
          groupValue: radioValue,
          onChanged: (value) {
            setState(() {
              radioValue = value as String;
            });
            log(radioValue);
          },
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: customeButton(
            name: 'Finalizar compra',
            height: .065.sh,
            minWidth: double.infinity,
            borderRadius: 5.r,
            color: AppColors.inactiveColor,
            textStyle: TextFontStyle.headline4StyleInter
                .copyWith(color: AppColors.appColor4D3E39),
            context: context,
            onCallBack: () async {},
          ),
        ),
        UIHelper.verticalSpaceSmall,
      ],
    ));
  }
}
