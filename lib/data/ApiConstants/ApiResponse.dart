import 'package:dio/dio.dart';

class ApiResponse<T> {

  int code;
  T body;
  bool successful = false;
  DioError error;

  ApiResponse.success(Response<T> response){
    code = response?.statusCode ?? 0;
    body = response?.data ?? "";
    successful = true;
  }

  ApiResponse.failure(DioError e, { String message = "" }) {
    successful = false;
    error = e;
    code = e.response.statusCode;
    print("Error ${e?.toString()}");
  }
}