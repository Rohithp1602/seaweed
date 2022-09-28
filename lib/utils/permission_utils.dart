import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';
import 'package:seaweed/ui/screens/main/map_screen/google_map_controller.dart';

class PermissionUtils {
  Future<Position> checkLocationPermission(
      GoogleMapScreenController googleMapScreenController) async {
    bool serviceEnabled;
    LocationPermission permission;
    loc.Location location = loc.Location();

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        googleMapScreenController.denied.value = true;
        googleMapScreenController.permanentlyDenied.value = true;
        return Future.error('Location services are disabled manually.');
      }
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      googleMapScreenController.denied.value = true;
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.dialog(
            AlertDialog(
              title: const Text("Permission Denied"),
              content: const Text(
                  "Without location permission application can not able to get current location. Are you sure, you want to deny location permission? Press 'Retry' for asking permission again."),
              titleTextStyle:
                  GoogleFonts.josefinSans(fontSize: 15, color: Colors.black),
              actions: [
                TextButton(
                    onPressed: () {
                      googleMapScreenController.permanentlyDenied.value = true;
                      Get.back();
                    },
                    child: Text(
                      "I'm sure",
                      style: GoogleFonts.josefinSans(color: Colors.black),
                    )),
                TextButton(
                    onPressed: () async {
                      Get.back();
                      permission = await Geolocator.requestPermission();
                      if (permission == LocationPermission.deniedForever) {
                        Get.dialog(AlertDialog(
                          title: const Text("Permission Denied"),
                          content: const Text(
                              "Location permission is denied permanently, please go to application's settings and allow."),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  openAppSettings().whenComplete(() {
                                    Future.delayed(const Duration(seconds: 5))
                                        .then((value) async {
                                      Get.back();
                                    });
                                  });
                                },
                                child: Text(
                                  "Go to setting",
                                  style: GoogleFonts.josefinSans(
                                      color: Colors.black),
                                ))
                          ],
                        ));
                        return Future.error(
                            'Location permissions are permanently denied, we cannot request permissions.');
                      }
                    },
                    child: Text(
                      "Retry",
                      style: GoogleFonts.josefinSans(color: Colors.black),
                    ))
              ],
            ),
            barrierDismissible: false);
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Get.dialog(
          AlertDialog(
            title: const Text("Permission Denied"),
            content: const Text(
                "Location permission is denied permanently, please go to application's settings and allow."),
            actions: [
              TextButton(
                  onPressed: () {
                    Get.back();
                    googleMapScreenController.isLoading.value = false;
                  },
                  child: Text(
                    "Cancel",
                    style: GoogleFonts.josefinSans(color: Colors.black),
                  )),
              TextButton(
                  onPressed: () {
                    openAppSettings().whenComplete(() {
                      Future.delayed(const Duration(seconds: 5))
                          .then((value) async {
                        Get.back();
                        googleMapScreenController.isLoading.value = false;
                      });
                    });
                  },
                  child: Text(
                    "Go to setting",
                    style: GoogleFonts.josefinSans(color: Colors.black),
                  ))
            ],
          ),
          barrierDismissible: false);
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    var accuracy = await Geolocator.getLocationAccuracy();
    if (accuracy == LocationAccuracyStatus.reduced) {
      return await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.lowest,
          timeLimit: const Duration(seconds: 5));
    }

    return await Geolocator.getCurrentPosition();
  }
}
