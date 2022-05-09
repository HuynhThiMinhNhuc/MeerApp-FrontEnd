import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:meerapp/api/MyWrapper.dart';
import 'package:meerapp/config/constant.dart';
import 'package:meerapp/singleton/user.dart';

class UserAPI {
  static Future<MyResponse> getCurrentUserInfo() async {
    return myAPIWrapper.getWithAuth(ServerUrl + "/user/detailbytoken");
  }

  static Future<MyResponse> getCreatedCampaign() async {
    return myAPIWrapper.getWithAuth(
        ServerUrl + "/user/detail/campaign/created?start=0&count=1000");
  }

  static Future<MyResponse> getDonedCampaign() async {
    return myAPIWrapper.getWithAuth(
        ServerUrl + "/user/detail/campaign/doned?start=0&count=1000");
  }

  static Future<MyResponse> getNotDoneCampaign() async {
    return myAPIWrapper.getWithAuth(
        ServerUrl + "/user/detail/campaign/notdoned?start=0&count=1000");
  }

  static Future<MyResponse> getCreatedEmergency() async {
    return myAPIWrapper.getWithAuth(
        ServerUrl + "/user/detail/emergency/created?start=0&count=1000");
  }

  static Future<MyResponse> getDonedEmergency() async {
    return myAPIWrapper.getWithAuth(
        ServerUrl + "/user/detail/emergency/doned?start=0&count=1000");
  }

  static Future<MyResponse> updateUserInfo(dynamic formdata) async {
    return myAPIWrapper.postWithAuth(
      ServerUrl + "/user/update",
      data: formdata,
    );
  }

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
