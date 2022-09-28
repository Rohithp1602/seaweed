import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seaweed/constant/app_string.dart';
import 'package:seaweed/theme/app_assets.dart';
import 'package:seaweed/theme/app_colors.dart';
import 'package:seaweed/ui/widgets/app_button.dart';
import 'package:seaweed/utils/extension.dart';
import 'package:seaweed/utils/route_manager.dart';

class LanguageSelecitonScreen extends StatelessWidget {
  LanguageSelecitonScreen({Key? key}) : super(key: key);

  final RxBool isSelected1 = false.obs;
  final RxBool isSelected2 = true.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appGrayBgColor,
      body: Stack(
        children: [
          Column(
            children: [
              (80.0).addHSpace(),
              Text(
                pleaseChooseYourPreferredText,
                maxLines: 2,
                style: appTextStyleSifonFont(
                    color: appColor, fontSize: 24, fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
              (40.0).addHSpace(),
              Row(
                children: [
                  Expanded(
                    child: Obx(() => InkWell(
                          onTap: () {
                            isSelected1.value = true;
                            isSelected2.value = false;
                          },
                          child: Container(
                            height: 165,
                            width: Get.width,
                            decoration: BoxDecoration(
                              color: appWhite,
                                border: Border.all(
                                    width: 2,
                                    color: isSelected1.value
                                        ? appColor
                                        : Colors.white),
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                Image.asset(
                                  ImageAsstes.img_gelige_laug,
                                  height: 80,
                                ).paddingOnly(top: 20, bottom: 15),
                                gaeilgeText.appTextSifonn(
                                    size: 24, color: appBlack)
                              ],
                            ),
                          ),
                        )),
                  ),
                  (20.0).addWSpace(),
                  Expanded(
                    child: Obx(() => InkWell(
                          onTap: () {
                            isSelected1.value = false;
                            isSelected2.value = true;
                          },
                          child: Container(
                            height: 165,
                            width: Get.width,
                            decoration: BoxDecoration(
                                color: appWhite,
                                border: Border.all(
                                    width: 2,
                                    color: isSelected2.value
                                        ? appColor
                                        : Colors.white),
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                Image.asset(
                                  ImageAsstes.img_english_laug,
                                  height: 80,
                                ).paddingOnly(top: 20, bottom: 15),
                                englishText.appTextSifonn(
                                    size: 24, color: appBlack)
                              ],
                            ),
                          ),
                        )),
                  ),
                ],
              ).paddingSymmetric(horizontal: 20),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: AppButton(
              textColor: appWhite,
              color: null,
              text: continueText,
              onTap: () {
                Get.toNamed(Routes.intro_screen);
              },
            ).paddingSymmetric(horizontal: 20),
          ).paddingOnly(bottom: 30)
        ],
      ),
    );
  }
}
