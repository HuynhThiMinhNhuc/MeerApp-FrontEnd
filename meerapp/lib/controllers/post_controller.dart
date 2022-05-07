import 'dart:convert';
import 'dart:developer';

import 'package:meerapp/config/constant.dart';
import 'package:meerapp/config/helper.dart';
import 'package:meerapp/present/models/post.dart';
import 'package:meerapp/present/models/user.dart';
import 'package:http/http.dart' as http;

class PostController {
  //Helper class
  List<CampaignPost> _getCampaignPostsFromResponse(
      Map<String, dynamic> jsonResponse) {
    return (jsonResponse['data'] as List<dynamic>)
        .map((json) => CampaignPost.fromJson(json as Map<String,dynamic>))
        .toList();
  }

  List<EmergencyPost> _getEmergencyPostsFromResponse(
      Map<String, dynamic> jsonResponse) {
    return (jsonResponse['data'] as List<Map<String, dynamic>>)
        .map((json) => EmergencyPost.fromJson(json))
        .toList();
  }

  Future<String> _getBody(http.BaseResponse response) async {
    if (response is http.Response)
      return response.body;
    else if (response is http.StreamedResponse)
      return response.stream.bytesToString();
    throw Exception("Wrong type");
  }

  Future<Map<String, dynamic>> _transferToJson(
      http.BaseResponse response) async {
    var jsonResponse =
        jsonDecode(await _getBody(response)) as Map<String, dynamic>;
    // Check if response is success
    if (response.statusCode != 200 || jsonResponse['result'] != true) {
      throw Exception("Not get correct response");
    }
    return jsonResponse;
  }

  Map<String, dynamic> _getSearchQueryParams(int startIndex, int number) {
    var queryParams = <String, dynamic>{
      'searchby': 'title',
      // 'searchvalue': '',
      'orderby': 'createdAt',
      'orderdirection': 'desc',
      'start': startIndex.toString(),
      'count': number.toString(),
    };
    return queryParams;
  }

  // Campaign
  Future<List<CampaignPost>> GetCampaigns(
    int startIndex,
    int number,
  ) async {
    var queryParams = _getSearchQueryParams(startIndex, number);
    var url = Uri.http(ServerUrl, '/campaign/select', queryParams);
    var response = await http.get(url);
    log(response.request.toString());

    var jsonResponse = await _transferToJson(response);

    return _getCampaignPostsFromResponse(jsonResponse);
  }

  Future<List<CampaignPost>> GetCampaignsByUserId(
    int userId,
    int startIndex,
    int number,
  ) async {
    var queryParams = _getSearchQueryParams(startIndex, number)
      ..addEntries({'creatorId': userId}.entries);
    var url = Uri.http(ServerUrl, '/campaign/select', queryParams);
    var response = await http.get(url);

    var jsonResponse = await _transferToJson(response);

    return _getCampaignPostsFromResponse(jsonResponse);
  }

  Future<UserOverview> GetPaticipantsCampaign(int postId) async {
    throw Exception("Not implement");
  }

  Future<bool> InsertCampaign(CampaignPost post) async {
    var url = Uri.http(ServerUrl, '/campaign/insert');
    var request = http.MultipartRequest("POST", url);

    request.fields.addEntries(
      (Map<String, String>.from(post.toJson())).entries,
    );
    if (post.imageUrl != null && !isImageURL(post.imageUrl!)) {
      request.files
          .add(await http.MultipartFile.fromPath('image', post.imageUrl!));
    }
    if (post.bannerUrl != null && !isImageURL(post.bannerUrl!)) {
      request.files
          .add(await http.MultipartFile.fromPath('banner', post.bannerUrl!));
    }

    var response = await request.send();
    var jsonResponse = await _transferToJson(response);

    return jsonResponse['result'] as bool;
  }

  Future<bool> UpdateCampaign(String key, CampaignPost post) async {
    return _update('campaign', key, post);
  }

  Future<bool> DeleteCampaign(List<String> ids) async {
    return _delete('campaign', ids);
  }

  //Emergency
  Future<List<EmergencyPost>> GetEmergencies(
    int startIndex,
    int number,
  ) async {
    var queryParams = _getSearchQueryParams(startIndex, number);
    var url = Uri.http(ServerUrl, '/emergency/select', queryParams);
    var response = await http.get(url);

    var jsonResponse = await _transferToJson(response);

    return _getEmergencyPostsFromResponse(jsonResponse);
  }

  Future<List<EmergencyPost>> GetEmergenciesByUserId(
    int userId,
    int startIndex,
    int number,
  ) async {
    var queryParams = _getSearchQueryParams(startIndex, number)
      ..addEntries({'creatorId': userId}.entries);
    var url = Uri.http(ServerUrl, '/emergency/select', queryParams);
    var response = await http.get(url);

    var jsonResponse = await _transferToJson(response);

    return _getEmergencyPostsFromResponse(jsonResponse);
  }

  Future<bool> InsertEmergency(EmergencyPost post) async {
    var url = Uri.http(ServerUrl, '/emergency/insert');
    var request = http.MultipartRequest("POST", url);
    if (post.imageUrl != null) {
      request.files
          .add(await http.MultipartFile.fromPath('image', post.imageUrl!));
    }
    if (post.bannerUrl != null) {
      request.files
          .add(await http.MultipartFile.fromPath('banner', post.bannerUrl!));
    }

    var response = await request.send();
    var jsonResponse = await _transferToJson(response);

    return jsonResponse['result'] as bool;
  }

  Future<bool> UpdateEmergency(String key, EmergencyPost post) async {
    return _update('emergency', key, post);
  }

  Future<bool> DeleteEmergency(List<String> ids) async {
    return _delete('emergency', ids);
  }

  Future<bool> _update(String path, String key, IPost post) async {
    var url = Uri.http(ServerUrl, '/$path/update');
    var request = http.MultipartRequest("POST", url)..fields['key'] = key;
    request.fields.addEntries(
      (Map<String, String>.from(post.toJson())).entries,
    );
    if (post.imageUrl != null && !isImageURL(post.bannerUrl!)) {
      request.files
          .add(await http.MultipartFile.fromPath('image', post.imageUrl!));
    }
    if (post.bannerUrl != null && !isImageURL(post.bannerUrl!)) {
      request.files
          .add(await http.MultipartFile.fromPath('banner', post.bannerUrl!));
    }

    var response = await request.send();
    var jsonResponse =
        jsonDecode(await _getBody(response)) as Map<String, dynamic>;
    return response.statusCode == 200 && jsonResponse['result'] == true;
  }

  Future<bool> _delete(String path, List<String> ids) async {
    var url = Uri.http(ServerUrl, '/$path/delete');
    var response = await http.post(url, body: {'keys': ids});

    var jsonResponse =
        jsonDecode(await _getBody(response)) as Map<String, dynamic>;
    return response.statusCode == 200 && jsonResponse['result'] == true;
  }
}
