import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info/package_info.dart';
import 'package:device_info/device_info.dart';


final preferences = SharedPreference();

class SharedPreference {
  static SharedPreferences? _preferences;

  init() async {
    _preferences ??= await SharedPreferences.getInstance();
  }

  static const String isLoggedIn = "isLoggedIn";
  static const userEmail = "userEmail";
  static const userFullName = "userName";
  static const userProfileImage = "user_image";
  static const userToken = "user_token";

  static const appDeviceType = "App-Device-Type";
  static const appStoreVersion = "App-Store-Version";
  static const appDeviceModel = "App-Device-Model";
  static const appOsVersion = "App-Os-Version";
  static const appStoreBuildNumber = "App-Store-Build-Number";
  static const authToken = "Auth-Token";

  // saveUserItem(UserData userItem) {
  //   preferences.putBool(SharedPreference.isLoggedIn, true);
  //   _preferences!.setString(userFullName, userItem.data.userfullName);
  //   _preferences!.setString(userEmail, userItem.data.email);
  //   _preferences!.setString(userToken, userItem.data.userToken);
  //   _preferences!.setString(userProfileImage, userItem.data.userProfilePhoto);
  //   _preferences!.setString(authToken, userItem.data.authToken);
  //   _preferences!.setInt(isBetaTester, userItem.data.isBetaTester);
  // }

  // void clearUserItem() async {
  //   _preferences!.remove(isLoggedIn);
  //   _preferences!.remove(userFullName);
  //   _preferences!.remove(userEmail);
  //   _preferences!.remove(userToken);
  //   _preferences!.remove(userProfileImage);
  //   _preferences!.remove(authToken);
  // }

  putAppDeviceInfo() async {
    bool isiOS = Platform.isIOS;
    putString(appDeviceType, isiOS ? "iOS" : "android");
    var deviceInfo = await appDeviceInfo();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    if (isiOS) {
      IosDeviceInfo iosDeviceInfo = (deviceInfo as IosDeviceInfo);
      putString(appDeviceModel, iosDeviceInfo.model);
      putString(appOsVersion, "iOS ${iosDeviceInfo.systemVersion}");
    } else {
      AndroidDeviceInfo androidDeviceInfo = (deviceInfo as AndroidDeviceInfo);
      putString(appDeviceModel, androidDeviceInfo.model);
      putString(appOsVersion, androidDeviceInfo.version.release);
    }
    putString(appStoreVersion, packageInfo.version);
    putString(appStoreBuildNumber, packageInfo.buildNumber);
  }

  Future<dynamic> appDeviceInfo() async {
    return Platform.isIOS
        ? await DeviceInfoPlugin().iosInfo
        : await DeviceInfoPlugin().androidInfo;
  }

  Future<bool?> putString(String key, String value) async {
    return _preferences == null ? null : _preferences!.setString(key, value);
  }

  String? getString(String key, {String defValue = ""}) {
    return _preferences == null
        ? defValue
        : _preferences!.getString(key) ?? defValue;
  }

  Future<bool?> putInt(String key, int value) async {
    return _preferences == null ? null : _preferences!.setInt(key, value);
  }

  int? getInt(String key, {int defValue = 0}) {
    return _preferences == null
        ? defValue
        : _preferences!.getInt(key) ?? defValue;
  }

  Future<bool?> putBool(String key, bool value) async {
    return _preferences == null ? null : _preferences!.setBool(key, value);
  }

  bool? getBool(String key, {bool defValue = false}) {
    return _preferences == null
        ? defValue
        : _preferences!.getBool(key) ?? defValue;
  }
}
