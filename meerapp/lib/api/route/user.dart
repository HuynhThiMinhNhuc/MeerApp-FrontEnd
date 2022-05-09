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

  static Future<MyResponse> getCreatedCampaign(int userId) async {
    return myAPIWrapper.getWithAuth(
      ServerUrl + "/user/other/detail/campaign/created?start=0&count=1000",
      queryParameters: {"userId": userId},
    );
  }

  static Future<MyResponse> getDonedCampaign(int userId) async {
    return myAPIWrapper.getWithAuth(
      ServerUrl + "/user/other/detail/campaign/doned?start=0&count=1000",
      queryParameters: {"userId": userId},
    );
  }

  static Future<MyResponse> getNotDoneCampaign(int userId) async {
    return myAPIWrapper.getWithAuth(
      ServerUrl + "/user/other/detail/campaign/notdoned?start=0&count=1000",
      queryParameters: {"userId": userId},
    );
  }

  static Future<MyResponse> getCreatedEmergency(int userId) async {
    return myAPIWrapper.getWithAuth(
      ServerUrl + "/user/other/detail/emergency/created?start=0&count=1000",
      queryParameters: {"userId": userId},
    );
  }

  static Future<MyResponse> getDonedEmergency(int userId) async {
    return myAPIWrapper.getWithAuth(
      ServerUrl + "/user/other/detail/emergency/doned?start=0&count=1000",
      queryParameters: {"userId": userId},
    );
  }

  static Future<MyResponse> getUserInfo(int userId) async {
    return myAPIWrapper.getWithAuth(
      ServerUrl + "/user/other/detailbyid",
      queryParameters: {"userId": userId},
    );
  }

  static Future<MyResponse> updateUserInfo(dynamic formdata) async {
    return myAPIWrapper.postWithAuth(
      ServerUrl + "/user/update",
      data: formdata,
    );
  }
}
