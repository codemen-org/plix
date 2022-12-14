import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:plix/helpers/all_routes.dart';
import 'package:plix/helpers/navigation_service.dart';
import '../../../../helpers/helper.dart';
import '/constants/app_color.dart';
import '/constants/app_constants.dart';
import '/constants/text_font_style.dart';
import '../../../../helpers/ui_helpers.dart';
import '/networks/api_acess.dart';
import '/widgets/custom_button.dart';

class LogeinScreen extends StatefulWidget {
  const LogeinScreen({Key? key}) : super(key: key);

  @override
  State<LogeinScreen> createState() => _LogeinScreenState();
}

class _LogeinScreenState extends State<LogeinScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? emailvalidation;
  bool validation = false;

  bool pwsecure = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 50.sh,
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: .05.sw),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.loginBackground,
                AppColors.loginBackground,
              ],
            ),
          ),
          child: SingleChildScrollView(
            child: Container(
              height: .9.sh,
              child: Column(
                children: [
                  UIHelper.verticalSpaceSemiLarge,
                  Image.asset(AssetIcons.splash, height: .18.sh, width: .18.sh),
                  //  UIHelper.verticalSpaceLarge,
                  Spacer(),
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
                              return 'Enter email';
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
                            color: AppColors.scaffoldColor,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Enter your email or phone',
                            hintStyle: TextFontStyle.headline5StyleInter
                                .copyWith(color: AppColors.appColorFFFFFF),
                            labelText: 'Email',
                            labelStyle: TextFontStyle.headline5StyleInter
                                .copyWith(color: AppColors.appColorFFFFFF),
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

                        //For Password
                        Row(children: [
                          Expanded(
                            flex: 9,
                            child: TextFormField(
                              autovalidateMode: validation
                                  ? AutovalidateMode.always
                                  : AutovalidateMode.disabled,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter Password';
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
                                color: AppColors.scaffoldColor,
                              ),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 1.0,
                                ),
                                hintText: 'Enter your Password',
                                hintStyle: TextFontStyle.headline5StyleInter
                                    .copyWith(color: AppColors.appColorFFFFFF),
                                labelText: "Password",
                                labelStyle: TextFontStyle.headline5StyleInter
                                    .copyWith(color: AppColors.appColorFFFFFF),
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
                        ])
                      ],
                    ),
                  ),

                  UIHelper.verticalSpaceLarge,
                  Center(
                    child: TextButton(
                      child: Text(
                        'Forgot password?'.tr,
                        style: TextFontStyle.headline4StyleInter,
                        textAlign: TextAlign.center,
                      ),
                      onPressed: () {
                        NavigationService.navigateTo(Routes.emailEntryScreen);
                      },
                    ),
                  ),
                  Spacer(),
                  customeButton(
                    name: 'LogIn',
                    height: .065.sh,
                    minWidth: double.infinity,
                    borderRadius: 5.r,
                    color: AppColors.inactiveColor,
                    textStyle: TextFontStyle.headline4StyleInter
                        .copyWith(color: AppColors.appColor4D3E39),
                    context: context,
                    onCallBack: () async {
                      if (_formKey.currentState!.validate()) {
                        setId();
                        await getLoginRXObj.login(
                            emailController.text, passwordController.text);

                        // setState(() {
                        //   validation = true;
                        // });
                      } else {
                        const snackBar = SnackBar(
                            content: Text('Email or Password is not valid'));

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                  ),
                  UIHelper.verticalSpaceSmall,
                  customeButton(
                    name: 'Sign Up',
                    height: .065.sh,
                    minWidth: double.infinity,
                    borderRadius: 5.r,
                    color: AppColors.primaryColor,
                    textStyle: TextFontStyle.headline4StyleInter
                        .copyWith(color: AppColors.appColorFFFFFF),
                    context: context,
                    onCallBack: () async {
                      NavigationService.navigateTo(Routes.signUpScreen);
                    },
                  ),
                  UIHelper.verticalSpaceSmall,
                  Center(
                    child: TextButton(
                      child: Text(
                        'Or'.tr,
                        style: TextFontStyle.headline4StyleInter,
                        textAlign: TextAlign.center,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  UIHelper.verticalSpaceSmall,
                  customeButton(
                    name: 'Explore First'.tr,
                    height: .065.sh,
                    minWidth: double.infinity,
                    borderRadius: 5.r,
                    color: AppColors.debitHigheColor,
                    textStyle: TextFontStyle.headline4StyleInter,
                    context: context,
                    onCallBack: () async {
                      NavigationService.navigateToReplacement(
                          Routes.naviGationScreen);
                    },
                  ),
                  UIHelper.verticalSpaceSmall,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
