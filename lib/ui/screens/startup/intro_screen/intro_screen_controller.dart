import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seaweed/constant/app_string.dart';
import 'package:seaweed/models/commen_model.dart';
import 'package:seaweed/theme/app_assets.dart';
import 'package:seaweed/utils/route_manager.dart';

class IntroScreenController extends GetxController {
  final pageController = PageController(initialPage: 0);
  final pageController1 = PageController(initialPage: 0);
  final pageController2 = PageController(initialPage: 0);
  int currentIndex = 0;

  List<String> imageList = [
    ImageAsstes.img_map_intro,
    ImageAsstes.img_qr_intro,
    ImageAsstes.img_location_intro,
  ];
  List<IntroModel> introList = [
    IntroModel(icText: ImageIcons.ic_marker_intro, text: findNearestPost),
    IntroModel(icText: ImageIcons.ic_qr_intro, text: scanQrCode),
    IntroModel(icText: ImageIcons.ic_troue_intro, text: enjoyTheTour),
  ];
  List<String> introTextList = [
    enjoyTheTourAndDontForgotToCallText,
    enjoyTheHistoryTheHeritagText,
    enjoyTheHistoryTheHeritagText
  ];

  onChahged(int index) {
    currentIndex = index;
    update();
  }

  void nextPage() {
    pageController.animateToPage(pageController.page!.toInt() + 1,
        duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
    if (pageController.page!.toInt() >= 2) {
      Get.offAllNamed(Routes.homeScreen);
    }
  }

  void nextPage1() {
    pageController1.animateToPage(pageController.page!.toInt() + 1,
        duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
    if (pageController.page!.toInt() >= 2) {
      Get.offAllNamed(Routes.homeScreen);
    }
  }

  void nextPage2() {
    pageController2.animateToPage(pageController.page!.toInt() + 1,
        duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
    if (pageController.page!.toInt() >= 2) {
      Get.offAllNamed(Routes.homeScreen);
    }
  }

  void previousPage() {
    pageController.animateToPage(pageController.page!.toInt() - 1,
        duration: const Duration(milliseconds: 100), curve: Curves.easeIn);
  }

  void previousPage1() {
    pageController1.animateToPage(pageController.page!.toInt() - 1,
        duration: const Duration(milliseconds: 100), curve: Curves.easeIn);
  }

  void previousPage2() {
    pageController2.animateToPage(pageController.page!.toInt() - 1,
        duration: const Duration(milliseconds: 100), curve: Curves.easeIn);
  }
}
