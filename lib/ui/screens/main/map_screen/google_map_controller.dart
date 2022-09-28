import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:seaweed/api/repositories/map_repo.dart';
import 'package:seaweed/constant/app_string.dart';
import 'package:seaweed/models/response_item.dart';
import 'package:seaweed/models/seaweed_data_model.dart';
import 'package:seaweed/ui/screens/main/audio_player_screen/audio_player_controller.dart';
import 'package:seaweed/utils/extension.dart';
import 'package:seaweed/utils/permission_utils.dart';
import 'package:seaweed/utils/route_manager.dart';

class GoogleMapScreenController extends GetxController {
  List<PostData> postList = [];
  MapRepo mapRepo = MapRepo();
  RxBool loader = false.obs;
  AudioPlayerController audioPlayerController =
      Get.find<AudioPlayerController>();
  RxBool isLoading = false.obs;
  List<Marker> marker = [];
  RxBool denied = false.obs;
  RxBool permanentlyDenied = false.obs;
  LatLng latlang = LatLng(myLat, myLon);

  late GoogleMapController mapController;

  final LatLng center = const LatLng(45.521563, -122.677433);

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void onInit() {
    super.onInit();
    // onPermissionGranted();
  }

  getPostData() async {
    isLoading.value = true;
    Position position = await PermissionUtils().checkLocationPermission(this);
    try {
      myLat = position.latitude;
      myLon = position.longitude;
      print("lat!***** : ${myLat}");
      print("lon!***** : ${myLon}");
      latlang = LatLng(myLat, myLon);
      getPostList();
      denied.value = false;
      permanentlyDenied.value = false;
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      print(e);
    }
    isLoading.value = false;
    update();
  }

  onPermissionGranted() async {
    isLoading.value = true;
    Position position = await PermissionUtils().checkLocationPermission(this);

    try {
      myLat = position.latitude;
      myLon = position.longitude;
      print("lat!***** : ${myLat}");
      print("lon!***** : ${myLon}");
      latlang = LatLng(myLat, myLon);
      getPostList();
      denied.value = false;
      permanentlyDenied.value = false;
      Get.toNamed(Routes.mapScreen);
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      print(e);
    }
    isLoading.value = false;
    update();
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  void getPostList({bool isClear = false}) async {
    if (isClear) {
      postList.clear();
    }
    ResponseItem result = await mapRepo.getPostList(myLat, myLon);
    try {
      if (result.status) {
        if (result.data != null) {
          if ((result.data as List).isNotEmpty) {
            SeaweedPostModel data = SeaweedPostModel.fromJson(result.toJson());
            if (postList.isEmpty) {
              postList = data.data;
              print("Data Call Sucessfully");
              customeMarker();
              isLoading.value = false;
            } else {
              postList.addAll(data.data);
            }
          }
        }
      } else {
        showAppSnackBar(result.message);
      }
    } catch (e) {
      showAppSnackBar(errorText);
    }
    isLoading.value = false;
    update();
  }

  customeMarker() async {
    final Uint8List markerIcon =
        await getBytesFromAsset('assets/icons/ic_map_marker.png', 60);
    final bitmapIcon = await BitmapDescriptor.fromBytes(markerIcon);
    List<Marker> markerList = [];
    if (postList.isNotEmpty) {
      postList.forEach((post) {
        markerList.add(
          Marker(
              icon: bitmapIcon,
              markerId: MarkerId(post.postId.toString()),
              position: LatLng(post.latitude, post.longitude),
              infoWindow: InfoWindow(
                onTap: () {
                  // Get.toNamed(Routes.audioPlayerScreen, arguments: post);
                  audioPlayerController.playAudio(postData: post);
                },
                title: post.name,
              )),
        );
      });
    } else {
      showAppSnackBar("post list empty");
    }
    isLoading.value = false;
    marker.addAll(markerList);
    isLoading.value = false;
    update();
  }
}
