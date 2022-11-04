import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:plix/constants/app_color.dart';
import 'package:plix/constants/text_font_style.dart';
import 'package:plix/helpers/ui_helpers.dart';
import 'package:plix/helpers/navigation_service.dart';
import 'package:plix/widgets/custom_button.dart';

import '../../../constants/app_constants.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({Key? key}) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  MapType mapType = MapType.normal;
  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Set<Marker> createMarker(double lat, double long, String markerId) {
    return {
      Marker(
          markerId: MarkerId(markerId),
          position: LatLng(lat, long),
          infoWindow: InfoWindow(title: markerId),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
          rotation: 0),
    };
  }

  final Set<Marker> markers = {};
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: MainAppBarWidget(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: .3.sh,
                width: double.infinity,
                color: AppColors.appColor4D3E39,
                child: Stack(children: [
                  Positioned(
                      top: 10,
                      left: 10,
                      child: InkWell(
                        child: Icon(Icons.arrow_back, color: Colors.white),
                        onTap: () {
                          NavigationService.goBack;
                        },
                      )),
                  Center(
                    child: Column(children: [
                      UIHelper.verticalSpaceSmall,
                      Image.asset(AssetIcons.splash,
                          height: .18.sh, width: .18.sh),
                      UIHelper.verticalSpaceSmall,
                      Text(
                        "Adicionar Morada",
                        style: TextFontStyle.headline3StyleInter
                            .copyWith(color: AppColors.appColorFFFFFF),
                      )
                    ]),
                  ),
                ]),
              ),
              Container(
                width: double.infinity,
                height: 250.h,
                child: GoogleMap(
                  onMapCreated: _onMapCreated,
                  //scrollGesturesEnabled: true,
                  // gestureRecognizers: <
                  //     Factory<OneSequenceGestureRecognizer>>{
                  //   Factory<OneSequenceGestureRecognizer>(
                  //     () => EagerGestureRecognizer(),
                  //   ),
                  // },
                  zoomGesturesEnabled: true,
                  mapType: mapType,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                        // double.parse(orderData['latitude']),
                        // double.parse(
                        //   orderData['longitude'],
                        // ),
                        22.8165888,
                        89.5618131),
                    zoom: 14.0,
                  ),
                  markers: createMarker(22.8165888, 89.5618131, '1'),
                ),
              ),
              ListView(
                padding: EdgeInsets.symmetric(horizontal: 13.w),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  UIHelper.verticalSpaceMedium,
                  Text(
                    'Morada/Rua',
                    style: TextFontStyle.headline5StyleInter
                        .copyWith(color: AppColors.appColorF4A4A4A),
                  ),
                  UIHelper.verticalSpaceSmall,
                  Text(
                    'Localização Atual',
                    style: TextFontStyle.headline5StyleInter
                        .copyWith(color: AppColors.appColor9B9B9B),
                  ),
                  UIHelper.verticalSpaceSmall,
                  Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  UIHelper.verticalSpaceMedium,
                  Row(
                    children: [
                      Text(
                        'Número da Porta',
                        style: TextFontStyle.headline5StyleInter
                            .copyWith(color: AppColors.appColorF4A4A4A),
                      ),
                      Spacer(),
                      Text(
                        'Andar',
                        style: TextFontStyle.headline5StyleInter
                            .copyWith(color: AppColors.appColorF4A4A4A),
                      ),
                    ],
                  ),
                  UIHelper.verticalSpaceMedium,
                  Row(
                    children: [
                      Text(
                        'Número',
                        style: TextFontStyle.headline5StyleInter
                            .copyWith(color: AppColors.appColor9B9B9B),
                      ),
                      Spacer(),
                      Text(
                        'Andar',
                        textAlign: TextAlign.start,
                        style: TextFontStyle.headline5StyleInter
                            .copyWith(color: AppColors.appColor9B9B9B),
                      ),
                    ],
                  ),
                  UIHelper.verticalSpaceSmall,
                  Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  UIHelper.verticalSpaceMedium,
                  Text(
                    'Cidade',
                    style: TextFontStyle.headline5StyleInter
                        .copyWith(color: AppColors.appColor9B9B9B),
                  ),
                  UIHelper.verticalSpaceSmall,
                  Text('Guimarães',
                      style: TextFontStyle.headline5StyleInter
                          .copyWith(color: AppColors.appColor9B9B9B)),
                  Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  UIHelper.verticalSpaceMedium,
                  Text(
                    'Adictionar Morada',
                    style: TextStyle(
                        color: AppColors.inactiveColor,
                        decoration: TextDecoration.underline),
                  ),
                ],
              ),
              UIHelper.verticalSpaceSmall,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 13.w),
                child: customeButton(
                  name: 'Continue',
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
          ),
        ),
      ),
    );
  }
}
