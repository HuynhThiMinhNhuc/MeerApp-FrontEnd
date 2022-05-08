// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CampaignMap _$CampaignMapFromJson(Map<String, dynamic> json) => CampaignMap(
      id: json['id'] as int,
      lat: (json['latitude'] as num).toDouble(),
      lng: (json['longtitude'] as num).toDouble(),
      title: json['title'] as String,
      time: DateTime.parse(json['time'] as String),
    );

Map<String, dynamic> _$CampaignMapToJson(CampaignMap instance) =>
    <String, dynamic>{
      'id': instance.id,
      'latitude': instance.lat,
      'longtitude': instance.lng,
      'title': instance.title,
      'time': instance.time.toIso8601String(),
    };

EmergencyMap _$EmergencyMapFromJson(Map<String, dynamic> json) => EmergencyMap(
      id: json['id'] as int,
      lat: (json['latitude'] as num).toDouble(),
      lng: (json['longtitude'] as num).toDouble(),
      title: json['title'] as String,
      time: DateTime.parse(json['time'] as String),
    );

Map<String, dynamic> _$EmergencyMapToJson(EmergencyMap instance) =>
    <String, dynamic>{
      'id': instance.id,
      'latitude': instance.lat,
      'longtitude': instance.lng,
      'title': instance.title,
      'time': instance.time.toIso8601String(),
    };

UserMap _$UserMapFromJson(Map<String, dynamic> json) => UserMap(
      id: json['id'] as int,
      lat: (json['latitude'] as num).toDouble(),
      lng: (json['longtitude'] as num).toDouble(),
      title: json['title'] as String,
      time: DateTime.parse(json['time'] as String),
    );

Map<String, dynamic> _$UserMapToJson(UserMap instance) => <String, dynamic>{
      'id': instance.id,
      'latitude': instance.lat,
      'longtitude': instance.lng,
      'title': instance.title,
      'time': instance.time.toIso8601String(),
    };
