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

DetailCampaignPost _$DetailCampaignPostFromJson(Map<String, dynamic> json) =>
    DetailCampaignPost(
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
      joined: (json['joined'] as List<dynamic>)
          .map((e) => UserOverview.fromJson(e as Map<String, dynamic>))
          .toList(),
      doned: (json['doned'] as List<dynamic>)
          .map((e) => UserOverview.fromJson(e as Map<String, dynamic>))
          .toList(),
      absent: (json['absent'] as List<dynamic>)
          .map((e) => UserOverview.fromJson(e as Map<String, dynamic>))
          .toList(),
      reported: (json['reported'] as List<dynamic>)
          .map((e) => UserOverview.fromJson(e as Map<String, dynamic>))
          .toList(),
      notdone: (json['notdone'] as List<dynamic>)
          .map((e) => UserOverview.fromJson(e as Map<String, dynamic>))
          .toList(),
      email: const _EmailConverter()
          .fromJson(json['email'] as Map<String, dynamic>),
      phone: const _PhoneConverter()
          .fromJson(json['phone'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DetailCampaignPostToJson(DetailCampaignPost instance) =>
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
      'joined': instance.joined,
      'doned': instance.doned,
      'absent': instance.absent,
      'reported': instance.reported,
      'notdone': instance.notdone,
      'email': const _EmailConverter().toJson(instance.email),
      'phone': const _PhoneConverter().toJson(instance.phone),
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

DetailEmergencyPost _$DetailEmergencyPostFromJson(Map<String, dynamic> json) =>
    DetailEmergencyPost(
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
      joined: (json['joined'] as List<dynamic>)
          .map((e) => UserOverview.fromJson(e as Map<String, dynamic>))
          .toList(),
      doned: (json['doned'] as List<dynamic>)
          .map((e) => UserOverview.fromJson(e as Map<String, dynamic>))
          .toList(),
      absent: (json['absent'] as List<dynamic>)
          .map((e) => UserOverview.fromJson(e as Map<String, dynamic>))
          .toList(),
      reported: (json['reported'] as List<dynamic>)
          .map((e) => UserOverview.fromJson(e as Map<String, dynamic>))
          .toList(),
      notdone: (json['notdone'] as List<dynamic>)
          .map((e) => UserOverview.fromJson(e as Map<String, dynamic>))
          .toList(),
      email: const _EmailConverter()
          .fromJson(json['email'] as Map<String, dynamic>),
      phone: const _PhoneConverter()
          .fromJson(json['phone'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DetailEmergencyPostToJson(
        DetailEmergencyPost instance) =>
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
      'joined': instance.joined,
      'doned': instance.doned,
      'absent': instance.absent,
      'reported': instance.reported,
      'notdone': instance.notdone,
      'email': const _EmailConverter().toJson(instance.email),
      'phone': const _PhoneConverter().toJson(instance.phone),
    };
