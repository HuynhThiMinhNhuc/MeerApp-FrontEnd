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
}