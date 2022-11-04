import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plix/constants/text_font_style.dart';
import 'package:plix/helpers/ui_helpers.dart';
import 'package:plix/helpers/all_routes.dart';
import 'package:plix/helpers/navigation_service.dart';

import '../../constants/app_color.dart';
import '../../widgets/custom_button.dart';

class OrderScreen extends StatefulWidget {
  OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: .9.sh,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            UIHelper.verticalSpaceMedium,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 13.w),
              child: Text(
                'Morada',
                style: TextFontStyle.headline7StyleInter
                    .copyWith(color: AppColors.appColor9B9B9B),
              ),
            ),
            UIHelper.verticalSpaceMedium,
            ListTile(
              title: Text(
                'A tua morada',
                style: TextFontStyle.headline5StyleInter
                    .copyWith(color: AppColors.appColor2C303E),
              ),
              tileColor: Colors.white,
              subtitle: Text(
                'Morada do utilizador',
                style: TextFontStyle.headline7StyleInter
                    .copyWith(color: AppColors.appColor67605F),
              ),
              trailing: Icon(
                Icons.arrow_forward_rounded,
                color: Colors.amberAccent[400],
              ),
            ),
            UIHelper.verticalSpaceMedium,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 13.w),
              child: Text('Hora de Entrega',
                  style: TextFontStyle.headline7StyleInter
                      .copyWith(color: AppColors.appColor9B9B9B)),
            ),
            UIHelper.verticalSpaceMedium,
            ListTile(
              title: Text(
                'Agora',
                style: TextFontStyle.headline5StyleInter
                    .copyWith(color: AppColors.appColor2C303E),
              ),
              tileColor: Colors.white,
              subtitle: Text(
                '00:00H / 01-05-2021',
                style: TextFontStyle.headline7StyleInter
                    .copyWith(color: AppColors.appColor67605F),
              ),
              trailing: Icon(
                Icons.arrow_forward_rounded,
                color: Colors.amberAccent[400],
              ),
            ),
            UIHelper.verticalSpaceMedium,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 13.w),
              child: Text('Detalhes do Pedido',
                  style: TextFontStyle.headline7StyleInter
                      .copyWith(color: AppColors.appColor9B9B9B)),
            ),
            UIHelper.verticalSpaceMedium,
            Container(
              width: double.infinity,
              height: 50.h,
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 13.w),
              decoration: BoxDecoration(color: Colors.white),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nome do Menu',
                        style: TextFontStyle.headline5StyleInter
                            .copyWith(color: AppColors.appColor2C303E),
                      ),
                      Text(
                        'Detalhes',
                        style: TextFontStyle.headline7StyleInter
                            .copyWith(color: AppColors.appColor67605F),
                      ),
                    ],
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      '1 Unidade',
                      style: TextFontStyle.headline3StyleArial
                          .copyWith(color: AppColors.appColor2C303E),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      '15,00 €',
                      style: TextFontStyle.headline7StyleInter
                          .copyWith(color: AppColors.appColor2C303E),
                    ),
                  ),
                ],
              ),
            ),
            UIHelper.verticalSpaceSmall,
            ListTile(
                tileColor: Colors.white,
                leading: Text("Total",
                    style: TextFontStyle.headline7StyleInter
                        .copyWith(color: AppColors.appColor2C303E)),
                trailing: Text("15,00 €",
                    style: TextFontStyle.headline5StyleInter
                        .copyWith(color: AppColors.appColor2C303E))),
            UIHelper.verticalSpaceSemiLarge,
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 13.w),
                child: customeButton(
                  name: 'Fazer pedido',
                  height: .075.sh,
                  minWidth: double.infinity,
                  borderRadius: 5.r,
                  color: AppColors.inactiveColor,
                  textStyle: TextFontStyle.headline4StyleInter
                      .copyWith(color: AppColors.appColor4D3E39),
                  context: context,
                  onCallBack: () async {
                    NavigationService.navigateTo(Routes.paymentScreen);
                  },
                ),
              ),
            ),
            UIHelper.verticalSpaceMedium,
          ]),
        ),
      ),
    );
  }
}
