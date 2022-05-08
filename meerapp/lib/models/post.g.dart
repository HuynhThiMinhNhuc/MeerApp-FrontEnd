// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CampaignPost _$CampaignPostFromJson(Map<String, dynamic> json) => CampaignPost(
      id: json['id'] as int,
      address: json['address'] as String,
      lat: (json['gpslati'] as num).toDouble(),
      lng: (json['gpslongti'] as num).toDouble(),
      title: json['title'] as String,
      content: json['content'] as String,
      creator: UserOverview.fromJson(json['creator'] as Map<String, dynamic>),
      timeCreate: DateTime.parse(json['createdAt'] as String),
      imageUrl: json['imageURI'] as String?,
      bannerUrl: json['bannerUrl'] as String?,
      timeStart: DateTime.parse(json['dateTimeStart'] as String),
    );

Map<String, dynamic> _$CampaignPostToJson(CampaignPost instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'creator': instance.creator,
      'address': instance.address,
      'gpslati': instance.lat,
      'gpslongti': instance.lng,
      'imageURI': instance.imageUrl,
      'bannerUrl': instance.bannerUrl,
      'createdAt': instance.timeCreate.toIso8601String(),
      'dateTimeStart': instance.timeStart.toIso8601String(),
    };

EmergencyPost _$EmergencyPostFromJson(Map<String, dynamic> json) =>
    EmergencyPost(
      id: json['id'] as int,
      address: json['address'] as String,
      lat: (json['gpslati'] as num).toDouble(),
      lng: (json['gpslongti'] as num).toDouble(),
      title: json['title'] as String,
      content: json['content'] as String,
      creator: UserOverview.fromJson(json['creator'] as Map<String, dynamic>),
      timeCreate: DateTime.parse(json['createdAt'] as String),
      imageUrl: json['imageURI'] as String?,
      bannerUrl: json['bannerUrl'] as String?,
    );

Map<String, dynamic> _$EmergencyPostToJson(EmergencyPost instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'creator': instance.creator,
      'address': instance.address,
      'gpslati': instance.lat,
      'gpslongti': instance.lng,
      'imageURI': instance.imageUrl,
      'bannerUrl': instance.bannerUrl,
      'createdAt': instance.timeCreate.toIso8601String(),
    };
