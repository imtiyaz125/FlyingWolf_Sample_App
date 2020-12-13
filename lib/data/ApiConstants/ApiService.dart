import 'dart:io';

import 'package:bluestack_assignment/Utility/AppConfig.dart';
import 'package:bluestack_assignment/data/ApiConstants/ApiEndPoints.dart';
import 'package:dio/dio.dart';
import '../NetworkUtility.dart';
import 'Interceptors.dart';

class ApiService {
  static ApiService _instance;

  factory ApiService() => _instance ??= ApiService._();

  ApiService._();

  Map<String, dynamic> authenticatedHeaders;
  Map<String, dynamic> headers;
  HeaderType headerType = HeaderType.anonymous;
  BaseOptions options;
  static const String USER_AGENT = "user-agent";
  static const _timeout = 30000;

  bool get isInDebugMode {
    return AppConfig.LOG_INTERCEPTORS_ENABLED;
  }

  Dio get dio => _dio();

  Dio _dio() {
    options = BaseOptions(
      baseUrl: ApiEndPoints.BASE_URL,
      connectTimeout: _timeout,
      receiveTimeout: _timeout,
    );
    if (headerType != HeaderType.authenticated)
      updateHeader(HeaderType.anonymous);
    options.validateStatus = (validate) {
      return true;
    };
    options.receiveDataWhenStatusError = true;
    var dio = Dio(options);

    dio.interceptors.add(requestInterceptor(dio));
    dio.interceptors.add(responseInterceptor(dio));
    dio.interceptors.add(userAgentInterceptor(dio));
    return dio;
  }

  updateContentType(ContentType type) {
    options.contentType = "application/json";
    updateHeader(HeaderType.authenticated);
  }

  updateBaseUrl(String baseUrl) {
    /*update your base url here if different user type has different base url*/
    options.baseUrl = baseUrl;
  }

  updateHeader(HeaderType type) {
    headerType = type;
    if (headerType == HeaderType.anonymous) {
      headers = {'Authorization': '', 'client_secret': ''};
    } else {
      /*update header as per your usecase */
      authenticatedHeaders = {'access-token': ''};
    }

    if (headerType == HeaderType.anonymous) {
      options.headers = headers;
    } else {
      options.headers = authenticatedHeaders;
    }
  }
}
