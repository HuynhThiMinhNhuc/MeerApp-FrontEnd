import 'package:dio/dio.dart';
import 'package:meerapp/api/MyWrapper.dart';
import 'package:meerapp/config/constant.dart';

class CampaignAPI {
  static Future<MyResponse> update(int, campaignId, FormData formdata) async {
    formdata.fields.add(MapEntry("key", campaignId.toString()));
    return myAPIWrapper.postWithAuth(
      ServerUrl + "/user/update",
      data: formdata,
    );
  }
}
