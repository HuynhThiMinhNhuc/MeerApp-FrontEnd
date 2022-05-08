import 'package:dio/dio.dart';
import 'package:meerapp/api/MyWrapper.dart';
import 'package:meerapp/config/constant.dart';

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
}
