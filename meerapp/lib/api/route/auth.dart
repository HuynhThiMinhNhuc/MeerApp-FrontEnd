import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:meerapp/api/MyWrapper.dart';
import 'package:meerapp/config/constant.dart';
import 'package:meerapp/singleton/user.dart';

class AuthAPI {
  static Future<MyResponse> login(String username, String password) async {
    var response = await myAPIWrapper.post(ServerUrl + "/login",
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: jsonEncode(
          {
            "account": {
              "username": username,
              "password": password,
            }
          },
        ));
    if (response.errorCode != null) {
      var auth = AuthData();
      auth.username = username;
      auth.password = password;
      auth.token = response.data["token"];
      UserSingleton.instance.currentUserId = response.data["userId"];
      UserSingleton.instance.auth = auth;
      UserSingleton.instance.isLogined = true;
    }
    return response;
  }

  static Future<MyResponse> signout() async {
    var response = await myAPIWrapper.postWithAuth(ServerUrl + "/signout");
    if (response.errorCode != null) {
      UserSingleton.instance.currentUserId = null;
      UserSingleton.instance.auth = null;
      UserSingleton.instance.isLogined = false;
    }
    return response;
  }
}
