import 'http_code.dart';

class HttpResult<T> {
  int statusCode = HttpCode.UNKNOW_ERROR_CODE;
  String statusMessage;
  T data;
  String errorMsg;

  bool get isSuccess => statusCode == HttpCode.SUCCEED;
}
