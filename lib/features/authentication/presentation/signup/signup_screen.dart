import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:plix/helpers/all_routes.dart';
import 'package:plix/helpers/navigation_service.dart';
import 'package:plix/provider/email.dart';
import 'package:provider/provider.dart';
import '../../../../helpers/helper.dart';
import '/constants/app_color.dart';
import '/constants/app_constants.dart';
import '/constants/text_font_style.dart';
import '../../../../helpers/ui_helpers.dart';
import '/networks/api_acess.dart';
import '/widgets/custom_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController telePhoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController reTypePasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool validation = false;
  bool pwsecure = true;
  bool repwsecure = true;
  @override
  Widget build(BuildContext context) {
    EmailProvider emailProvider =
        Provider.of<EmailProvider>(context, listen: false);
    return Scaffold(
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UIHelper.verticalSpaceSmall,
                UIHelper.verticalSpaceMedium,
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    AssetIcons.splash,
                    height: 150.h,
                    width: 150.w,
                  ),
                ),
                UIHelper.verticalSpaceMedium,
                UIHelper.verticalSpaceMedium,
                Text(
                  'SignUp'.tr,
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
                            return 'First Name Can\'t be empty';
                          }
                          return null;
                        },
                        controller: firstNameController,
                        keyboardType: TextInputType.name,
                        style: TextStyle(
                          letterSpacing: 1.5,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          color: AppColors.headLine2Color,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Enter First Name',
                          hintStyle: TextFontStyle.headline5StyleInter
                              .copyWith(color: AppColors.appColor9B9B9B),
                          labelText: 'First Name',
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
                      TextFormField(
                        autovalidateMode: validation
                            ? AutovalidateMode.always
                            : AutovalidateMode.disabled,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Last Name Can\'t be empty';
                          }
                          return null;
                        },
                        controller: lastNameController,
                        keyboardType: TextInputType.name,
                        style: TextStyle(
                          letterSpacing: 1.5,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          color: AppColors.headLine2Color,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Enter Last Name',
                          hintStyle: TextFontStyle.headline5StyleInter
                              .copyWith(color: AppColors.appColor9B9B9B),
                          labelText: 'Last Name',
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
                      TextFormField(
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
                      TextFormField(
                        autovalidateMode: validation
                            ? AutovalidateMode.always
                            : AutovalidateMode.disabled,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Phone No Can\'t be empty';
                          }
                          return null;
                        },
                        controller: telePhoneController,
                        keyboardType: TextInputType.phone,
                        style: TextStyle(
                          letterSpacing: 1.5,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          color: AppColors.headLine2Color,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Enter your phone number',
                          hintStyle: TextFontStyle.headline5StyleInter
                              .copyWith(color: AppColors.appColor9B9B9B),
                          labelText: 'Telephone',
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
                                fontWeight: FontWeight.w100,
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
                                fontWeight: FontWeight.w100,
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
                                labelText: 'Retype Password',
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
                      UIHelper.verticalSpaceMedium,
                      UIHelper.verticalSpaceSemiLarge,
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
                          if (_formKey.currentState!.validate()) {
                            getSignUpRXObj.signup(
                                firstName: firstNameController.text,
                                lastName: lastNameController.text,
                                email: emailController.text,
                                phone: telePhoneController.text,
                                password: passwordController.text,
                                retypePw: reTypePasswordController.text);
                            emailProvider.changeemail(emailController.text);
                            // setId();
                            // await getLoginRXobj.login(
                            //     emailController.text, passwordController.text);

                            // setState(() {
                            //   validation = true;
                            // });
                          }
                        },
                      ),

                      UIHelper.verticalSpaceSmall,
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
                          NavigationService.popAndReplace(Routes.logInScreen);
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
