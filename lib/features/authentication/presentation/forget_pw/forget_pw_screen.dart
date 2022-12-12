import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../constants/app_color.dart';
import '../../../../constants/app_constants.dart';
import '../../../../constants/text_font_style.dart';
import '../../../../helpers/all_routes.dart';
import '../../../../helpers/ui_helpers.dart';
import '../../../../networks/api_acess.dart';
import '../../../../provider/email.dart';
import '../../../../widgets/custom_button.dart';

class ForgotPWScreen extends StatefulWidget {
  ForgotPWScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPWScreen> createState() => _ForgotPWScreenState();
}

class _ForgotPWScreenState extends State<ForgotPWScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController reTypePasswordController = TextEditingController();
  TextEditingController vcodeController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool validation = false;
  bool pwsecure = true;
  bool repwsecure = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    EmailProvider emailProvider =
        Provider.of<EmailProvider>(context, listen: false);
    emailController.text = emailProvider.email;
    return Scaffold(
      appBar: AppBar(title: Text("Redefine password".tr), centerTitle: true),
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: .05.sw),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.scaffoldColor,
                AppColors.scaffoldColor,
              ],
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                UIHelper.verticalSpace(.15.sh),
                Text(
                  'Provide your email',
                  style: TextFontStyle.headline2StyleInter
                      .copyWith(color: AppColors.appColorF4A4A4A),
                ),
                UIHelper.verticalSpaceMedium,
                UIHelper.verticalSpaceSmall,
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //For Email

                      UIHelper.verticalSpaceSmall,

                      UIHelper.verticalSpaceSmall,
                      TextFormField(
                        enabled: false,
                        autovalidateMode: validation
                            ? AutovalidateMode.always
                            : AutovalidateMode.disabled,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email Can\'t be empty';
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
                          hintText: 'Enter your email',
                          hintStyle: TextFontStyle.headline5StyleInter
                              .copyWith(color: AppColors.appColor9B9B9B),
                          labelText: 'Email',
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

                      UIHelper.verticalSpaceSmall,

                      //For Password
                      Row(
                        children: [
                          Expanded(
                            flex: 9,
                            child: TextFormField(
                              autovalidateMode: validation
                                  ? AutovalidateMode.always
                                  : AutovalidateMode.disabled,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter Password';
                                } else if (value.length <= 5) {
                                  return 'Password must be  at least 6 characters';
                                }
                                return null;
                              },
                              controller: passwordController,
                              obscureText: pwsecure,
                              style: TextStyle(
                                letterSpacing: 1.5,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                color: AppColors.headLine2Color,
                              ),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 1.0,
                                ),
                                hintText: 'Enter your Password',
                                hintStyle: TextFontStyle.headline5StyleInter
                                    .copyWith(color: AppColors.appColor9B9B9B),
                                labelText: 'Password',
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
                          ),
                          Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      pwsecure = !pwsecure;
                                    });
                                  },
                                  child: Icon(
                                    Icons.remove_red_eye,
                                    size: 30.sp,
                                    color: pwsecure
                                        ? AppColors.headLine1Color
                                        : AppColors.appColor9B9B9B,
                                  ),
                                ),
                              ))
                        ],
                      ),
                      UIHelper.verticalSpaceSmall,

                      //For Password
                      Row(
                        children: [
                          Expanded(
                            flex: 9,
                            child: TextFormField(
                              autovalidateMode: validation
                                  ? AutovalidateMode.always
                                  : AutovalidateMode.disabled,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Retype Password'.tr;
                                } else if (passwordController.text != value) {
                                  return 'Password Missmatch'.tr;
                                }
                                return null;
                              },
                              controller: reTypePasswordController,
                              obscureText: repwsecure,
                              style: TextStyle(
                                letterSpacing: 1.5,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                color: AppColors.headLine2Color,
                              ),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 1.0,
                                ),
                                hintText: 'Enter your Password'.tr,
                                hintStyle: TextFontStyle.headline5StyleInter
                                    .copyWith(color: AppColors.appColor9B9B9B),
                                labelText: 'Retype Password'.tr,
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
                          ),
                          Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      repwsecure = !repwsecure;
                                    });
                                  },
                                  child: Icon(
                                    Icons.remove_red_eye,
                                    size: 30.sp,
                                    color: repwsecure
                                        ? AppColors.headLine1Color
                                        : AppColors.appColor9B9B9B,
                                  ),
                                ),
                              ))
                        ],
                      ),
                      UIHelper.verticalSpaceSmall,
                      TextFormField(
                        autovalidateMode: validation
                            ? AutovalidateMode.always
                            : AutovalidateMode.disabled,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Code Can\'t be empty'.tr;
                          }
                          return null;
                        },
                        controller: vcodeController,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          letterSpacing: 1.5,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          color: AppColors.headLine2Color,
                        ),
                        decoration: InputDecoration(
                          hintText:
                              'Enter your verification code check email'.tr,
                          hintStyle: TextFontStyle.headline5StyleInter
                              .copyWith(color: AppColors.appColor9B9B9B),
                          labelText: 'Verification Code'.tr,
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
                      UIHelper.verticalSpaceSemiLarge,
                      customeButton(
                        name: 'Change Password'.tr,
                        height: .065.sh,
                        minWidth: double.infinity,
                        borderRadius: 5.r,
                        color: AppColors.primaryColor,
                        textStyle: TextFontStyle.headline4StyleInter
                            .copyWith(color: AppColors.appColorFFFFFF),
                        context: context,
                        onCallBack: () async {
                          if (_formKey.currentState!.validate()) {
                            await postForgertPwRXObj.postProductBasicData(
                                emailController.text,
                                passwordController.text,
                                reTypePasswordController.text,
                                vcodeController.text);
                          }
                        },
                      ),
                    ],
                  ),
                ),
                UIHelper.verticalSpaceSmall,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
