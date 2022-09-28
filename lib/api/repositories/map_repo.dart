import 'package:seaweed/api/api_helpers.dart';
import 'package:seaweed/constant/request_const.dart';
import 'package:seaweed/models/response_item.dart';

class MapRepo {
  Future<ResponseItem> getPostList(
    double latitude,
    double longitude,
  ) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = "";

    var params = {"latitude": latitude, "longitude": longitude};

    var queryParameters = {RequestParam.service: MethodNames.getAllPostList};
    String queryString = Uri(queryParameters: queryParameters).query;
    String requestUrl = AppUrls.baseUrl + queryString;

    result = await BaseApiHelper.postRequest(requestUrl, params, false);
    status = result.status;
    data = result.data;
    message = result.message;

    return ResponseItem(data: data, message: message, status: status);
  }
}
