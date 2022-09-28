import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppProgress extends StatelessWidget {
  const AppProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: Get.height,
        color: Colors.white.withOpacity(0.5),
        child: Center(
            child: defaultTargetPlatform == TargetPlatform.iOS
                ? const CupertinoActivityIndicator()
                : const CircularProgressIndicator(
                    color: Colors.black,
                  )));
  }
}

class HomeProgress extends StatelessWidget {
  const HomeProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: Platform.isIOS ? 140 : 160, bottom: 0),
        width: double.infinity,
        height: Get.height,
        color: Colors.white.withOpacity(0.5),
        child: const Center(
            child: CircularProgressIndicator(
          color: Colors.black,
        )));
  }
}
