import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_view_sliding_indicator/page_view_sliding_indicator.dart';
import 'package:seaweed/constant/app_string.dart';
import 'package:seaweed/theme/app_assets.dart';
import 'package:seaweed/theme/app_colors.dart';
import 'package:seaweed/ui/screens/startup/intro_screen/intro_screen_controller.dart';
import 'package:seaweed/utils/extension.dart';
import 'package:seaweed/utils/route_manager.dart';

class IntroScreen extends StatelessWidget {
  IntroScreen({Key? key}) : super(key: key);

  final IntroScreenController introScreenController =
      Get.put(IntroScreenController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<IntroScreenController>(builder: (ctrl) {
      return Scaffold(
        backgroundColor: appGrayBgColor,
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (20.0).addHSpace(),
                Stack(
                  children: [
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Image.asset(
                            ImageAsstes.img_tree1,
                            height: Get.height * 0.27,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Image.asset(
                            ImageAsstes.img_tree2,
                            height: Get.height * 0.309,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: Get.height / 2.5,
                      width: Get.width,
                      decoration: BoxDecoration(
                          border: Border.all(width: 12, color: appColor),
                          color: ctrl.currentIndex == 2 ? appColor : appWhite,
                          borderRadius: BorderRadius.circular(12)),
                      child: PageView.builder(
                        onPageChanged: ctrl.onChahged,
                        physics: const NeverScrollableScrollPhysics(),
                        controller: ctrl.pageController,
                        itemCount: ctrl.imageList.length,
                        itemBuilder: (context, index) {
                          return Image.asset(ctrl.imageList[index]);
                        },
                      ),
                    ).paddingSymmetric(horizontal: 50, vertical: 70)
                  ],
                ),
                Expanded(
                  child: Container(
                    height: Get.height,
                    width: Get.width,
                    decoration: BoxDecoration(
                        color: appColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    child: Column(
                      children: [
                        (Get.height * 0.04).addHSpace(),
                        Container(
                          height: Get.height * 0.10,
                          child: PageView.builder(
                            onPageChanged: ctrl.onChahged,
                            physics: const NeverScrollableScrollPhysics(),
                            controller: ctrl.pageController1,
                            itemCount: ctrl.introList.length,
                            itemBuilder: (context, index) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    ctrl.introList[index].icText,
                                    height: 30,
                                    width: 30,
                                  ),
                                  (10.0).addWSpace(),
                                  Text(
                                    ctrl.introList[index].text,
                                    style: appTextStyleSifonFont(
                                        color: appColor,
                                        fontSize: Get.height * 0.024,
                                        fontWeight: FontWeight.w700),
                                  )
                                ],
                              );
                            },
                          ),
                          decoration: BoxDecoration(
                              color: appWhite,
                              borderRadius: BorderRadius.circular(10)),
                        ).paddingOnly(left: 20, right: 20),
                        (Get.height * 0.04).addHSpace(),
                        Container(
                          height: Get.height * 0.09,
                          child: PageView.builder(
                            onPageChanged: ctrl.onChahged,
                            physics: const NeverScrollableScrollPhysics(),
                            controller: ctrl.pageController2,
                            itemCount: ctrl.introTextList.length,
                            itemBuilder: (context, index) {
                              return Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  ctrl.introTextList[index],
                                  textAlign: TextAlign.center,
                                  maxLines: 3,
                                  style: appTextStyleOpenSensFont(
                                      color: appWhite,
                                      fontSize: Get.height * 0.020,
                                      fontWeight: FontWeight.w600),
                                ),
                              ).paddingSymmetric(horizontal: 20);
                            },
                          ),
                        ),
                        (Get.height * 0.035).addHSpace(),
                        Container(
                          height: Get.height * 0.050,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  ctrl.previousPage();
                                  ctrl.previousPage1();
                                  ctrl.previousPage2();
                                },
                                child: ctrl.currentIndex == 0
                                    ? Image.asset(
                                        ImageIcons.ic_intro_left_black)
                                    : Image.asset(ImageIcons.ic_intro_left),
                              ),
                              PageViewSlidingIndicator(
                                color: appWhite,
                                pageCount: 3,
                                borderRadius: 5,
                                controller: ctrl.pageController,
                                size: 8,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: InkWell(
                                  onTap: () {
                                    ctrl.nextPage();
                                    ctrl.nextPage1();
                                    ctrl.nextPage2();
                                  },
                                  child: Image.asset(ImageIcons.ic_intro_right),
                                ),
                              )
                            ],
                          ),
                        ).paddingSymmetric(horizontal: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                  onPressed: () {
                    Get.offAllNamed(Routes.homeScreen);
                  },
                  child: Text(
                    skipText,
                    style: appTextStyleSifonFont(
                        color: appColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  )),
            ).paddingOnly(top: 40, right: 5),
          ],
        ),
      );
    });
  }
}
