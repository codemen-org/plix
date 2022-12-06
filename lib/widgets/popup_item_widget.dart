import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../constants/app_constants.dart';
import '../constants/text_font_style.dart';

class PopupWidget extends StatefulWidget {
  const PopupWidget({Key? key, required this.language}) : super(key: key);
  final TextEditingController language;

  @override
  State<PopupWidget> createState() => _PopupWidgetState();
}

class _PopupWidgetState extends State<PopupWidget> {
  final storage = GetStorage();
  final _popUpGlobalkey = GlobalKey<PopupMenuButtonState<String>>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _popUpGlobalkey.currentState!.showButtonMenu();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(
              //storage.read(kKeyLanguage) == 'pt' ?
              'My Address 1',
              //: 'My Address 2',
              style: TextFontStyle.headline3StyleInter),
          PopupMenuButton<String>(
            key: _popUpGlobalkey,
            icon: const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Colors.white,
            ),
            iconSize: (ScreenUtil().screenWidth > 600) ? 25.r : 14.r,
            onSelected: (String value) {
              setState(() {
                storage.write(kKeyLanguage, value);
                storage.write(kKeyLanguageCode, value);
                storage.write(kKeyCountryCode, countriesCode[value]);
              });
              var locale = Locale(value, countriesCode[value]);
              Get.updateLocale(locale);
            },
            color: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(6),
              ),
            ),
            offset: const Offset(0, kToolbarHeight),
            itemBuilder: (context) {
              return kLanguagesKey
                  .map((String value) => PopupMenuItem<String>(
                        value: value,
                        child: Text(languages[value]),
                      ))
                  .toList();
            },
          ),
        ],
      ),
    );
  }
}
