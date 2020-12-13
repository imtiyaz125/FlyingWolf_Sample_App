import 'package:bluestack_assignment/Utility/AppConfig.dart';
import 'package:dio/dio.dart';
import 'ApiService.dart';

InterceptorsWrapper requestInterceptor(Dio dio) => InterceptorsWrapper(
  onRequest: (RequestOptions options) {
    final uri = options.uri.toString();

    if(AppConfig.LOG_INTERCEPTORS_ENABLED) {
     print("Headers: ${options.headers}");
     print('URI --> $uri');
     print("Request: ${options.data}");
    }

    return options;
  },
);

InterceptorsWrapper responseInterceptor(Dio dio) => InterceptorsWrapper(
    onResponse: (Response response) {

      if(ApiService().isInDebugMode) {
        print("Response: $response");
        response?.headers?.forEach((k, v) {
          v.forEach((s) => print("$k , $s"));
        });
      }

      return response;
    }
);

InterceptorsWrapper userAgentInterceptor(Dio dio) => InterceptorsWrapper(
    onRequest: (RequestOptions options) async {
      options.headers.putIfAbsent(ApiService.USER_AGENT, () => "android.ios.flutter.fun");
      return options;
    }
);