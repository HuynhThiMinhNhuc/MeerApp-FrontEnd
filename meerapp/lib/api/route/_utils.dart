import 'dart:convert';

import 'dart:developer';

class APIResponse {
  int? errorCode;
  String? errorMessage;
  dynamic data;

  APIResponse(this.data, {this.errorCode, this.errorMessage});

  factory APIResponse.error(int code, String message) {
    return APIResponse(null, errorCode: code, errorMessage: message);
  }
}

APIResponse handleResponse(dynamic json) {
  dynamic response = json is String ? jsonDecode(json) : json;

  log("Has response :");
  log(json.toString());

  if (response["result"] == true) {
    return APIResponse(response["data"]);
  } else {
    int errorCode = int.parse(response["errorCode"]);
    String errorMessage = response["errorMessage"];
    return APIResponse.error(errorCode, errorMessage);
  }
}
