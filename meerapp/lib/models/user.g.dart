// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserOverview _$UserOverviewFromJson(Map<String, dynamic> json) => UserOverview(
      id: json['id'] as int,
      name: json['fullname'] as String,
      avatarUri: json['avatarImageURI'] as String?,
      address: json['address'] as String?,
    );

Map<String, dynamic> _$UserOverviewToJson(UserOverview instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullname': instance.name,
      'avatarImageURI': instance.avatarUri,
      'address': instance.address,
    };

UserDetail _$UserDetailFromJson(Map<String, dynamic> json) => UserDetail(
      id: json['id'] as int,
      name: json['fullname'] as String,
      avatarUri: json['avatarImageURI'] as String?,
      address: json['address'] as String?,
      gender: $enumDecode(_$GenderEnumMap, json['gender']),
      email: json['email'] as String,
    );

Map<String, dynamic> _$UserDetailToJson(UserDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullname': instance.name,
      'avatarImageURI': instance.avatarUri,
      'address': instance.address,
      'gender': _$GenderEnumMap[instance.gender],
      'email': instance.email,
    };

const _$GenderEnumMap = {
  Gender.male: 'male',
  Gender.female: 'female',
  Gender.unknown: 'unknown',
};
