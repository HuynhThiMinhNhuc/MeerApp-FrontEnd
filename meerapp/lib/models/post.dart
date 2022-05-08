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
  @JsonKey(name:'createdAt')
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
  @JsonKey(name:'dateTimeStart')
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
