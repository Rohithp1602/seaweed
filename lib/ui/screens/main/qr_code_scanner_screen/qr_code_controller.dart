import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:seaweed/models/seaweed_data_model.dart';
import 'package:seaweed/ui/screens/main/audio_player_screen/audio_player_controller.dart';
import 'package:seaweed/ui/screens/main/map_screen/google_map_controller.dart';
import 'package:seaweed/utils/extension.dart';
import 'package:seaweed/utils/route_manager.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';


class QrCodeController extends GetxController {
  QRViewController? qrController;
  GoogleMapScreenController googleMapScreenController = Get.find();
  AudioPlayerController audioPlayerController = Get.find();
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void imageFromCamera() async {
    Permission.manageExternalStorage.request();
    var status = await Permission.camera.request();
    if (status.isGranted) {
      Get.toNamed(Routes.qrCodeScannerScreen);
    } else if (status.isDenied) {
      Get.showSnackbar(
        GetSnackBar(
            message:
                "Without this permission app can not change profile picture.",
            mainButton: Platform.isIOS
                ? SnackBarAction(
                    label: "Settings",
                    onPressed: () {
                      openAppSettings();
                    },
                  )
                : SnackBarAction(
                    label: "Settings",
                    onPressed: () {
                      openAppSettings();
                    },
                  ),
            duration: const Duration(seconds: 3)),
      );
      return;
    } else if (status.isPermanentlyDenied) {
      Get.showSnackbar(
        GetSnackBar(
            message:
                "To access this feature please grant permission from settings.",
            mainButton: SnackBarAction(
              label: "Settings",
              textColor: Colors.amber,
              onPressed: () {
                openAppSettings();
              },
            ),
            duration: const Duration(seconds: 3)),
      );
      return;
    }
  }

  void scanCode(String? code) async {
    isLoading.value = true;
    List<PostData> postList = googleMapScreenController.postList;
    var data = code?.split("-");
    if (data!.isNotEmpty) {
      if (postList.isNotEmpty) {
        for (var post in postList) {
          data.last;
          if (post.postId.toString() == data.last) {
            qrController!.pauseCamera();
            audioPlayerController.playAudio(postData: post);

            break;
          }
        }
      }
    } else {
      isLoading.value = false;
      showAppSnackBar("No Data found");
    }
    qrController!.resumeCamera();
    isLoading.value = false;
    update();
  }
}
