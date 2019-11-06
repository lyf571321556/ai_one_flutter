import 'dart:async';

import 'package:dio/dio.dart';
import 'package:ones_ai_flutter/common/config/app_config.dart';
import 'package:ones_ai_flutter/common/net/dio/http_code.dart';
import 'package:ones_ai_flutter/common/net/dio/http_result.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../interceptors/token_interceptor.dart';

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
    _initClient();
  }

  static HttpManager _sharedInstance() {
    if (_instance == null) {
      _instance = HttpManager._internal();
    }
    return _instance;
  }

  static HttpManager getInstance() => new HttpManager();

  void _initClient() {
    BaseOptions baseOption = new BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: CONNECT_TIMEOUT,
        receiveTimeout: READ_TIMEOUT,
        sendTimeout: WRITE_TIMEOUT);
    _httpClient = new Dio(baseOption);
    if (!Config.RELEASE) {
      _httpClient.interceptors
          .add(PrettyDioLogger(responseHeader: true, requestBody: true));
    }
    _httpClient.interceptors.add(_tokenInterceptors);
  }

  clearAuthorization() {
    print("dio clearAuthorization start");
    _tokenInterceptors.clearAuthorization();
    print("dio clearAuthorization end");
  }

  initAuthorization(String userId, String token) {
    print("dio initAuthorization start");
    _tokenInterceptors.withUserId(userId).withToken(token);
    print("dio initAuthorization end");
  }

  Future<HttpResult<dynamic>> get(String url,
      {Map<String, dynamic> pathParams, CancelToken token}) async {
    return _request(url,
        httpMethod: HttpMethod.GET, pathParams: pathParams, token: token);
  }

  bool handleError(Response response) {
    if (response.statusCode == HttpCode.SUCCEED) {
      return true;
    } else {
      return false;
    }
  }

  Future<HttpResult> post(String url,
      //FutureOr<T> task(Response value)
      {Map<String, dynamic> pathParams,
      Map<String, dynamic> bodyParams,
      FormData formData,
      CancelToken token}) async {
    assert(bodyParams != null);
    return await _request(url,
        httpMethod: HttpMethod.POST,
        pathParams: pathParams,
        bodyParams: bodyParams,
        formData: formData,
        token: token);
//            .then((response) {
//      if (response == null) {
//        return Future.value(null);
//      }
//      R data = null;
//      if (resultCallBack != null) {
//        data = resultCallBack.onParseData(response);
//      }
//      return Future.value(data);
//    }).then((r) {
//      if (resultCallBack != null && r != null) {
//        resultCallBack.OnSuccess(r);
//      }
//      return Future.value(r);
//    })
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

  Future<HttpResult> upload(String url,
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

  Future<HttpResult> _request(
    String url, {
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
    HttpResult httpResult = new HttpResult();
    if (pathParams != null && pathParams.isNotEmpty) {
      pathParams.forEach((key, value) {
        if (url.indexOf(key) != -1) {
          url = url.replaceAll('{$key}', Uri.encodeComponent(value));
        }
      });
    }
    HttpResult catchError(DioError e) {
      HttpResult httpResult = new HttpResult();
      if (e.response != null) {
        httpResult.statusCode = e.response.statusCode;
        httpResult.statusMessage = e.response.statusMessage;
        httpResult.data = e.response.data;
      }
      switch (e.type) {
        case DioErrorType.RECEIVE_TIMEOUT:
          httpResult.statusCode = HttpCode.INVALID_NETWORK_CODE;
          break;
        case DioErrorType.CONNECT_TIMEOUT:
          httpResult.statusCode = HttpCode.INVALID_NETWORK_CODE;
          break;
        case DioErrorType.SEND_TIMEOUT:
          httpResult.statusCode = HttpCode.INVALID_NETWORK_CODE;
          break;
        case DioErrorType.RESPONSE:
          break;
        case DioErrorType.CANCEL:
          httpResult.statusCode = HttpCode.CANCEL_ERROR_CODE;
          break;
        case DioErrorType.DEFAULT:
          if (e.error != null) {
//            if (e.error is SocketException) {
//              httpResult.statusCode = HttpCode.INVALID_NETWORK_CODE;
//              httpResult.statusMessage =
//                  (e.error as SocketException).toString();
//            } else {
            httpResult.statusCode = HttpCode.UNKNOW_ERROR_CODE;
            httpResult.statusMessage = e.error.toString();
//            }
          }
          break;
      }
      return httpResult;
    }

    Response response;
    try {
      if (httpMethod == HttpMethod.POST) {
        response = await _httpClient.post(url,
            data: formData ?? bodyParams,
            onSendProgress: onSendprogressCallBack,
            onReceiveProgress: onReceiveProgressCallBack,
            cancelToken: token,
            options: Options(method: HttpMethod.POST.toString()));
//            .catchError((Object err) {
//          if (resultCallBack != null) {
//            resultCallBack.onError(catchError(err));
//          }
//          //response = catchError(err);
//        });
      } else {
        response = await _httpClient.get(
          url,
          cancelToken: token,
          options: Options(method: HttpMethod.GET.toString()),
        );
//            .catchError((Object err) {
//          if (resultCallBack != null) {
//            resultCallBack.onError(catchError(err));
//          }
//          //response = catchError(err);
//        });
      }
      httpResult.statusCode = response.statusCode;
      httpResult.statusMessage = response.statusMessage;
      httpResult.data = response.data;
    } on DioError catch (e) {
      httpResult = catchError(e);
    }
    return Future.value(httpResult);
  }
}
