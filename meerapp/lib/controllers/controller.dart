import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:meerapp/api/MyWrapper.dart';
import 'package:meerapp/config/constant.dart';
import 'package:meerapp/config/helper.dart';
import 'package:meerapp/injection.dart';
import 'package:meerapp/models/map.dart';
import 'package:meerapp/models/post.dart';
import 'package:meerapp/models/user.dart';

part './post_controller.dart';
part './map_controller.dart';

class BaseController {
  final dio = sl.get<Dio>();

  bool _isResponseSuccess(Response response) {
    var jsonResponse = response.data as Map<String, dynamic>;
    return response.statusCode == 200 && jsonResponse['result'] == true;
  }

  Map<String, dynamic> _mapResponseToJson(Response response) {
    // Check if response is success
    if (!_isResponseSuccess(response)) {
      throw Exception("Not get correct response");
    }
    return response.data as Map<String, dynamic>;
  }

    Map<String, dynamic> _getSearchQueryParams(int startIndex, int number) {
    var queryParams = <String, dynamic>{
      'searchby': 'title',
      // 'searchvalue': '',
      'orderby': 'createdAt',
      'orderdirection': 'desc',
      'start': startIndex.toString(),
      'count': number.toString(),
    };
    return queryParams;
  }
}
