import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meerapp/models/user.dart';

part 'map.g.dart';

abstract class IMapObject {
  final int id;
  @JsonKey(name: 'latitude')
  final double lat;
  @JsonKey(name:'longtitude')
  final double lng;
  final String title;
  final DateTime time;
  @JsonKey(ignore: true)
  LatLng get position => LatLng(lat, lng);

  IMapObject({
    required this.id,
    required this.lat,
    required this.lng,
    required this.title,
    required this.time,
  });
}

@JsonSerializable()
class CampaignMap extends IMapObject {
  CampaignMap({
    required int id,
    required double lat,
    required double lng,
    required String title,
    required DateTime time,
  }) : super(
          id: id,
          lat: lat,
          lng: lng,
          title: title,
          time: time,
        );
                  factory CampaignMap.fromJson(Map<String, dynamic> json) =>
      _$CampaignMapFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$CampaignMapToJson(this);
}

@JsonSerializable()
class EmergencyMap extends IMapObject {
  EmergencyMap({
    required int id,
    required double lat,
    required double lng,
    required String title,
    required DateTime time,
  }) : super(
          id: id,
          lat: lat,
          lng: lng,
          title: title,
          time: time,
        );

  factory EmergencyMap.fromJson(Map<String, dynamic> json) =>
      _$EmergencyMapFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$EmergencyMapToJson(this);
}

@JsonSerializable()
class UserMap extends IMapObject {
  UserMap({
    required int id,
    required double lat,
    required double lng,
    required String title,
    required DateTime time,
  }) : super(
          id: id,
          lat: lat,
          lng: lng,
          title: title,
          time: time,
        );

          factory UserMap.fromJson(Map<String, dynamic> json) =>
      _$UserMapFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$UserMapToJson(this);
}
