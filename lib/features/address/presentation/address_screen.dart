import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:plix/constants/app_color.dart';
import 'package:plix/constants/text_font_style.dart';
import 'package:plix/helpers/ui_helpers.dart';
import 'package:plix/helpers/navigation_service.dart';
import 'package:plix/widgets/custom_button.dart';

import '../../../constants/app_constants.dart';
import '../../../networks/api_acess.dart';

// ignore: must_be_immutable
class AddressScreen extends StatefulWidget {
  int? addressId;
  AddressScreen({this.addressId, Key? key}) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  MapType mapType = MapType.normal;
  late GoogleMapController mapController;
  LatLng lastMapPosition = LatLng(22.8165888, 89.5618131);
  Set<Marker> mapMarkers = Set<Marker>();
  List<Placemark>? placemarks;
  bool validation = false;
  bool isDefault = false;

  TextEditingController addressNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController cidadeController = TextEditingController();
  TextEditingController estadoController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    if (widget.addressId != null) {
      getAddressWithIdRXObj.getAddresWithIdRes.listen((value) {
        if (mounted) {
          setState(() {
            addressNameController.text = value['data']['address_name'];
            addressController.text = value['data']['address'];
            postalCodeController.text = value['data']['postal_code'];
            cidadeController.text = value['data']['city'];
            estadoController.text = value['data']['state'];
            isDefault = value['data']['is_default'] == 1 ? true : false;
            lastMapPosition = LatLng(double.parse(value['data']['latitude']),
                double.parse(value['data']['longitude']));
            //  addMapMarker(lastMapPosition.latitude, lastMapPosition.longitude);
          });
        }
      });
    } else {
      //addMapMarker(lastMapPosition.latitude, lastMapPosition.longitude);
    }
  }

  // setPostionLatLang(LatLng latLng) {
  //   lastMapPosition = latLng;
  //   addMapMarker(lastMapPosition.latitude, lastMapPosition.longitude);
  //   mapController.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
  //     target: lastMapPosition,
  //     zoom: 14,
  //   )));
  // }

  // Set<Marker> createMarker(double lat, double long, String markerId) {
  //   return {
  //     Marker(
  //         markerId: MarkerId(markerId),
  //         position: LatLng(lat, long),
  //         infoWindow: InfoWindow(title: markerId),
  //         icon:
  //             BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
  //         rotation: 0),
  //   };
  // }

  // Future<void> onCameraMove(CameraPosition position) async {
  //   lastMapPosition = position.target;
  // }

  // addMapMarker(double latitude, double longitude) {
  //   mapMarkers.removeWhere((m) => m.markerId.value == "1");
  //   Marker mapMarker = Marker(
  //     draggable: true,
  //     markerId: MarkerId("1"),
  //     position: LatLng(latitude, longitude),
  //     icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
  //   );
  //   mapMarkers.add(mapMarker);
  //   if (mounted) setState(() {});
  // }

  // Future<void> onCameraIdle() async {
  //   placemarks = await placemarkFromCoordinates(
  //       lastMapPosition.latitude, lastMapPosition.longitude);
  //   addressController.text = placemarks!.first.street! +
  //       ", " +
  //       placemarks!.first.subLocality! +
  //       ", " +
  //       placemarks!.first.locality! +
  //       ", " +
  //       placemarks!.first.country!;
  //   postalCodeController.text = placemarks!.first.postalCode!;
  //   cidadeController.text = placemarks!.first.locality!;
  //   estadoController.text = placemarks!.first.subAdministrativeArea!;
  //   log(placemarks!.first.locality.toString() +
  //       ", " +
  //       placemarks!.first.name.toString() +
  //       ", " +
  //       placemarks!.first.country.toString() +
  //       ", " +
  //       placemarks!.first.postalCode.toString() +
  //       ", " +
  //       placemarks!.first.street.toString() +
  //       ", " +
  //       placemarks!.first.subAdministrativeArea.toString() +
  //       ", " +
  //       placemarks!.first.subLocality.toString());
  //   // var addresses =
  //   //     await Geocoder.local.findAddressesFromCoordinates(coordinates);
  //   // final storage = GetStorage();
  //   // var first = addresses.first;
  //   // addressController.text = first.addressLine;
  //   // postalCodeController.text = first.postalCode;
  //   // cityController.text = first.locality;
  //   // stateController.text = first.locality;
  //   // countryController.text = first.countryName;
  //   // lastNameController.text = storage.read(kKeyLastName);
  //   // latitudeController.text = lastMapPosition.latitude.toString();
  //   // longitudeController.text = lastMapPosition.longitude.toString();
  //   //  addMapMarker(lastMapPosition.latitude, lastMapPosition.longitude);
  // }

  // @override
  void initState() {
    if (widget.addressId != null) {
      getAddressWithIdRXObj.getAddresWithIdRes.listen((value) {
        if (mounted) {
          setState(() {
            addressNameController.text = value['data']['address_name'];
            addressController.text = value['data']['address'];
            postalCodeController.text = value['data']['postal_code'];
            cidadeController.text = value['data']['city'];
            estadoController.text = value['data']['state'];
            isDefault = value['data']['is_default'] == 1 ? true : false;
            lastMapPosition = LatLng(double.parse(value['data']['latitude']),
                double.parse(value['data']['longitude']));
            //  addMapMarker(lastMapPosition.latitude, lastMapPosition.longitude);
          });
        }
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      "Adicionar Morada".tr,
                      style: TextFontStyle.headline3StyleInter
                          .copyWith(color: AppColors.appColorFFFFFF),
                    )
                  ]),
                ),
              ]),
            ),
            // Container(
            //   width: double.infinity,
            //   height: 250.h,
            //   child: GoogleMap(
            //     mapType: MapType.normal,
            //     initialCameraPosition: CameraPosition(
            //       target: lastMapPosition,
            //       zoom: 14,
            //     ),
            //     zoomControlsEnabled: true,
            //     scrollGesturesEnabled: true,
            //     onCameraIdle: onCameraIdle,
            //     myLocationButtonEnabled: true,
            //     myLocationEnabled: true,
            //     onLongPress: setPostionLatLang,
            //     onMapCreated: onMapCreated,
            //     onCameraMove: onCameraMove,
            //     markers: mapMarkers,
            //   ),
            // ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 13.w),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.all(0),
                      leading: Checkbox(
                        value: isDefault,
                        onChanged: (value) {
                          if (!isDefault) {
                            setState(() {
                              isDefault = value!;
                            });
                          }
                        },
                      ),
                      title: Text(
                        "Default Address".tr,
                        style: TextFontStyle.headline5StyleInter
                            .copyWith(color: AppColors.appColor2C303E),
                      ),
                    ),
                    TextFormField(
                      autovalidateMode: validation
                          ? AutovalidateMode.always
                          : AutovalidateMode.disabled,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Can\'t be empty';
                        }
                        return null;
                      },
                      controller: addressNameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        hintText: 'casa',
                        hintStyle: TextFontStyle.headline5StyleInter
                            .copyWith(color: AppColors.appColor9B9B9B),
                        labelText: 'Nome da modrao',
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
                    TextFormField(
                      autovalidateMode: validation
                          ? AutovalidateMode.always
                          : AutovalidateMode.disabled,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Can\'t be empty';
                        }
                        return null;
                      },
                      controller: addressController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        hintText: 'Localização Atual',
                        hintStyle: TextFontStyle.headline5StyleInter
                            .copyWith(color: AppColors.appColor9B9B9B),
                        labelText: 'Morada/Rua',
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
                    Row(
                      children: [
                        SizedBox(
                          width: .44.sw,
                          child: TextFormField(
                            autovalidateMode: validation
                                ? AutovalidateMode.always
                                : AutovalidateMode.disabled,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Can\'t be empty';
                              }
                              return null;
                            },
                            controller: postalCodeController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'Número',
                              hintStyle: TextFontStyle.headline5StyleInter
                                  .copyWith(color: AppColors.appColor9B9B9B),
                              labelText: 'Codigo postal',
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
                        UIHelper.horizontalSpaceSmall,
                        SizedBox(
                          width: .44.sw,
                          child: TextFormField(
                            autovalidateMode: validation
                                ? AutovalidateMode.always
                                : AutovalidateMode.disabled,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Estado Can\'t be empty';
                              }
                              return null;
                            },
                            controller: estadoController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: 'Enter your Estado',
                              hintStyle: TextFontStyle.headline5StyleInter
                                  .copyWith(color: AppColors.appColor9B9B9B),
                              labelText: 'Estado',
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
                      ],
                    ),
                    UIHelper.verticalSpaceSmall,
                    TextFormField(
                      autovalidateMode: validation
                          ? AutovalidateMode.always
                          : AutovalidateMode.disabled,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Cidade No Can\'t be empty';
                        }
                        return null;
                      },
                      controller: cidadeController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'Enter your Cidade',
                        hintStyle: TextFontStyle.headline5StyleInter
                            .copyWith(color: AppColors.appColor9B9B9B),
                        labelText: 'Cidade',
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
                    customeButton(
                      name: 'Continue',
                      height: .065.sh,
                      minWidth: double.infinity,
                      borderRadius: 5.r,
                      color: AppColors.inactiveColor,
                      textStyle: TextFontStyle.headline4StyleInter
                          .copyWith(color: AppColors.appColor4D3E39),
                      context: context,
                      onCallBack: () async {
                        if (_formKey.currentState!.validate()) {
                          if (widget.addressId != null) {
                            postUpdateAddressRXObj.postUpdateAdderss(
                              id: widget.addressId!,
                              address: addressController.text,
                              address_name: addressNameController.text,
                              lat:
                                  "38.91406396830108", //lastMapPosition.latitude.toString(),
                              long:
                                  "-8.89133546501398", //lastMapPosition.longitude.toString(),
                              postal_code: postalCodeController.text,
                              country: "Portugal", //placemarks!.first.country!,
                              city: cidadeController.text,
                              state: estadoController.text,
                              is_default: isDefault ? 1 : 0,
                            );
                          } else {
                            postAddressRXObj.postNewAdderss(
                              address: addressController.text,
                              address_name: addressNameController.text,
                              lat:
                                  "38.91406396830108", //lastMapPosition.latitude.toString(),
                              long:
                                  "-8.89133546501398", //lastMapPosition.longitude.toString(),
                              postal_code: postalCodeController.text,
                              country: "Portugal", //placemarks!.first.country!,
                              city: cidadeController.text,
                              state: estadoController.text,
                              is_default: isDefault ? 1 : 0,
                            );
                          }
                          setState(() {
                            validation = true;
                          });
                        }
                      },
                    ),
                    UIHelper.verticalSpaceSmall,
                  ],
                ),
              ),
            ),
            // ListView(
            //   padding: EdgeInsets.symmetric(horizontal: 13.w),
            //   shrinkWrap: true,
            //   physics: NeverScrollableScrollPhysics(),
            //   children: [
            //     UIHelper.verticalSpaceMedium,
            //     Text(
            //       'Morada/Rua',
            //       style: TextFontStyle.headline5StyleInter
            //           .copyWith(color: AppColors.appColorF4A4A4A),
            //     ),
            //     UIHelper.verticalSpaceSmall,
            //     Text(
            //       'Localização Atual',
            //       style: TextFontStyle.headline5StyleInter
            //           .copyWith(color: AppColors.appColor9B9B9B),
            //     ),
            //     UIHelper.verticalSpaceSmall,
            //     Divider(
            //       color: Colors.grey,
            //       thickness: 1,
            //     ),
            //     UIHelper.verticalSpaceMedium,
            //     Row(
            //       children: [
            //         Text(
            //           'Número da Porta',
            //           style: TextFontStyle.headline5StyleInter
            //               .copyWith(color: AppColors.appColorF4A4A4A),
            //         ),
            //         Spacer(),
            //         Text(
            //           'Andar',
            //           style: TextFontStyle.headline5StyleInter
            //               .copyWith(color: AppColors.appColorF4A4A4A),
            //         ),
            //       ],
            //     ),
            //     UIHelper.verticalSpaceMedium,
            //     Row(
            //       children: [
            //         Text(
            //           'Número',
            //           style: TextFontStyle.headline5StyleInter
            //               .copyWith(color: AppColors.appColor9B9B9B),
            //         ),
            //         Spacer(),
            //         Text(
            //           'Andar',
            //           textAlign: TextAlign.start,
            //           style: TextFontStyle.headline5StyleInter
            //               .copyWith(color: AppColors.appColor9B9B9B),
            //         ),
            //       ],
            //     ),
            //     UIHelper.verticalSpaceSmall,
            //     Divider(
            //       color: Colors.grey,
            //       thickness: 1,
            //     ),
            //     UIHelper.verticalSpaceMedium,
            //     Text(
            //       'Cidade',
            //       style: TextFontStyle.headline5StyleInter
            //           .copyWith(color: AppColors.appColor9B9B9B),
            //     ),
            //     UIHelper.verticalSpaceSmall,
            //     Text('Guimarães',
            //         style: TextFontStyle.headline5StyleInter
            //             .copyWith(color: AppColors.appColor9B9B9B)),
            //     Divider(
            //       color: Colors.grey,
            //       thickness: 1,
            //     ),
            //     UIHelper.verticalSpaceMedium,
            //     Text(
            //       'Adictionar Morada',
            //       style: TextStyle(
            //           color: AppColors.inactiveColor,
            //           decoration: TextDecoration.underline),
            //     ),
            //   ],
            // ),
            // UIHelper.verticalSpaceSmall,
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 13.w),
            //   child: customeButton(
            //     name: 'Continue',
            //     height: .065.sh,
            //     minWidth: double.infinity,
            //     borderRadius: 5.r,
            //     color: AppColors.inactiveColor,
            //     textStyle: TextFontStyle.headline4StyleInter
            //         .copyWith(color: AppColors.appColor4D3E39),
            //     context: context,
            //     onCallBack: () async {
            //       //  postAddressRXObj.postNewAdderss()
            //       // Future<void> onCameraIdle() async {
            //       //     Coordinates co =  mapController.getLatLng();
            //       //   final coordinates = new Coordinates(
            //       //       mapController.getLatLng, lastMapPosition.longitude);
            //       //   var addresses = await Geocoder.local
            //       //       .findAddressesFromCoordinates(coordinates);
            //       //   var first = addresses.first;

            //       //   first.addressLine;
            //       //   first.postalCode;
            //       //   first.locality;
            //       //   first.locality;
            //       //   first.countryName;
            //       // }
            //     },
            //   ),
            // ),
            // UIHelper.verticalSpaceSmall,
          ],
        ),
      ),
    );
  }
}
