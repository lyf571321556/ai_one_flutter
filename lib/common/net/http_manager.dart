import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:ones_ai_flutter/common/net/http_code.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'interceptors/token_interceptor.dart';

class HttpManagerBuilder {
  HttpManagerBuilder() {}

  HttpManager build() {}
}

enum HttpMethod { POST, GET }

class HttpManager {
  static final int CONNECT_TIMEOUT = 5000;
  static final int WRITE_TIMEOUT = 5000;
  static final int READ_TIMEOUT = 5000;
  static Dio _httpClient;
  static final String baseUrl = "https://devapi.myones.net/";
  final TokenInterceptor _tokenInterceptors = new TokenInterceptor();

  factory HttpManager() => _sharedInstance();

  static HttpManager _instance;

  HttpManager._internal() {
    initDio();
  }

  static HttpManager _sharedInstance() {
    if (_instance == null) {
      _instance = HttpManager._internal();
    }
    return _instance;
  }

  static HttpManager getInstance() => new HttpManager();

  void initDio() {
    BaseOptions baseOption = new BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: CONNECT_TIMEOUT,
        receiveTimeout: READ_TIMEOUT,
        sendTimeout: WRITE_TIMEOUT);
    _httpClient = new Dio(baseOption);
    _httpClient.interceptors
        .add(PrettyDioLogger(requestHeader: true, responseHeader: true));
    _httpClient.interceptors.add(_tokenInterceptors);
  }

  clearAuthorization() {
    _tokenInterceptors.clearAuthorization();
  }

  Future<Response<dynamic>> get(String url,
      {Map<String, dynamic> pathParams, CancelToken token}) async {
    return _request(url,
        httpMethod: HttpMethod.GET, pathParams: pathParams, token: token);
  }

  Future<Response<dynamic>> post(String url,
      {Map<String, dynamic> pathParams,
      Map<String, dynamic> bodyParams,
      CancelToken token}) async {
    assert(bodyParams != null);
    return _request(url,
        httpMethod: HttpMethod.POST,
        pathParams: pathParams,
        bodyParams: bodyParams,
        token: token);
  }

  Future<Response<dynamic>> upload(String url,
      {Map<String, dynamic> pathParams,
      FormData formData,
      ProgressCallback onSendprogressCallBack,
      ProgressCallback onReceiveProgressCallBack,
      CancelToken token}) async {
    assert(formData != null);
    return _request(url,
        httpMethod: HttpMethod.POST,
        pathParams: pathParams,
        formData: formData,
        onSendprogressCallBack: onSendprogressCallBack,
        onReceiveProgressCallBack: onReceiveProgressCallBack,
        token: token);
  }

  Future<Response<dynamic>> _request(
    String url, {
    HttpMethod httpMethod,
    Map<String, dynamic> pathParams,
    Map<String, dynamic> bodyParams,
    FormData formData,
    Function errorCallBack,
    ProgressCallback onSendprogressCallBack,
    ProgressCallback onReceiveProgressCallBack,
    CancelToken token,
  }) async {
    assert(url == null && url.length > 0);
    if (pathParams != null && pathParams.isNotEmpty) {
      pathParams.forEach((key, value) {
        if (url.indexOf(key) != -1) {
          url = url.replaceAll('{$key}', Uri.encodeComponent(value));
        }
      });
    }

    Response response;
    handleError(DioError e) {
      response = Response();
      if (e.response != null) {
        response = e.response;
      } else {
        response = new Response(statusCode: HttpCode.UNKNOW_ERROR_CODE);
      }
      switch (e.type) {
        case DioErrorType.RECEIVE_TIMEOUT:
          response.statusCode = HttpCode.INVALID_NETWORK_CODE;
          break;
        case DioErrorType.CONNECT_TIMEOUT:
          response.statusCode = HttpCode.INVALID_NETWORK_CODE;
          break;
        case DioErrorType.SEND_TIMEOUT:
          response.statusCode = HttpCode.INVALID_NETWORK_CODE;
          break;
        case DioErrorType.RESPONSE:
          break;
        case DioErrorType.CANCEL:
          response.statusCode = HttpCode.CANCEL_ERROR_CODE;
          break;
        case DioErrorType.DEFAULT:
          response.statusCode = HttpCode.UNKNOW_ERROR_CODE;
          break;
      }
      print("-------");
      print(e.response);
      print(e.request.headers);
      print(e.error);
      print(e.message);
      print("-------");
    }

    try {
      if (httpMethod == HttpMethod.POST) {
        response = await _httpClient
            .get(
              url,
              cancelToken: token,
            )
            .catchError((DioError err) {});
      } else {
        response = await _httpClient
            .post(
          url,
          data: formData ?? new FormData.fromMap(bodyParams),
          onSendProgress: onSendprogressCallBack,
          onReceiveProgress: onReceiveProgressCallBack,
          cancelToken: token,
        )
            .catchError((DioError err) {
          handleError(err);
//          if (CancelToken.isCancel(err)) {
//
//          } else {
//
//          }
        });
      }
    } on DioError catch (e) {
      handleError(e);
    }
    return Future.value(response);
  }
}
