import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:meerapp/config/constant.dart';
import 'package:meerapp/injection.dart';
import 'package:meerapp/singleton/user.dart';

class MyResponse {
  int? errorCode;
  String? errorMessage;
  dynamic data;
  MyResponse({
    this.errorCode,
    this.errorMessage,
    this.data,
  });

  MyResponse.fromJson(Map<String, dynamic> json) {
    errorCode = json['errorCode'];
    errorMessage = json['errorMessage'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['errorCode'] = errorCode;
    _data['errorMessage'] = errorMessage;
    _data['data'] = data;
    return _data;
  }
}

class APIWrapper {
  Dio dio = sl.get<Dio>();

  static Options? buildHeaderToken(Options? options) {
    var currentUser = UserSingleton.instance;
    if (!UserSingleton.instance.isLogined) {
      return null;
    }

    final token = currentUser.auth?.token as String;
    if (options == null) {
      return Options(
        headers: {
          "token": token,
        },
      );
    } else if (options.headers == null) {
      options.headers = {
        "token": token,
      };
      return options;
    } else {
      options.headers?["token"] = token;
      return options;
    }
  }

  static MyResponse handleResponse(Response<dynamic> response) {
    if (response.statusCode == 200) {
      log(response.toString());
      final myresponse = MyResponse.fromJson(response.data);
      if (myresponse.errorCode != null) {
        // Check if error is not login yet
        if (myresponse.errorCode == 401) {
          // View login screen
        }
        return myresponse;
      } else {
        // No error
        return myresponse;
      }
    }
    return MyResponse(
      errorCode: -1,
      errorMessage: "Unexpected error",
    );
  }

  static MyResponse handleException(error, stackTrace) {
    log(error.toString());
    log(stackTrace.toString());
    // Should show pushup to quit app here
    return MyResponse(
      errorCode: -2,
      errorMessage: "Connection error",
    );
  }

  FutureOr<MyResponse> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) {
    return dio
        .get(path,
            queryParameters: queryParameters,
            options: options,
            cancelToken: cancelToken,
            onReceiveProgress: onReceiveProgress)
        .then(handleResponse)
        .onError(handleException);
  }

  Future<MyResponse> post(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return dio
        .post(path,
            data: data,
            queryParameters: queryParameters,
            options: options,
            cancelToken: cancelToken,
            onSendProgress: onSendProgress,
            onReceiveProgress: onReceiveProgress)
        .then(handleResponse)
        .onError(handleException);
  }

  FutureOr<MyResponse> getWithAuth(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) {
    options = buildHeaderToken(options);
    if (options == null) {
      return MyResponse(
        errorCode: 401,
        errorMessage: "Not login yet",
      );
    }
    return dio
        .get(path,
            queryParameters: queryParameters,
            options: options,
            cancelToken: cancelToken,
            onReceiveProgress: onReceiveProgress)
        .then(handleResponse)
        .onError(handleException);
  }

  FutureOr<MyResponse> postWithAuth(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    options = buildHeaderToken(options);
    if (options == null) {
      return MyResponse(
        errorCode: 401,
        errorMessage: "Not login yet",
      );
    }
    return dio
        .post(path,
            data: data,
            queryParameters: queryParameters,
            options: options,
            cancelToken: cancelToken,
            onSendProgress: onSendProgress,
            onReceiveProgress: onReceiveProgress)
        .then(handleResponse)
        .onError(handleException);
  }
}

final myAPIWrapper = APIWrapper();
