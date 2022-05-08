import 'package:meerapp/api/MyWrapper.dart';
import 'package:meerapp/api/route/user.dart';

class AuthData {
  String? username;
  String? password;
  String? token;
}

class UserSingleton {
  static final UserSingleton _instance = UserSingleton._privateContructor();
  static UserSingleton get instance => _instance;
  UserSingleton._privateContructor() {
    auth = AuthData();
    auth?.token = "USER-TOKEN";
    isLogined = true;
    currentUserId = 1;
  }

  bool isLogined = false;
  AuthData? auth;
  int? currentUserId;
}
