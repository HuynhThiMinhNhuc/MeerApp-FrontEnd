import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

enum Gender { male, female, unknown }

abstract class BaseUser {
  final int id;
  @JsonKey(name:'fullname')
  final String name;
  @JsonKey(name:'avatarImageURI')
  final String? avatarUri;
  final String? address;

  BaseUser({
    required this.id,
    required this.name,
    this.avatarUri,
    this.address,
  });

  // factory BaseUser.fromJson(Map<String, dynamic> json) =>
  //     _$BaseUserFromJson(json);
  // Map<String, dynamic> toJson() => _$BaseUserToJson(this);
}

@JsonSerializable()
class UserOverview extends BaseUser {
  UserOverview({
    required int id,
    required String name,
    required String? avatarUri,
    required String? address,
  }) : super(
          id: id,
          name: name,
          avatarUri: avatarUri,
          address: address,
        );

  factory UserOverview.fromJson(Map<String, dynamic> json) =>
      _$UserOverviewFromJson(json);
  Map<String, dynamic> toJson() => _$UserOverviewToJson(this);
}

@JsonSerializable()
class UserDetail extends BaseUser {
  final Gender gender;
  final String email;

  UserDetail({
    required int id,
    required String name,
    required String? avatarUri,
    required String? address,
    required this.gender,
    required this.email,
  }) : super(
          id: id,
          name: name,
          avatarUri: avatarUri,
          address: address,
        );

  factory UserDetail.fromJson(Map<String, dynamic> json) =>
      _$UserDetailFromJson(json);
  Map<String, dynamic> toJson() => _$UserDetailToJson(this);
}
