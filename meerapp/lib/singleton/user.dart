import 'dart:async';
import 'dart:developer';

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
    userInfoStream = StreamController<dynamic>.broadcast(
      onListen: () {
        log("Listened to userInfo");
      },
      onCancel: () {
        log("Stop listening to userInfo");
      },
    );
    userInfoStream.addStream(Stream.value(null));
    //refreshUserInfo();
  }

  bool isLogined = false;
  AuthData? auth;
  int? currentUserId;

  late StreamController<dynamic> userInfoStream;
  FutureOr<void> refreshUserInfo() async {
    log("refreshUserInfo()");
    UserAPI.getCurrentUserInfo().then((value) {
      if (value.errorCode == null) {
        userInfoStream.sink.add(value.data);
      } else {
        userInfoStream.sink.add(null);
      }
    });
  }
}
