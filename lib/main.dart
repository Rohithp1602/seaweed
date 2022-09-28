import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:seaweed/ui/screens/main/map_screen/google_map_controller.dart';
import 'package:seaweed/ui/screens/startup/get_started_screen.dart';
import 'package:seaweed/utils/preferences.dart';
import 'package:seaweed/utils/route_manager.dart';

import 'ui/screens/main/audio_player_screen/audio_player_controller.dart';
import 'ui/screens/main/qr_code_scanner_screen/qr_code_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await preferences.init();
  await preferences.putAppDeviceInfo();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(Seaweed());
}

class Seaweed extends StatelessWidget {
  Seaweed({Key? key}) : super(key: key);
  AudioPlayerController audioPlayerController =
      Get.put(AudioPlayerController(), permanent: true);
  final GoogleMapScreenController ctrl =
      Get.put(GoogleMapScreenController(), permanent: true);
  final QrCodeController qrCodeController =
      Get.put(QrCodeController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: GetStartedScreen(),
      getPages: Routes.pages,
    );
  }
}
