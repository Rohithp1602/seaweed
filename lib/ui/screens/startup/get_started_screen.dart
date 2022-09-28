import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seaweed/constant/app_string.dart';
import 'package:seaweed/theme/app_assets.dart';
import 'package:seaweed/theme/app_colors.dart';
import 'package:seaweed/ui/widgets/app_button.dart';
import 'package:seaweed/utils/route_manager.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appGrayBgColor,
      body: Stack(
        children: [
          Image.asset(
            ImageAsstes.img_getStarted,
            height: Get.height,
            width: Get.width,
            fit: BoxFit.fill,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: AppButton(
              textColor: appWhite,
              height: 60,
              color: appColor,
              text: getStartedText,
              onTap: () {
                Get.toNamed(Routes.language_screen);
              },
            ).paddingSymmetric(horizontal: 100),
          ).paddingOnly(bottom: 30)
        ],
      ),
    );
  }
}
