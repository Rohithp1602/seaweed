import 'package:seaweed/utils/preferences.dart';

class AppUrls {
  static const String liveBaseURL =
      "http://codonnier.tech/ghanshyam/seaweed/dev";

  /// Create request with query parameter
  static const String baseUrl = liveBaseURL + "/Service.php?";

  static const String audioFilePath =
      "http://codonnier.tech/ghanshyam/seaweed/app_images/post_audio/";
}

class MethodNames {
  //startup
  static const updateDeviceToken = "updateDeviceToken";

  //map get post list
  static const getAllPostList = "getAllPostList";
}

class RequestParam {
  static const service = "Service"; // -> pass method name
  static const showError = "show_error"; // -> bool in String
}

class RequestHeaderKey {
  static const contentType = "Content-Type";
  static const appSecret = "App-Secret";
  static const appTrackVersion = "App-Track-Version";
  static const appDeviceType = "App-Device-Type";
  static const appStoreVersion = "App-Store-Version";
  static const appDeviceModel = "App-Device-Model";
  static const appOsVersion = "App-Os-Version";
  static const appStoreBuildNumber = "App-Store-Build-Number";
  static const authToken = "Auth-Token";
}

Map<String, String> requestHeader(bool passAuthToken) {
  return {
    RequestHeaderKey.contentType: "application/json",
    RequestHeaderKey.appSecret: 'SEAWEED25481#\$@',
    RequestHeaderKey.appTrackVersion: "v1",
    RequestHeaderKey.appDeviceType:
        preferences.getString(SharedPreference.appDeviceType) ?? '',
    RequestHeaderKey.appStoreVersion:
        preferences.getString(SharedPreference.appStoreVersion) ?? '',
    RequestHeaderKey.appDeviceModel:
        preferences.getString(SharedPreference.appDeviceModel) ?? '',
    RequestHeaderKey.appOsVersion:
        preferences.getString(SharedPreference.appOsVersion) ?? '',
    RequestHeaderKey.appStoreBuildNumber:
        preferences.getString(SharedPreference.appStoreBuildNumber) ?? '',
    if (passAuthToken)
      RequestHeaderKey.authToken:
          preferences.getString(SharedPreference.authToken) ?? '',
  };
}
