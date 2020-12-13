import 'package:bluestack_assignment/data/ApiConstants/ApiEndPoints.dart';
import 'package:bluestack_assignment/data/ApiConstants/ApiResponse.dart';
import 'package:bluestack_assignment/data/ApiConstants/ApiService.dart';
import 'package:bluestack_assignment/data/Models/request/RecommendedRequest.dart';
import 'package:meta/meta.dart';

class HomeProvider  {
  HomeProvider({@required this.api});

  ApiService api;

  Future<ApiResponse> getRecommendedData(RecommendedRequest request) async {
    try {
      final _dio = api.dio;
      api.updateBaseUrl(ApiEndPoints.BASE_URL);
      final response = await _dio.get(ApiEndPoints.GET_RECOMMENDED_LIST,queryParameters: request.toMap());
      return ApiResponse.success(response);
    } catch (e) {
      return ApiResponse.failure(e, message: "Failed to fetch recommendation");
    }
  }

  Future<ApiResponse> getMyProfile() async {
    try {
      final _dio = api.dio;
      api.updateBaseUrl(ApiEndPoints.MOCK_BASE_URL);
      final response = await _dio.get(ApiEndPoints.GET_PROFILE);
      return ApiResponse.success(response);
    } catch (e) {
      return ApiResponse.failure(e, message: "Failed to fetch profile data");
    }
  }

}
