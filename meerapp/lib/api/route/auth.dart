import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:meerapp/api/MyWrapper.dart';
import 'package:meerapp/api/route/user.dart';
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
            },
            "deviceInfo": json.encode({})
          },
        ));
    if (response.errorCode == null) {
      UserSingleton.instance.auth = AuthData(
        username: username,
        password: password,
        token: response.data["token"],
        userId: response.data["userId"] as int,
      );
      UserSingleton.instance.refreshUserInfo();
      UserSingleton.instance.saveAuth();
    }
    return response;
  }

  static Future<void> signout() async {
    // notify to server
    myAPIWrapper.postWithAuth(ServerUrl + "/login/signout");

    UserSingleton.instance.auth = null;
    UserSingleton.instance.refreshUserInfo();
    UserSingleton.instance.saveAuth();
  }

  static Future<MyResponse> signup(dynamic jsonData) async {
    var response = await myAPIWrapper.postWithAuth(
      ServerUrl + "/signup",
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      }),
      data: jsonEncode(jsonData),
    );

    return response;
  }
}
