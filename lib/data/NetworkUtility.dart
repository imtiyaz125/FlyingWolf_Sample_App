import 'package:bluestack_assignment/Utility/AppConfig.dart';
import 'package:bluestack_assignment/data/ApiConstants/ApiEndPoints.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class NetworkUtility {
  static NetworkUtility networkUtility;
  Map<String, dynamic> authenticatedHeaders;
  Map<String, dynamic> headers;

  String baseUrl = ApiEndPoints.BASE_URL;
  BaseOptions options;

  Dio dio;

  updateTokenInHeader(String authorization) {
    authenticatedHeaders["access-token"] = "$authorization";
  }

  NetworkUtility({HeaderType headerType = HeaderType.anonymous}) {
    // Create Dio Object using baseOptions set receiveTimeout,connectTimeout
    fetchHeader(headerType: headerType);
    debugPrint(headers.toString());
    initNetworkUtils(headerType: headerType);
  }

  fetchHeader({HeaderType headerType = HeaderType.anonymous}) {
    if (headerType == HeaderType.anonymous) {
      /*ADD DEFAULTS PARAMS*/
       headers = {
        'Authorization': '',
        'client_secret': ''
      };
    } else {
          authenticatedHeaders = {'access-token': ''/*YOUR AUTH TOKEN*/};
    }
  }




  void initNetworkUtils({HeaderType headerType = HeaderType.anonymous}) {
    fetchHeader(headerType: headerType);
    debugPrint(headers.toString());
    options = BaseOptions(receiveTimeout: 10000, connectTimeout: 10000);
    options.baseUrl = baseUrl;
    options.receiveDataWhenStatusError = true;
    if (headerType == HeaderType.anonymous){
      options.headers = headers;
    } else {
      options.headers = authenticatedHeaders;
    }
    options.validateStatus = (validate) {
      return true;
    };
    print("Current Base Url :: $baseUrl");
    print("Headers :: ${options.headers}");

    dio = Dio(options);

    if (AppConfig.LOG_INTERCEPTORS_ENABLED)
      dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  }

  ///used for calling Get Request
  Future<Response> get(String url, Map<String, dynamic> params, {String baseURL = ApiEndPoints.BASE_URL}) async {
    options.baseUrl = baseURL;
    Response response;
    if (params != null)
      response = await dio.get(url,
          queryParameters: params,
          options: Options(responseType: ResponseType.json));
    else {
      response = await dio.get(url, options: Options(responseType: ResponseType.json));
    }
    return response;
  }

}
enum HeaderType {
  authenticated, anonymous
}