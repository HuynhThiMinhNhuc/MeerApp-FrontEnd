part of 'controller.dart';

class MapController extends BaseController {
  Map<String, dynamic> _getNearbyQueryParams(double lat, double lng) {
    return <String, dynamic>{
      'longitude': lng.toString(),
      'latitude': lat.toString(),
      'maxdistance': maxDistanceNearby.toString(),
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


  Future<List<CampaignMap>> getCampaignsMap(double lat, double lng) async {
    try {
      var response = await dio.get(ServerUrl + '/nearby/campaign',
          queryParameters: _getNearbyQueryParams(lat, lng));
      var jsonResponse = _mapResponseToJson(response);
      
      return _mapJsonToCampaigns(jsonResponse);
    } on TimeoutException catch(_) {
      return Future.error(TimeoutException);
    } catch (e) {
      return Future.error('Cannot not get Campaign map');
    }
  }

  Future<List<EmergencyMap>> getEmergenciesMap(double lat, double lng) async {
    try {
      var response = await dio.get(ServerUrl + '/nearby/emergency',
          queryParameters: _getNearbyQueryParams(lat, lng));
      var jsonResponse = _mapResponseToJson(response);

      return _mapJsonToEmergencies(jsonResponse);
    } on TimeoutException catch(_) {
      return Future.error(TimeoutException);
    } catch (e) {
      return Future.error('Cannot not get Emergency map');
    }
  }

  Future<List<UserMap>> getVolunteerMap(double lat, double lng) async {
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
