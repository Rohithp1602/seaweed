import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:seaweed/constant/app_string.dart';
import 'package:seaweed/theme/app_colors.dart';
import 'package:seaweed/ui/screens/main/map_screen/google_map_controller.dart';
import 'package:seaweed/ui/widgets/app_progress_view.dart';
import 'package:seaweed/utils/extension.dart';

class MapScreen extends StatelessWidget {
  MapScreen({Key? key}) : super(key: key);
  // final GoogleMapScreenController googleScreenMapController =
  //     Get.put(GoogleMapScreenController());

  final GoogleMapScreenController googleScreenMapController =
      Get.find<GoogleMapScreenController>();

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
          title: mapText.appTextSifonn(
              color: appBlack, fontWeight: FontWeight.w700, size: 22),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: Stack(
          children: [
            GetBuilder<GoogleMapScreenController>(initState: (ctrlState) {
              googleScreenMapController.onPermissionGranted();
            }, builder: (ctrl) {
              return GoogleMap(
                myLocationEnabled: true,
                markers: Set.of(ctrl.marker),
                onMapCreated: (GoogleMapController controller) {
                  googleScreenMapController.mapController = controller;
                  googleScreenMapController.update();
                },
                initialCameraPosition:
                    CameraPosition(target: LatLng(myLat, myLon), zoom: 15),
              );
            }),
            Obx(() => googleScreenMapController.isLoading.value
                ? const AppProgress()
                : Container()),
          ],
        ));
  }
}
