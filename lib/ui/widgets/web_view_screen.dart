import 'dart:io';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:seaweed/constant/app_string.dart';
import 'package:seaweed/theme/app_colors.dart';
import 'package:seaweed/ui/widgets/app_progress_view.dart';
import 'package:seaweed/utils/extension.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({Key? key, required this.url, required this.appbarText})
      : super(key: key);
  final String url;
  final String appbarText;

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back_rounded,
                color: appBlack,
                size: 30,
              )),
          backgroundColor: appWhite,
          title: widget.appbarText.appTextSifonn(
              color: appBlack, fontWeight: FontWeight.w700, size: 22),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: Stack(
          children: [
            WebView(
              onPageFinished: (finish) {
                setState(() {
                  isLoading = false;
                });
              },
              initialUrl: widget.url,
              javascriptMode: JavascriptMode.unrestricted,
            ),
            isLoading ? AppProgress() : SizedBox()
          ],
        ));
  }
}
