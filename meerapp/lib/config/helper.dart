import 'dart:async';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:meerapp/config/constant.dart';

bool isImageURL(String text) {
  return text.startsWith('uploads/');
}

String DateTimeToString(DateTime time) {
  return "lúc " +
      DateFormat('h:mm').format(time) +
      'h, ngày ' +
      DateFormat('d/M/yyyy').format(time);
}

String DateTimeToString2(DateTime time) {
  return DateFormat('d/M/yyyy').format(time);
}

Future<T> getResponse<T extends BaseResponse>(Future<T> request) {
  return request
      .timeout(Duration(seconds: timeoutHttp)).catchError((error, stackTrace) => throw Exception(error));
}

bool isHttpImage(String imagePath) {
  return imagePath.contains('uploads/');
}

String tranferToDbPath(String path) {
  return ServerUrl + "/public/" + path;
}