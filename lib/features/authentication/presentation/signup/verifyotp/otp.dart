import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:plix/constants/app_color.dart';
import 'package:plix/provider/email.dart';
import 'package:provider/provider.dart';

import '../../../../../helpers/keyboard.dart';
import '../../../../../helpers/toast.dart';
import '../../../../../networks/api_acess.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({Key? key}) : super(key: key);
  @override
  _VerifyOtpPageState createState() => _VerifyOtpPageState();
}

class _VerifyOtpPageState extends State<VerifyOtpScreen> {
  TextEditingController _codeController0 = TextEditingController();
  TextEditingController _codeController1 = TextEditingController();
  TextEditingController _codeController2 = TextEditingController();
  TextEditingController _codeController3 = TextEditingController();
  bool isLoading = false;

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: AppColors.appColorEDBB43),
      borderRadius: BorderRadius.circular(2.0),
    );
  }

  Timer? _timer;
  int? _remainingSeconds;

  String twoDigits(int number) => number.toString().padLeft(2, "0");

  void startTimer() {
    _remainingSeconds = 120;
    if (_timer != null) {
      _timer!.cancel();
    }

    const oneSecond = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSecond,
      (Timer timer) => setState(
        () {
          if (_remainingSeconds! < 1) {
            timer.cancel();
          } else {
            _remainingSeconds = _remainingSeconds! - 1;
          }
        },
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    //  _codeController!.dispose();
    // _timer!.cancel();
  }

  @override
  void initState() {
    super.initState();
    //_codeController = TextEditingController();
    // startTimer();
  }

  @override
  Widget build(BuildContext context) {
    String email = Provider.of<EmailProvider>(context, listen: true).email;
    //Duration duration = Duration(seconds: _remainingSeconds!);
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: AppColors.appColorEDBB43,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: Text(
            "Verify Otp".tr,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          centerTitle: true,
        ),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
            ),
            SafeArea(
              child: isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 32.0,
                              left: 16.0,
                              right: 16.0,
                            ),
                            child: Card(
                              elevation: 2.0,
                              child: Column(
                                children: <Widget>[
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        top: 32.0,
                                        bottom: 16.0,
                                        left: 16.0,
                                        right: 16.0,
                                      ),
                                      child: Text(
                                        'verify provide otp'.tr,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 32.0,
                                        left: 16.0,
                                        right: 16.0,
                                      ),
                                      child: Text(
                                        "${"verify_otp_sent".tr} ${email}",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: AppColors.appColor9B9B9B,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Form(
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            SizedBox(
                                                height: 68,
                                                width: 64,
                                                child: TextFormField(
                                                  onChanged: (value) {
                                                    if (value.length == 1) {
                                                      FocusScope.of(context)
                                                          .nextFocus();
                                                    }
                                                  },
                                                  textAlign: TextAlign.center,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  controller: _codeController0,
                                                  inputFormatters: [
                                                    LengthLimitingTextInputFormatter(
                                                        1),
                                                    FilteringTextInputFormatter
                                                        .digitsOnly,
                                                  ],
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                  decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      filled: true,
                                                      hintStyle: TextStyle(
                                                          color:
                                                              Colors.grey[800]),
                                                      fillColor:
                                                          Colors.white70),
                                                )),
                                            SizedBox(
                                                height: 68,
                                                width: 64,
                                                child: TextFormField(
                                                  onChanged: (value) {
                                                    if (value.length == 1) {
                                                      FocusScope.of(context)
                                                          .nextFocus();
                                                    }
                                                  },
                                                  textAlign: TextAlign.center,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  controller: _codeController1,
                                                  inputFormatters: [
                                                    LengthLimitingTextInputFormatter(
                                                        1),
                                                    FilteringTextInputFormatter
                                                        .digitsOnly,
                                                  ],
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                  decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      filled: true,
                                                      hintStyle: TextStyle(
                                                          color:
                                                              Colors.grey[800]),
                                                      fillColor:
                                                          Colors.white70),
                                                )),
                                            SizedBox(
                                                height: 68,
                                                width: 64,
                                                child: TextFormField(
                                                  onChanged: (value) {
                                                    if (value.length == 1) {
                                                      FocusScope.of(context)
                                                          .nextFocus();
                                                    }
                                                  },
                                                  textAlign: TextAlign.center,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  controller: _codeController2,
                                                  inputFormatters: [
                                                    LengthLimitingTextInputFormatter(
                                                        1),
                                                    FilteringTextInputFormatter
                                                        .digitsOnly,
                                                  ],
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                  decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      filled: true,
                                                      hintStyle: TextStyle(
                                                          color:
                                                              Colors.grey[800]),
                                                      fillColor:
                                                          Colors.white70),
                                                )),
                                            SizedBox(
                                                height: 68,
                                                width: 64,
                                                child: TextFormField(
                                                  onChanged: (value) {
                                                    if (value.length == 1) {
                                                      FocusScope.of(context)
                                                          .nextFocus();
                                                    }
                                                  },
                                                  textAlign: TextAlign.center,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  controller: _codeController3,
                                                  inputFormatters: [
                                                    LengthLimitingTextInputFormatter(
                                                        1),
                                                    FilteringTextInputFormatter
                                                        .digitsOnly,
                                                  ],
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                  decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      filled: true,
                                                      hintStyle: TextStyle(
                                                          color:
                                                              Colors.grey[800]),
                                                      fillColor:
                                                          Colors.white70),
                                                )),
                                          ]),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 24.0,
                                  ),
                                  SizedBox(
                                    height: 32.0,
                                  ),
                                  buildButton(
                                    onPressCallback: () async {
                                      String otpCode =
                                          _codeController0.text.trim() +
                                              _codeController1.text.trim() +
                                              _codeController2.text.trim() +
                                              _codeController3.text.trim();
                                      await getVerifyOtpRXObj.verifyOtp(
                                          code: otpCode, email: email);
                                    },
                                    backgroundColor: AppColors.appColorEDBB43,
                                    title: 'Confirm'.tr,
                                  ),
                                  SizedBox(
                                    height: 32.0,
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 32.0,
                          ),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButton({
    VoidCallback? onPressCallback,
    Color? backgroundColor,
    String? title,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 48.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      onPressed: onPressCallback,
      child: Text(
        title!,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 16.0,
        ),
      ),
    );
  }

  // bool _validateUserData() {
  //   if (_codeController!.text.trim().isEmpty) {
  //     ToastUtil.showLongToast('please_fill_up_the_field'.tr);
  //     return false;
  //   } else {
  //     return true;
  //   }
  // }

  // void _checkAndVerifyOtp() async {
  //   if (_validateUserData()) {
  //     KeyboardUtil.hideKeyboard(context);
  //   }
  // }

  // void _resendOtp() async {
  //   KeyboardUtil.hideKeyboard(context);

  //   setState(() {
  //     isLoading = true;
  //   });
  // }
}
