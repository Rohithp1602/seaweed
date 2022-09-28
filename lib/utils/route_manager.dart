import 'package:get/get.dart';
import 'package:seaweed/ui/screens/main/audio_player_screen/audio_player_screen.dart';
import 'package:seaweed/ui/screens/main/home_screen.dart';
import 'package:seaweed/ui/screens/main/map_screen/map_screen.dart';
import 'package:seaweed/ui/screens/main/qr_code_scanner_screen/qr_code_scanner_screen.dart';
import 'package:seaweed/ui/screens/startup/get_started_screen.dart';
import 'package:seaweed/ui/screens/startup/intro_screen/intro_screen.dart';
import 'package:seaweed/ui/screens/startup/language_seleciton_screen.dart';

class Routes {
  //splash screen
  // static const String splash = "/";

  //startup pages
  // static const String signIn = "/sign_in";
  // static const String signUp = "/sign_up";
  // static const String forgotPassword = "/forgot_password";
  // static const String resetPasswordOtp = "/reset_password_otp";
  static const String getStartedScreen = "/get_started__screen";
  static const String language_screen = "/language_screen";
  static const String intro_screen = "/intro_screen";

  //main
  static const String homeScreen = "/home_screen";
  static const String mapScreen = "/map_screen";
  static const String qrCodeScannerScreen = "/qr_code_scanner_screen";
  static const String audioPlayerScreen = "/audio_player_screen";

  static List<GetPage> pages = [
    //splash screen
    // GetPage(name: splash, page: () => const SplashScreen()),

    // startup pages
    GetPage(name: getStartedScreen, page: () => GetStartedScreen()),
    GetPage(name: language_screen, page: () => LanguageSelecitonScreen()),
    GetPage(name: intro_screen, page: () => IntroScreen()),
    // GetPage(name: signIn, page: () => const SignInScreen()),
    // GetPage(name: signUp, page: () => SignUpScreen()),
    // GetPage(name: forgotPassword, page: () => ForgotPasswordScreen()),
    // GetPage(name: resetPasswordOtp, page: () => ResetPasswordOtp()),

    //main
    GetPage(name: homeScreen, page: () => HomeScreen()),
    GetPage(name: mapScreen, page: () => MapScreen()),
    GetPage(name: qrCodeScannerScreen, page: () => QrCodeScannerScreen()),
    GetPage(name: audioPlayerScreen, page: () => AudioPlayerScreen()),
  ];
}
