class HttpCode {
  static final int PARSE_DATA_ERROR_CODE = -4;
  static final int CANCEL_ERROR_CODE = -3;
  static final int UNKNOW_ERROR_CODE = -2;
  static final int INVALID_NETWORK_CODE = -1;

  static final int SUCCEED = 200;

  static final int BAD_REQUEST = 400;
  static final int INVALID_TOKEN = 401;
  static final int UNAUTHORISED_ACCESS = 403;
  static final int RESOURCE_NOT_EXIST = 404;
  static final int ACCOUNT_EXIST_ALREADY = 409;

  static final int SERVER_ERROR = 500;
  static final int BAD_GATEWAY = 502;

  ///INVALID HTTP CODE,
  static final int INVALID_EMAIL_ADDRESS = 600;
  static final int WRONG_ACCOUNT_PASSWORD_PAIR = 603;
  static final int SERVER_TIMEOUT = 604;
  static final int WRONG_VERIFICATION_CODE = 605;
  static final int VERIFICATION_CODE_EXPIRED = 606;

  static final int ACCOUNT_NOT_REGISTERED = 615;
  static final int WRONG_VERIFICATION_CODE_V2 = 616;
  static final int VERIFICATION_CODE_EXPIRED_V2 = 616;

  static final int ACCOUNT_NOT_REGISTERED_V2 = 630;

  static final int PARAM_INVALID = 801;
  static final int CAPACITY_EXCEEDED = 833;

  static final int NO_MATCH_RECORD = 830;

  static final int ACCOUNT_EXPIRED = 813;
  static final int ACCOUNT_NO_GROUP = 814;

  ///INVALID HTTP CODE,
}
