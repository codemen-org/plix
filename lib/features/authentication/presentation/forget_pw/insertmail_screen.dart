import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../constants/app_color.dart';
import '../../../../constants/text_font_style.dart';
import '../../../../helpers/ui_helpers.dart';
import '../../../../networks/api_acess.dart';
import '../../../../provider/email.dart';
import '../../../../widgets/custom_button.dart';

class InsertEmailScreen extends StatefulWidget {
  const InsertEmailScreen({Key? key}) : super(key: key);

  @override
  State<InsertEmailScreen> createState() => _InsertEmailScreenState();
}

class _InsertEmailScreenState extends State<InsertEmailScreen> {
  bool validation = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    EmailProvider emailProvider =
        Provider.of<EmailProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: Text("Forgot your password".tr), centerTitle: true),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: .05.sw),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              UIHelper.verticalSpaceMedium,
              Text(
                'Insert Your Email'.tr,
                style: TextFontStyle.headline2StyleInter
                    .copyWith(color: AppColors.appColorF4A4A4A),
              ),
              UIHelper.verticalSpaceSmall,
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //For Email
                    TextFormField(
                      autovalidateMode: validation
                          ? AutovalidateMode.always
                          : AutovalidateMode.disabled,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email Can\'t be empty'.tr;
                        }
                        return null;
                      },
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(
                        letterSpacing: 1.5,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        color: AppColors.headLine2Color,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Enter your email'.tr,
                        hintStyle: TextFontStyle.headline5StyleInter
                            .copyWith(color: AppColors.appColor9B9B9B),
                        labelText: 'Email'.tr,
                        labelStyle: TextFontStyle.headline5StyleInter
                            .copyWith(color: AppColors.appColorF4A4A4A),
                        errorStyle: TextStyle(
                          letterSpacing: 1,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          color: AppColors.warningColor,
                        ),
                      ),
                    ),
                    UIHelper.verticalSpaceMedium,
                  ],
                ),
              ),
              UIHelper.verticalSpaceMedium,
              customeButton(
                name: 'Next'.tr,
                height: .065.sh,
                minWidth: double.infinity,
                borderRadius: 5.r,
                color: AppColors.inactiveColor,
                textStyle: TextFontStyle.headline4StyleInter
                    .copyWith(color: AppColors.appColor4D3E39),
                context: context,
                onCallBack: () async {
                  if (_formKey.currentState!.validate()) {
                    await postForgetEmailRXObj.postForgetEmail(
                        email: emailController.text);
                    emailProvider.changeemail(emailController.text);
                  }

                  // NavigationService.popAndReplace(Routes.logInScreen);
                },
              ),
            ]),
      ),
    );
  }
}
