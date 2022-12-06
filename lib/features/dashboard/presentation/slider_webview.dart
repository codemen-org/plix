import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:plix/constants/app_color.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../constants/app_constants.dart';

class SliderWebViewPage extends StatefulWidget {
  SliderWebViewPage({required this.url, required this.title});

  final String url;
  final String title;

  @override
  _SliderWebViewPageState createState() => _SliderWebViewPageState();
}

class _SliderWebViewPageState extends State<SliderWebViewPage> {
  WebViewController? _controller;
  int _stackToView = 1;

  void _handleLoad(String value) {
    setState(() {
      _stackToView = 0;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: AppColors.appColor4D3E39,
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
          brightness: Brightness.light,
          backgroundColor: AppColors.appColor4D3E39,
          elevation: 0.0,
          title: Text(
            widget.title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: IndexedStack(
            index: _stackToView,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Expanded(
                    child: WebView(
                      debuggingEnabled: true,
                      initialUrl: widget.url,
                      javascriptMode: JavascriptMode.unrestricted,
                      onPageFinished: _handleLoad,
                      onWebViewCreated: (WebViewController controller) {
                        _controller = controller;
                      },
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: Center(
                  child: Lottie.asset(AssetIcons.lottie_list_loading),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
