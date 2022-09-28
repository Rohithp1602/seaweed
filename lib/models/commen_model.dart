import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seaweed/constant/app_string.dart';
import 'package:seaweed/theme/app_assets.dart';
import 'package:seaweed/ui/screens/main/map_screen/google_map_controller.dart';
import 'package:seaweed/ui/screens/main/qr_code_scanner_screen/qr_code_controller.dart';
import 'package:seaweed/ui/widgets/web_view_screen.dart';
import 'package:seaweed/utils/extension.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class IntroModel {
  String icText;
  String text;

  IntroModel({required this.icText, required this.text});
}

class HomeMenuItem {
  String icText;
  String text;
  GestureTapCallback onTap;

  HomeMenuItem({required this.icText, required this.text, required this.onTap});
}

List<HomeMenuItem> homeMenuList = [
  HomeMenuItem(
    icText: ImageAsstes.img_location_intro,
    text: findASingPostText,
    onTap: () async {
      GoogleMapScreenController ctrl = Get.find<GoogleMapScreenController>();
      ctrl.onPermissionGranted();
    },
  ),
  HomeMenuItem(
    icText: ImageIcons.ic_home_qr,
    text: openTheQrText,
    onTap: () {
      internetCheck();
    },
  ),
  HomeMenuItem(
    icText: ImageIcons.ic_home_bath,
    text: bookASeaweedBathText,
    onTap: () {
      Get.to(const WebViewScreen(
        url: 'https://fareharbor.com/embeds/book/theseaweedcentre/items/?flow=791001&full-items=yes&back=https://www-theseaweedcentre-com.filesusr.com/html/6a1302_0d8ae3e2eb7688ddf55fd648dbfda169.html',
        appbarText: bookASeaweedBathText,
      ));
    },
  ),
  HomeMenuItem(
    icText: ImageIcons.ic_home_tree,
    text: bookASeaweedCenterExperText,
    onTap: () {
      Get.to(const WebViewScreen(
        url: 'https://www.theseaweedcentre.com/',
        appbarText: bookASeaweedCenterExperText,
      ));
    },
  ),
];

internetCheck() async {
  GoogleMapScreenController ctrl = Get.find<GoogleMapScreenController>();
  QrCodeController qrctrl = Get.find();
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    ctrl.getPostData();
    qrctrl.imageFromCamera();
  } else if (connectivityResult == ConnectivityResult.wifi) {
    ctrl.getPostData();
    qrctrl.imageFromCamera();
  } else {
    showAppSnackBar("No internet connection");
  }
}
