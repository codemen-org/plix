import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:plix/constants/text_font_style.dart';
import 'package:plix/features/profile/data/rx_post_reset_pw/api.dart';
import 'package:plix/helpers/ui_helpers.dart';
import 'package:plix/helpers/all_routes.dart';
import 'package:plix/helpers/navigation_service.dart';
import 'package:plix/navigation_screen.dart';
import 'package:plix/widgets/custom_button.dart';
import 'package:plix/widgets/loading_indicators.dart';

import '../../../constants/app_color.dart';
import '../../../networks/api_acess.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController telePhoneEditingController = TextEditingController();
  TextEditingController emailPhoneEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
          toolbarHeight: .05.sh,
          title: Text(
            'O meu perfil'.tr,
            style: TextFontStyle.headline3StyleInter
                .copyWith(color: AppColors.appColorFFFFFF),
          ),
          centerTitle: true),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          UIHelper.verticalSpaceMedium,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 13.w),
            child: Text(
              "Nome de Utilizador".tr,
              style: TextFontStyle.headline3StyleInter
                  .copyWith(color: AppColors.appColor000000),
            ),
          ),
          UIHelper.verticalSpaceSmall,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 13.w),
            child: Text(
              "As minhas morada".tr,
              style: TextFontStyle.headline7StyleInter
                  .copyWith(color: AppColors.appColor9B9B9B),
            ),
          ),
          UIHelper.verticalSpaceSmall,
          StreamBuilder(
              stream: getAddressRXObj.getCartDataRes,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List address = snapshot.data["data"]["addresses"];
                  if (address.length != 0) {
                    return ListView.builder(
                      padding: EdgeInsets.all(0),
                      shrinkWrap: true,
                      itemCount: address.length,
                      itemBuilder: (context, index) {
                        return Container(
                          color: Colors.white,
                          child: ListTile(
                            isThreeLine: true,
                            leading: Icon(
                              address[index]["is_default"] == 1
                                  ? Icons.check_circle
                                  : Icons.radio_button_unchecked,
                              color: AppColors.appColor000000,
                            ),
                            title: Text(address[index]["address_name"],
                                style: TextFontStyle.headline5StyleInter
                                    .copyWith(color: AppColors.appColor2C303E)),
                            subtitle: Text(
                              address[index]["address"],
                              style: TextFontStyle.headline7StyleInter
                                  .copyWith(color: AppColors.appColor67605F),
                            ),
                            trailing: Wrap(
                              children: [
                                if (address[index]["is_default"] != 1)
                                  InkWell(
                                    onTap: () async {
                                      await deleteAddressWithIdRXObj
                                          .deleteAddressWithIData(
                                              address[index]['id']);
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      color: AppColors.appColor4D3E39,
                                    ),
                                  ),
                                UIHelper.horizontalSpaceSmall,
                                InkWell(
                                  onTap: () async {
                                    await getAddressWithIdRXObj
                                        .getAddressWithIData(
                                            address[index]['id']);
                                    NavigationService.navigateToWithArgs(
                                        Routes.addressScreen,
                                        {'id': address[index]['id']});
                                  },
                                  child: Icon(
                                    Icons.arrow_forward_sharp,
                                    color: AppColors.inactiveColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                } else if (snapshot.hasError) {
                  return loadingIndicatorCircle(context: context);
                }
                return SizedBox.shrink();
              }),

          // UIHelper.verticalSpaceSmall,
          InkWell(
            onTap: () {
              getAddressWithIdRXObj.clean();
              NavigationService.navigateToWithArgs(Routes.addressScreen, {});
            },
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.add_box_rounded,
                    size: 30.sp,
                    color: AppColors.inactiveColor,
                  ),
                ),
                Text(
                  "Adicionar Morada".tr,
                  style: TextFontStyle.headline7StyleInter
                      .copyWith(color: AppColors.appColor9B9B9B),
                ),
              ],
            ),
          ),
          UIHelper.verticalSpaceSmall,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 13.w),
            child: Text(
              "My Orders".tr,
              style: TextFontStyle.headline7StyleInter
                  .copyWith(color: AppColors.appColor9B9B9B),
            ),
          ),
          UIHelper.verticalSpaceSmall,
          InkWell(
              child: action_widget(
                  title: "Order History\n".tr,
                  subTitle: "Click to check your order".tr),
              onTap: () {
                NavigationService.navigateTo(Routes.orderHistoryScreen);
              }),
          StreamBuilder(
              stream: getProfileRXObj.getProfileData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  Map data = snapshot.data["data"]["user"];
                  telePhoneEditingController.text = data["phone"];
                  emailPhoneEditingController.text = data["email"];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UIHelper.verticalSpaceSmall,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 13.w),
                        child: Text(
                          "Contacto".tr,
                          style: TextFontStyle.headline7StyleInter
                              .copyWith(color: AppColors.appColor9B9B9B),
                        ),
                      ),
                      UIHelper.verticalSpaceSmall,
                      InkWell(
                          child: action_widget(
                              title: "Telefone\n", subTitle: data["phone"]),
                          onTap: () {
                            dialog_widget(context, "Telefone".tr,
                                telePhoneEditingController, () async {
                              await postUpdatePhoneRXObj.postUpdatePhone(
                                  phone: telePhoneEditingController.text);
                              NavigationService.goBack;
                            });
                          }),
                      InkWell(
                          child: action_widget(
                              title: "Email\n".tr,
                              subTitle: data["email"],
                              icon: false),
                          onTap: () {
                            // dialog_widget(context, "Email",
                            //     emailPhoneEditingController, () {});
                          }),
                      UIHelper.verticalSpaceMedium,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 13.w),
                        child: Text(
                          "Dados Privados".tr,
                          style: TextFontStyle.headline7StyleInter
                              .copyWith(color: AppColors.appColor9B9B9B),
                        ),
                      ),
                      UIHelper.verticalSpaceSmall,
                      InkWell(
                        child: action_widget(
                            title: "Password\n".tr,
                            subTitle: "*******",
                            icon: false),
                        onTap: () {
                          reset_pw_dialog_widget(context);
                        },
                      ),
                      UIHelper.verticalSpaceMedium,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 13.w),
                        child: Text(
                          "Account".tr,
                          style: TextFontStyle.headline7StyleInter
                              .copyWith(color: AppColors.appColor9B9B9B),
                        ),
                      ),
                      UIHelper.verticalSpaceSmall,
                      Container(
                        color: Colors.white,
                        child: ListTile(
                            leading: Text("Logout".tr),
                            trailing: Icon(Icons.logout_outlined),
                            onTap: () {
                              show_confirmation(
                                  context, "Do you want to sign out?".tr,
                                  () async {
                                await getLogOutRXObj.fetchLogoutData();
                              });
                            }),
                      ),
                      UIHelper.verticalSpaceSmall,
                      Container(
                          color: Colors.white,
                          child: ListTile(
                              leading: Text("Remove Account".tr),
                              trailing: Icon(Icons.restore_from_trash),
                              onTap: () {
                                show_confirmation(context,
                                    "Do you want to Remove your Account?".tr,
                                    () async {
                                  await deleteAccountRXObj.deleteAccountData();
                                });
                              })),
                      UIHelper.verticalSpaceLarge,
                    ],
                  );
                } else if (snapshot.hasError) {
                  return SizedBox.shrink();
                }
                return loadingIndicatorCircle(context: context);
              })
        ]),
      ),
    );
  }

  Future<dynamic> dialog_widget(BuildContext context, String title,
      TextEditingController controller, Function onCallback) {
    return showDialog(
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Center(
            child: Container(
          margin: MediaQuery.of(context).viewInsets,
          color: AppColors.appColor4D3E39,
          height: .21.sh,
          width: .55.sw,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              UIHelper.verticalSpaceSmall,
              Text(title, style: TextFontStyle.headline3StyleInter),
              UIHelper.verticalSpaceSmall,
              SizedBox(
                  height: .05.sh,
                  width: .50.sw,
                  child: Material(
                      child: TextFormField(
                    controller: controller,
                  ))),
              UIHelper.verticalSpaceSmall,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      onCallback();
                    },
                    child: Text(
                      'Save'.tr,
                      style: TextFontStyle.headline3StyleArial,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      NavigationService.goBack;
                    },
                    child: Text(
                      'Cancel'.tr,
                      style: TextFontStyle.headline3StyleArial,
                    ),
                  )
                ],
              ),
            ]),
          ),
        ));
      },
    );
  }
}

// ignore: must_be_immutable
class action_widget extends StatelessWidget {
  String title = "";
  String subTitle = "";
  bool icon = true;
  action_widget({
    required this.title,
    required this.subTitle,
    this.icon = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: .10.sh,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 13.w),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text.rich(TextSpan(children: [
                TextSpan(
                    text: title,
                    style: TextFontStyle.headline5StyleInter
                        .copyWith(color: AppColors.appColor2C303E)),
                TextSpan(
                  text: subTitle,
                  style: TextFontStyle.headline7StyleInter
                      .copyWith(color: AppColors.appColor67605F),
                ),
              ])),
              if (icon)
                Icon(
                  Icons.arrow_forward_sharp,
                  color: AppColors.inactiveColor,
                )
            ]),
      ),
    );
  }
}

//reset pw
Future<dynamic> reset_pw_dialog_widget(BuildContext context) {
  final _formKey = GlobalKey<FormState>();
  return showDialog(
    barrierColor: Colors.transparent,
    context: context,
    builder: (context) {
      TextEditingController oldPWController = TextEditingController();
      TextEditingController newPWController = TextEditingController();
      TextEditingController reTypePWController = TextEditingController();
      return Center(
          child: Container(
        margin: MediaQuery.of(context).viewInsets,
        color: AppColors.appColor4D3E39,
        height: .43.sh,
        width: .6.sw,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              UIHelper.verticalSpaceSmall,
              Text("Old Password".tr, style: TextFontStyle.headline3StyleInter),
              UIHelper.verticalSpaceSmall,
              SizedBox(
                  height: .05.sh,
                  width: .55.sw,
                  child: Material(
                      child: TextFormField(
                    controller: oldPWController,
                  ))),
              UIHelper.verticalSpaceSmall,
              Text("New Password".tr, style: TextFontStyle.headline3StyleInter),
              UIHelper.verticalSpaceSmall,
              SizedBox(
                  height: .05.sh,
                  width: .55.sw,
                  child: Material(
                      child: TextFormField(
                    controller: newPWController,
                  ))),
              UIHelper.verticalSpaceSmall,
              Text("Retype Password".tr,
                  style: TextFontStyle.headline3StyleInter),
              UIHelper.verticalSpaceSmall,
              SizedBox(
                  height: .05.sh,
                  width: .55.sw,
                  child: Material(
                      child: TextFormField(
                    controller: reTypePWController,
                  ))),
              UIHelper.verticalSpaceSmall,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      NavigationService.goBack;
                      postUpdatePWRXObj.postResetPW(oldPWController.text,
                          newPWController.text, reTypePWController.text);
                    },
                    child: Text(
                      'Save'.tr,
                      style: TextFontStyle.headline3StyleArial,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      NavigationService.goBack;
                    },
                    child: Text(
                      'Cancel'.tr,
                      style: TextFontStyle.headline3StyleArial,
                    ),
                  )
                ],
              ),
            ]),
          ),
        ),
      ));
    },
  );
}

//show_confirmation_dialog
Future<dynamic> show_confirmation(
    BuildContext context, String resaon, Function onCallback) {
  final _formKey = GlobalKey<FormState>();
  return showDialog(
    barrierColor: Colors.transparent,
    context: context,
    builder: (context) {
      return Center(
          child: Container(
        margin: MediaQuery.of(context).viewInsets,
        color: AppColors.appColor4D3E39,
        height: .17.sh,
        width: .6.sw,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 0, left: 5.0, right: 5.0, top: 6.0),
                  child: Text(
                    resaon,
                    style: TextFontStyle.headline3StyleInter,
                  ),
                ),
              ),
              Spacer(),
              Form(
                key: _formKey,
                child: Column(children: [
                  UIHelper.verticalSpaceSmall,
                  UIHelper.verticalSpaceSmall,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Spacer(),
                      TextButton(
                        onPressed: () {
                          onCallback();
                        },
                        child: Text(
                          'Yes'.tr,
                          style: TextFontStyle.headline3StyleArial,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          NavigationService.goBack;
                        },
                        child: Text(
                          'No'.tr,
                          style: TextFontStyle.headline3StyleArial,
                        ),
                      )
                    ],
                  ),
                ]),
              ),
            ],
          ),
        ),
      ));
    },
  );
}
