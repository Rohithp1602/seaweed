import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:seaweed/api/api_exception.dart';
import 'package:seaweed/constant/app_string.dart';
import 'package:seaweed/constant/request_const.dart';
import 'package:seaweed/models/response_item.dart';

class BaseApiHelper {
  static Future<ResponseItem> postRequest(String requestUrl,
      Map<String, dynamic> requestData, bool passAuthToken) async {
    log("request:" + requestUrl);
    log("headers:" + requestHeader(passAuthToken).toString());
    log("body:" + json.encode(requestData));
    return await http
        .post(Uri.parse(requestUrl),
            body: json.encode(requestData),
            headers: requestHeader(passAuthToken))
        .then((response) => onValue(response))
        .onError((error, stackTrace) => onError(error));
  }

  static Future<ResponseItem> getRequest(String requestUrl) async {
    log("request:" + requestUrl);

    return await http
        .get(Uri.parse(requestUrl))
        .then((response) => baseOnValue(response))
        .onError((error, stackTrace) => onError(error));
  }

  static Future<ResponseItem> uploadFile(
    String requestUrl,
    http.MultipartFile? image,
    http.MultipartFile? video,
    Map<String, String> requestData,
  ) async {
    var request = http.MultipartRequest("POST", Uri.parse(requestUrl));

    if (image != null) request.files.add(image);
    if (video != null) request.files.add(video);

    request.headers.addAll(requestHeader(true));
    request.fields.addAll(requestData);

    log(request.toString(), name: "REQUEST");
    log(image?.field.toString() ?? "");
    log(video?.field.toString() ?? "");

    log("body:" + json.encode(requestData));
    return await request.send().then((streamedResponse) {
      return http.Response.fromStream(streamedResponse)
          .then((value) => onValue(value));
    }).onError((error, stackTrace) => onError(error));
  }

  static Future onValue(http.Response response) async {
    ResponseItem result;

    final ResponseItem responseData =
        ResponseItem.fromJson(json.decode(response.body));
    bool status = false;
    String message;
    dynamic data = responseData;

    log("responseCode: ${response.statusCode}", name: "response");
    if (response.statusCode == 200) {
      message = responseData.message;
      if (responseData.status) {
        status = true;
        data = responseData.data;
      } else {
        log("logout: ${responseData.forceLogout}", name: 'logout');
        if (responseData.forceLogout!) {
          // preferences.clearUserItem();
          // Get.offAllNamed(Routes.signIn);
        }
      }
    } else {
      log("response: $data");
      message = "Something went wrong.";
    }
    result = ResponseItem(
        data: data,
        message: message,
        status: status,
        newAuthToken: responseData.newAuthToken);
    log("response: {data: ${result.data}, message: $message, status: $status}",
        name: appName);
    log("message: ${result.message}", name: 'message');

    return result;
  }

  static Future baseOnValue(http.Response response) async {
    ResponseItem result;

    final Map<String, dynamic> responseData = json.decode(response.body);
    bool status = false;
    String message;
    dynamic data = responseData;

    log("responseCode: ${response.statusCode}");
    if (response.statusCode == 200) {
      message = "Ok";
      status = true;
      data = responseData;
    } else {
      log("response: $data", name: 'eroor');
      message = "Something went wrong.";
    }
    result = ResponseItem(data: data, message: message, status: status);
    log("response: {data: ${result.data}, message: $message, status: $status}",
        name: appName);
    return result;
  }

  static onError(error) {
    log("Error caused: " + error.toString());
    bool status = false;
    String message = "Unsuccessful request";
    if (error is SocketException) {
      message = ResponseException("No internet connection").toString();
    } else if (error is FormatException) {
      message = ResponseException("Something wrong in response.").toString() +
          error.toString();
    }
    return ResponseItem(data: null, message: message, status: status);
  }
}
