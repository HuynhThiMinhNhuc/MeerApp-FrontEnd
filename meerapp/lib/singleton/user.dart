import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:meerapp/api/MyWrapper.dart';
import 'package:meerapp/api/route/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthData {
  static const String KEY = "auth";
  String? username;
  String? password;
  String? token;
  int? userId;

  AuthData({
    this.username,
    this.password,
    this.token,
    this.userId,
  });

  factory AuthData.fromJSON(dynamic json) {
    return AuthData(
      username: json["username"],
      password: json["password"],
      token: json["token"],
      userId: json["userId"] as int,
    );
  }

  toJson() => {
        "username": username,
        "password": password,
        "token": token,
        "userId": userId,
      };
}

class UserSingleton {
  static final UserSingleton _instance = UserSingleton._privateContructor();
  static UserSingleton get instance => _instance;
  UserSingleton._privateContructor() {
    // auth = AuthData();
    // auth?.token = "USER-TOKEN";
    // isLogined = true;
    // currentUserId = 1;
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

  AuthData? auth;
  bool get isLogined =>
      (auth != null && auth!.token != null && auth!.userId != null);

  late StreamController<dynamic> userInfoStream;
  FutureOr<void> refreshUserInfo() async {
    log("refreshUserInfo()");

    if (!isLogined) {
      userInfoStream.add(null);
      return;
    }

    UserAPI.getCurrentUserInfo().then((value) {
      if (value.errorCode == null) {
        userInfoStream.add(value.data);
      } else {
        userInfoStream.add(null);
      }
    });
  }

  FutureOr saveAuth() async {
    var prefs = await SharedPreferences.getInstance();
    if (auth == null) {
      return prefs.remove(AuthData.KEY);
    } else {
      return prefs.setString(AuthData.KEY, jsonEncode(auth!.toJson()));
    }
  }

  FutureOr loadAuth() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(AuthData.KEY)) {
      var jsonString = prefs.getString(AuthData.KEY);
      if (jsonString == null) {
        await prefs.remove(AuthData.KEY);
      } else {
        auth = AuthData.fromJSON(jsonDecode(jsonString));
      }
    }
  }
}
