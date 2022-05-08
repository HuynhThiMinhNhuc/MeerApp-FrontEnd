import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meerapp/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

abstract class IPost {
  final int id;
  final String title;
  final String content;

  final UserOverview creator;

  final String address;
  @JsonKey(name: 'gpslati')
  final double lat;
  @JsonKey(name: 'gpslongti')
  final double lng;
  @JsonKey(name: 'imageURI')
  final String? imageUrl;
  final String? bannerUrl;
  @JsonKey(name: 'createdAt')
  final DateTime timeCreate;

  @JsonKey(ignore: true)
  LatLng get position => LatLng(lat, lng);

  IPost({
    required this.id,
    required this.address,
    required this.lat,
    required this.lng,
    required this.title,
    required this.content,
    required this.creator,
    required this.timeCreate,
    required this.imageUrl,
    required this.bannerUrl,
  });

  Map<String, dynamic> toJson();
}

@JsonSerializable()
class CampaignPost extends IPost {
  @JsonKey(name: 'dateTimeStart')
  final DateTime timeStart;

  CampaignPost({
    required int id,
    required String address,
    required double lat,
    required double lng,
    required String title,
    required String content,
    required UserOverview creator,
    required DateTime timeCreate,
    required String? imageUrl,
    required String? bannerUrl,
    required this.timeStart,
  }) : super(
          id: id,
          address: address,
          lat: lat,
          lng: lng,
          title: title,
          content: content,
          creator: creator,
          timeCreate: timeCreate,
          imageUrl: imageUrl,
          bannerUrl: bannerUrl,
        );

  factory CampaignPost.fromJson(Map<String, dynamic> json) =>
      _$CampaignPostFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$CampaignPostToJson(this);
}

@JsonSerializable()
class DetailCampaignPost extends CampaignPost {
  final List<UserOverview> joined;
  final List<UserOverview> doned;
  final List<UserOverview> absent; // Vắng có phép
  final List<UserOverview> reported;
  final List<UserOverview> notdone; // Vắng không phép
  @_EmailConverter()
  final String email;
  @_PhoneConverter()
  final String? phone;

  DetailCampaignPost({
    required int id,
    required String address,
    required double lat,
    required double lng,
    required String title,
    required String content,
    required UserOverview creator,
    required DateTime timeCreate,
    required String? imageUrl,
    required String? bannerUrl,
    required DateTime timeStart,
    required this.joined,
    required this.doned,
    required this.absent,
    required this.reported,
    required this.notdone,
    required this.email,
    this.phone,
  }) : super(
          id: id,
          address: address,
          lat: lat,
          lng: lng,
          title: title,
          content: content,
          creator: creator,
          timeCreate: timeCreate,
          imageUrl: imageUrl,
          bannerUrl: bannerUrl,
          timeStart: timeStart,
        );

  factory DetailCampaignPost.fromJson(Map<String, dynamic> json) =>
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
        email: json['creator']['email'] as String,
        phone: json['creator']['phone'] as String?,
      );
  @override
  Map<String, dynamic> toJson() => _$DetailCampaignPostToJson(this);
}

@JsonSerializable()
class EmergencyPost extends IPost {
  EmergencyPost({
    required int id,
    required String address,
    required double lat,
    required double lng,
    required String title,
    required String content,
    required UserOverview creator,
    required DateTime timeCreate,
    required String? imageUrl,
    required String? bannerUrl,
  }) : super(
          id: id,
          address: address,
          lat: lat,
          lng: lng,
          title: title,
          content: content,
          creator: creator,
          timeCreate: timeCreate,
          imageUrl: imageUrl,
          bannerUrl: bannerUrl,
        );

  factory EmergencyPost.fromJson(Map<String, dynamic> json) =>
      _$EmergencyPostFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$EmergencyPostToJson(this);
}

@JsonSerializable()
class DetailEmergencyPost extends EmergencyPost {
  final List<UserOverview> joined;
  final List<UserOverview> doned;
  final List<UserOverview> absent;
  final List<UserOverview> reported;
  final List<UserOverview> notdone;
  @_EmailConverter()
  final String email;
  @_PhoneConverter()
  final String? phone;

  DetailEmergencyPost({
    required int id,
    required String address,
    required double lat,
    required double lng,
    required String title,
    required String content,
    required UserOverview creator,
    required DateTime timeCreate,
    required String? imageUrl,
    required String? bannerUrl,
    required this.joined,
    required this.doned,
    required this.absent,
    required this.reported,
    required this.notdone,
    required this.email,
    this.phone,
  }) : super(
          id: id,
          address: address,
          lat: lat,
          lng: lng,
          title: title,
          content: content,
          creator: creator,
          timeCreate: timeCreate,
          imageUrl: imageUrl,
          bannerUrl: bannerUrl,
        );

  factory DetailEmergencyPost.fromJson(Map<String, dynamic> json) =>
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
        email: json['creator']['email'] as String,
        phone: json['creator']['phone'] as String?,
      );
  @override
  Map<String, dynamic> toJson() => _$DetailEmergencyPostToJson(this);
}

class _EmailConverter extends JsonConverter<String, Map<String, dynamic>> {
  const _EmailConverter();
  @override
  String fromJson(Map<String, dynamic> json) {
    return json['creator']['email'];
  }

  @override
  Map<String, dynamic> toJson(String object) {
    throw UnimplementedError();
  }
}

class _PhoneConverter extends JsonConverter<String?, Map<String, dynamic>> {
  const _PhoneConverter();
  @override
  String? fromJson(Map<String, dynamic> json) {
    return json['creator']['phone'] as String?;
  }

  @override
  Map<String, dynamic> toJson(String? object) {
    throw UnimplementedError();
  }
}
