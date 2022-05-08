part of 'controller.dart';

class PostController extends BaseController {
  String _getPathFromPost(IPost post) =>
      post is CampaignPost ? 'campaign' : 'emergency';

  //Helper class
  List<CampaignPost> _getCampaignPostsFromResponse(
      Map<String, dynamic> jsonResponse) {
    return (jsonResponse['data'] as List<dynamic>)
        .map((json) => CampaignPost.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  DetailCampaignPost _getCampaignPostFromResponse(Map<String, dynamic> jsonResponse) {
    return DetailCampaignPost.fromJson(jsonResponse['data'] as Map<String, dynamic>);
  }

  List<EmergencyPost> _getEmergencyPostsFromResponse(
      Map<String, dynamic> jsonResponse) {
    return (jsonResponse['data'] as List<dynamic>)
        .map((json) => EmergencyPost.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  DetailEmergencyPost _getEmergencyPostFromResponse(
      Map<String, dynamic> jsonResponse) {
    return DetailEmergencyPost.fromJson(jsonResponse['data'] as Map<String, dynamic>);
  }


  // Campaign
  Future<List<CampaignPost>> _getCampaigns(
      Map<String, dynamic> queryParams) async {
    try {
      var response = await dio.get(ServerUrl + '/campaign/select',
          queryParameters: queryParams);

      var jsonResponse = await _mapResponseToJson(response);

      return _getCampaignPostsFromResponse(jsonResponse);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List<CampaignPost>> GetCampaigns(
    int startIndex,
    int number,
  ) async {
    var queryParams = _getSearchQueryParams(startIndex, number);
    return _getCampaigns(queryParams);
  }

  Future<DetailCampaignPost> getCampaignPostById(int id) async {
    try {
      var response = await dio.get(ServerUrl + '/campaign/detail/id',
          queryParameters: {'key': id.toString()});

      var jsonResponse = await _mapResponseToJson(response);

      return _getCampaignPostFromResponse(jsonResponse);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List<CampaignPost>> GetCampaignsByUserId(
    int userId,
    int startIndex,
    int number,
  ) async {
    var queryParams = _getSearchQueryParams(startIndex, number)
      ..addEntries({'creatorId': userId}.entries);
    return _getCampaigns(queryParams);
  }

  Future<UserOverview> GetPaticipantsCampaign(int postId) async {
    throw Exception("Not implement");
  }

  //Emergency
  Future<List<EmergencyPost>> _getEmergencies(
      Map<String, dynamic> queryParams) async {
    try {
      var response = await dio.get(ServerUrl + '/emergency/select',
          queryParameters: queryParams);

      var jsonResponse = await _mapResponseToJson(response);

      return _getEmergencyPostsFromResponse(jsonResponse);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List<EmergencyPost>> GetEmergencies(
    int startIndex,
    int number,
  ) async {
    var queryParams = _getSearchQueryParams(startIndex, number);
    return _getEmergencies(queryParams);
  }

  Future<DetailEmergencyPost> getEmergencyPostById(int id) async {
    try {
      var response = await dio.get(ServerUrl + '/emergency/detail/id',
          queryParameters: {'key': id.toString()});

      var jsonResponse = await _mapResponseToJson(response);

      return _getEmergencyPostFromResponse(jsonResponse);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List<EmergencyPost>> GetEmergenciesByUserId(
    int userId,
    int startIndex,
    int number,
  ) async {
    var queryParams = _getSearchQueryParams(startIndex, number)
      ..addEntries({'creatorId': userId}.entries);
    return _getEmergencies(queryParams);
  }

  Future<bool> InsertPost(IPost post) async {
    Map<String, dynamic> data = post.toJson();

    if (post.imageUrl != null && !isImageURL(post.imageUrl!)) {
      data.addAll({'image': await MultipartFile.fromFile(post.imageUrl!)});
    }
    if (post.bannerUrl != null && !isImageURL(post.bannerUrl!)) {
      data.addAll({'banner': await MultipartFile.fromFile(post.bannerUrl!)});
    }

    var response = await dio.post(
      ServerUrl + '/${_getPathFromPost(post)}/insert',
      data: FormData.fromMap(data),
    );

    return _isResponseSuccess(response);
  }

  Future<bool> UpdatePost(String key, IPost post) async {
    var data = post.toJson();

    if (post.imageUrl != null && !isImageURL(post.bannerUrl!)) {
      data.addAll({'image': MultipartFile.fromFile(post.imageUrl!)});
    }
    if (post.bannerUrl != null && !isImageURL(post.bannerUrl!)) {
      data.addAll({'banner': MultipartFile.fromFile(post.bannerUrl!)});
    }

    var response = await dio.post(
      ServerUrl + '/${_getPathFromPost(post)}/update',
      data: FormData.fromMap(data),
    );
    return _isResponseSuccess(response);
  }

  Future<bool> DeletePost(String namePath, List<String> ids) async {
    var response =
        await dio.post(ServerUrl + '/$namePath/delete', data: {'keys': ids});
    return _isResponseSuccess(response);
  }
}
