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

  DetailCampaignPost _getCampaignPostFromResponse(
      Map<String, dynamic> jsonResponse) {
    return DetailCampaignPost.fromJson(
        jsonResponse['data'] as Map<String, dynamic>);
  }

  List<EmergencyPost> _getEmergencyPostsFromResponse(
      Map<String, dynamic> jsonResponse) {
    return (jsonResponse['data'] as List<dynamic>)
        .map((json) => EmergencyPost.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  DetailEmergencyPost _getEmergencyPostFromResponse(
      Map<String, dynamic> jsonResponse) {
    return DetailEmergencyPost.fromJson(
        jsonResponse['data'] as Map<String, dynamic>);
  }

  // Campaign
  Future<List<CampaignPost>> _getCampaigns(
      Map<String, dynamic> queryParams) async {
    try {
      var response = await dio.get(ServerUrl + '/campaign/select',
          queryParameters: queryParams);

      var jsonResponse = await _mapResponseToJson(response);

      return _getCampaignPostsFromResponse(jsonResponse);
    } on TimeoutException catch (_) {
      return Future.error("Timeout when load getCampaigns");
    } catch (e) {
      return Future.error("Can not load getCampaigns");
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
    } on TimeoutException catch (_) {
      return Future.error("Timeout when load getCampaignPostById");
    } catch (e) {
      return Future.error("Can not load getCampaignPostById");
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
    } on TimeoutException catch (_) {
      return Future.error("Timeout when load getEmergencies");
    } catch (e) {
      return Future.error("Can not load getEmergencies");
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
    } on TimeoutException catch (_) {
      return Future.error("Timeout when load getEmergencyPostById");
    } catch (e) {
      return Future.error("Can not load getEmergencyPostById");
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

  Future<MyResponse> InsertPost(IPost post) async {
    Map<String, dynamic> data = post.toJson();

    if (post.imageUrl != null && !isImageURL(post.imageUrl!)) {
      data.addAll({'image': await MultipartFile.fromFile(post.imageUrl!)});
    }
    if (post.bannerUrl != null && !isImageURL(post.bannerUrl!)) {
      data.addAll({'banner': await MultipartFile.fromFile(post.bannerUrl!)});
    }

    data.remove('id');
    data.remove('creator');
    data.remove('imageURI');
    data.remove('bannerURI');

    var response = await myAPIWrapper.postWithAuth(
      ServerUrl + '/${_getPathFromPost(post)}/insert',
      data: FormData.fromMap(data),
    );

    return response;
  }

  Future<bool> InviteUserToCampaign(int campaignId, List<int> ids) async {
    var response = await myAPIWrapper.postWithAuth(
        ServerUrl + '/campaign/inviteuser',
        data: {'campaignId': campaignId, 'userIds': ids});
    return response.errorCode == null;
  }

  Future<bool> UpdatePost(int key, IPost post) async {
    var data = post.toJson();

    if (post.imageUrl != null && !isImageURL(post.bannerUrl!)) {
      data.addAll({'image': MultipartFile.fromFile(post.imageUrl!)});
    }
    if (post.bannerUrl != null && !isImageURL(post.bannerUrl!)) {
      data.addAll({'banner': MultipartFile.fromFile(post.bannerUrl!)});
    }

    data.remove('id');
    data.remove('creator');
    data.remove('imageURI');
    data.remove('bannerURI');
    data.remove('createdAt');
    data.addEntries({'key': key}.entries);

    var response = await myAPIWrapper.postWithAuth(
      ServerUrl + '/${_getPathFromPost(post)}/update',
      data: FormData.fromMap(data),
    );
    return response.errorCode == null;
  }

  Future<bool> DeletePost(String namePath, List<int> ids) async {
    var response =
        await myAPIWrapper.postWithAuth(ServerUrl + '/$namePath/delete', data: {'keys': ids});
    return response.errorCode == null;
  }

  Future<bool> FinishPost(
      String namePath, int id, List<int> doneIds, List<int> absentIds) async {
    var data = {
      'campaignId': id,
      'doneIds': doneIds,
      'absentIds': absentIds,
    };
    var response = await myAPIWrapper
        .postWithAuth(ServerUrl + '/$namePath/finish', data: data);
    return response.errorCode == null;
  }
}
