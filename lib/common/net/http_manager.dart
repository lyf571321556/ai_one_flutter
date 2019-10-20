import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:ones_ai_flutter/common/net/http_code.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'interceptors/token_interceptor.dart';

class ResultCallBack<E, T> {
  onError(E error) {}

  OnSuccess(T data) {}

  T onParseData(Response response) {}
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
        .add(PrettyDioLogger(responseHeader: true, requestBody: true));
    _httpClient.interceptors.add(_tokenInterceptors);
  }

  clearAuthorization() {
    _tokenInterceptors.clearAuthorization();
  }

  Future<Response<dynamic>> get(String url,
      {Map<String, dynamic> pathParams, CancelToken token}) async {
    return _request(url, null,
        httpMethod: HttpMethod.GET, pathParams: pathParams, token: token);
  }

  bool handleError(Response response) {
    if (response.statusCode == HttpCode.SUCCEED) {
      return true;
    } else {
      return false;
    }
  }

  Future<R> post<R>(String url, //FutureOr<T> task(Response value)
      {ResultCallBack resultCallBack,
      Map<String, dynamic> pathParams,
      Map<String, dynamic> bodyParams,
      FormData formData,
      CancelToken token}) async {
    assert(bodyParams != null);
    return await _request(url, resultCallBack,
                httpMethod: HttpMethod.POST,
                pathParams: pathParams,
                bodyParams: bodyParams,
                formData: formData,
                token: token)
            .then((response) {
      if (response == null) {
        return Future.value(null);
      }
      R data = null;
      if (resultCallBack != null) {
        data = resultCallBack.onParseData(response);
      }
      return Future.value(data);
    }).then((r) {
      if (resultCallBack != null && r != null) {
        resultCallBack.OnSuccess(r);
      }
      return Future.value(r);
    })
//        .catchError((error) {
//      print("catchErrorcatchErrorcatchError");
//      print(error);
////      response.statusCode = HttpCode.PARSE_DATA_ERROR_CODE;
////      response.statusMessage = error.toString();
////      resultCallBack.onError(response);
//    });
        ;
//        .then(task)
//        .catchError((error) {
//          print("处理数据错误：" + error.toString());
//        });
  }

  Future<Response<T>> upload<T>(String url,
      {Map<String, dynamic> pathParams,
      FormData formData,
      ProgressCallback onSendprogressCallBack,
      ProgressCallback onReceiveProgressCallBack,
      CancelToken token}) async {
    assert(formData != null);
    return _request(url, null,
        httpMethod: HttpMethod.POST,
        pathParams: pathParams,
        formData: formData,
        onSendprogressCallBack: onSendprogressCallBack,
        onReceiveProgressCallBack: onReceiveProgressCallBack,
        token: token);
  }

  Future<Response> _request(
    String url,
    ResultCallBack resultCallBack, {
    Options option,
    HttpMethod httpMethod,
    Map<String, dynamic> pathParams,
    Map<String, dynamic> bodyParams,
    FormData formData,
    ProgressCallback onSendprogressCallBack,
    ProgressCallback onReceiveProgressCallBack,
    CancelToken token,
  }) async {
    assert(url != null && url.length > 0);
    if (pathParams != null && pathParams.isNotEmpty) {
      pathParams.forEach((key, value) {
        if (url.indexOf(key) != -1) {
          url = url.replaceAll('{$key}', Uri.encodeComponent(value));
        }
      });
    }
    Response catchError(DioError e) {
      Response response_ = new Response();
      if (e.response != null) {
        response_ = e.response;
      } else {
        response_ = new Response(statusCode: HttpCode.UNKNOW_ERROR_CODE);
      }
      switch (e.type) {
        case DioErrorType.RECEIVE_TIMEOUT:
          response_.statusCode = HttpCode.INVALID_NETWORK_CODE;
          break;
        case DioErrorType.CONNECT_TIMEOUT:
          response_.statusCode = HttpCode.INVALID_NETWORK_CODE;
          break;
        case DioErrorType.SEND_TIMEOUT:
          response_.statusCode = HttpCode.INVALID_NETWORK_CODE;
          break;
        case DioErrorType.RESPONSE:
          break;
        case DioErrorType.CANCEL:
          response_.statusCode = HttpCode.CANCEL_ERROR_CODE;
          break;
        case DioErrorType.DEFAULT:
          if (e.error != null) {
            if (e.error is SocketException) {
              response_.statusCode = HttpCode.INVALID_NETWORK_CODE;
              response_.statusMessage = (e.error as SocketException).toString();
            } else {
              response_.statusCode = HttpCode.UNKNOW_ERROR_CODE;
              response_.statusMessage = e.error.toString();
            }
          }
          break;
      }
      return response_;
    }

    Response response;
    try {
      if (httpMethod == HttpMethod.POST) {
        response = await _httpClient
            .post(
          url,
          data: formData ?? bodyParams,
          onSendProgress: onSendprogressCallBack,
          onReceiveProgress: onReceiveProgressCallBack,
          cancelToken: token,
        )
            .catchError((Object err) {
          if (resultCallBack != null) {
            resultCallBack.onError(catchError(err));
          }
          //response = catchError(err);
        });
      } else {
        response = await _httpClient
            .get(
          url,
          cancelToken: token,
        )
            .catchError((Object err) {
          if (resultCallBack != null) {
            resultCallBack.onError(catchError(err));
          }
          //response = catchError(err);
        });
      }
    } on DioError catch (e) {
      resultCallBack.onError(catchError(e));
      //response = catchError(e);
    }
    return Future.value(response);
  }
}
