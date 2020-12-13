import 'package:bluestack_assignment/Utility/StringConstants.dart';
import 'package:bluestack_assignment/data/Models/request/RecommendedRequest.dart';
import 'package:bluestack_assignment/data/Models/response/ProfileResponse.dart';
import 'package:bluestack_assignment/data/Models/response/RecommendedResponse.dart';
import 'package:bluestack_assignment/data/Providers/HomeProvider.dart';
import 'package:meta/meta.dart';

class HomeRepository {
  HomeRepository({@required this.provider});

  final HomeProvider provider;

  Future<RecommendedResponse> getRemmendedData(RecommendedRequest request) async {
    final response = await provider.getRecommendedData(request);
    if (response.successful) {
      return RecommendedResponse.fromJson(response.body);
    } else {
      return RecommendedResponse(message: StringConstants.GENERAL_NETWOR_ERROR_MESSAGE,code: response.code,success: false);
    }
  }
  Future<ProfileResponse> getMyProfile() async {
    final response = await provider.getMyProfile();
    if (response.successful) {
      return ProfileResponse.fromJson(response.body);
    } else {
      return ProfileResponse(message: StringConstants.GENERAL_NETWOR_ERROR_MESSAGE,code: response.code,success: false);
    }
  }

}
