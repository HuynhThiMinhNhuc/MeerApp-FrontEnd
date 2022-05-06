enum Gender { male, female, unknown }

abstract class BaseUser {
  final String id;
  final String name;
  final String? avatarUri;

  BaseUser({required this.id, required this.name, this.avatarUri});
}

class UserOverview extends BaseUser {
  UserOverview({
    required String id,
    required String name,
    String? avatarUri,
  }) : super(id: id, name: name, avatarUri: avatarUri);
}

class UserDetail extends BaseUser {
  final Gender gender;
  final String email;

  UserDetail({
    required String id,
    required String name,
    String? avatarUri,
    required this.gender,
    required this.email,
  }) : super(id: id, name: name, avatarUri: avatarUri);
}
