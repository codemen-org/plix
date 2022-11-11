import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'navigation_screen.dart';
import 'networks/dio/dio.dart';
import 'features/dashboard/presentation/home_screen.dart';
import 'features/authentication/presentation/login/login_screen.dart';
import 'welcome_screen.dart';
import 'constants/app_constants.dart';
import 'helpers/notification_service.dart';
import 'networks/api_acess.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  bool _isLoading = true;
  final appData = GetStorage();

  @override
  void initState() {
    loadInitialData();
    super.initState();
  }

  loadInitialData() async {
    appData.writeIfNull(kKeyIsLoggedIn, false);

    if (appData.read(kKeyIsLoggedIn)) {
      String token = appData.read(kKeyAccessToken);
      DioSingleton.instance.update(token);
      await getSliderRXObj.fetchSlider();
      await getShopCategoriRXObj.fetchShopCategoryData();
      await getShopItemRXObj.fetchShopItemData();
      await getCartRX.getCartData();

//this should be called after shop api is called
      // String restaurantId = appData.read(kKeyShopID) ?? '';
      // if (restaurantId != '') {
      //   LocalNotificationService.getToken();
      // }

      // await getProductShowRxobj.fetchProductShowData('293');
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const WelcomeScreen();
    } else {
      return appData.read(kKeyIsLoggedIn)
          ? const NavigationScreen()
          : const LogeinScreen();
    }
  }
}
