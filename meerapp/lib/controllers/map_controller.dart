part of 'controller.dart';

class MapController extends BaseController {
  Map<String, dynamic> _getNearbyQueryParams(int lat, int lng) {
    return <String, dynamic>{
      'longitude': lng,
      'latitude': lat,
      'maxdistance': maxDistanceNearby,
    };
  }

  List<CampaignMap> _mapJsonToCampaigns(Map<String, dynamic> json) {
    return (json['data'] as List<dynamic>)
        .map((json) => CampaignMap.fromJson(json))
        .toList();
  }

  List<EmergencyMap> _mapJsonToEmergencies(Map<String, dynamic> json) {
    return (json['data'] as List<dynamic>)
        .map((json) => EmergencyMap.fromJson(json))
        .toList();
  }

  List<UserMap> _mapJsonToUsers(Map<String, dynamic> json) {
    return (json['data'] as List<dynamic>)
        .map((json) => UserMap.fromJson(json))
        .toList();
  }


  Future<List<CampaignMap>> getCampaignsMap(int lat, int lng) async {
    try {
      var response = await dio.get(ServerUrl + '/nearby/campaign',
          queryParameters: _getNearbyQueryParams(lat, lng));
      var jsonResponse = _mapResponseToJson(response);
      
      return _mapJsonToCampaigns(jsonResponse);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List<EmergencyMap>> getEmergencisMap(int lat, int lng) async {
    try {
      var response = await dio.get(ServerUrl + '/nearby/emergency',
          queryParameters: _getNearbyQueryParams(lat, lng));
      var jsonResponse = _mapResponseToJson(response);

      return _mapJsonToEmergencies(jsonResponse);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List<UserMap>> getVolunteerMap(int lat, int lng) async {
    try {
      var response = await dio.get(ServerUrl + '/nearby/campaign',
          queryParameters: _getNearbyQueryParams(lat, lng));
      var jsonResponse = _mapResponseToJson(response);

      return _mapJsonToUsers(jsonResponse);
    } catch (e) {
      return Future.error(e);
    }
  }
}
