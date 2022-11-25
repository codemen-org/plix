import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plix/constants/text_font_style.dart';
import 'package:plix/helpers/ui_helpers.dart';
import 'package:plix/helpers/all_routes.dart';
import 'package:plix/helpers/navigation_service.dart';
import 'package:plix/navigation_screen.dart';
import 'package:plix/widgets/custom_button.dart';
import 'package:plix/widgets/loading_indicators.dart';

import '../../../constants/app_color.dart';
import '../../../networks/api_acess.dart';
import '../../../widgets/lebel_text_button.dart';

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
          title: Text(
            'O meu perfil',
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
              "Nome de Utilizador",
              style: TextFontStyle.headline3StyleInter
                  .copyWith(color: AppColors.appColor000000),
            ),
          ),
          UIHelper.verticalSpaceSemiLarge,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 13.w),
            child: Text(
              "As minhas morada",
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
                  if (address.length != -1) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: address.length,
                      itemBuilder: (context, index) {
                        return Container(
                          color: Colors.white,
                          child: ListTile(
                            isThreeLine: true,
                            leading: Icon(
                              address[index]["is_default"] != 1
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
                            trailing: Icon(
                              Icons.arrow_forward_sharp,
                              color: AppColors.inactiveColor,
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
              NavigationService.navigateTo(Routes.addressScreen);
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
                  "Adicionar Morada",
                  style: TextFontStyle.headline7StyleInter
                      .copyWith(color: AppColors.appColor9B9B9B),
                ),
              ],
            ),
          ),
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
                          "Contacto",
                          style: TextFontStyle.headline7StyleInter
                              .copyWith(color: AppColors.appColor9B9B9B),
                        ),
                      ),
                      UIHelper.verticalSpaceSmall,
                      InkWell(
                          child: action_widget(
                              title: "Telefone\n", subTitle: data["phone"]),
                          onTap: () {
                            dialog_widget(
                                context, "Telefone", telePhoneEditingController,
                                () async {
                              await postUpdatePhoneRXObj.postUpdatePhone(
                                  phone: telePhoneEditingController.text);
                              NavigationService.goBack;
                            });
                          }),
                      InkWell(
                          child: action_widget(
                              title: "Email\n",
                              subTitle: data["email"],
                              icon: false),
                          onTap: () {
                            dialog_widget(context, "Email",
                                emailPhoneEditingController, () {});
                          }),
                      UIHelper.verticalSpaceMedium,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 13.w),
                        child: Text(
                          "Dados Privados",
                          style: TextFontStyle.headline7StyleInter
                              .copyWith(color: AppColors.appColor9B9B9B),
                        ),
                      ),
                      UIHelper.verticalSpaceSmall,
                      InkWell(
                        child: action_widget(
                            title: "Password\n",
                            subTitle: "*******",
                            icon: false),
                        onTap: () {
                          dialog_widget(context, "Password",
                              passwordEditingController, () {});
                        },
                      ),
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
          height: .25.sh,
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
                children: [
                  TextButton(
                    onPressed: () {
                      onCallback();
                    },
                    child: Text(
                      'Save',
                      style: TextFontStyle.headline3StyleArial,
                    ),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      NavigationService.goBack;
                    },
                    child: Text(
                      'Cancel',
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
