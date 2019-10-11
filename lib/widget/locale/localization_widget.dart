import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ones_ai_flutter/common/redux/global/ones_state.dart';

class LocalizationsWidget extends StatefulWidget {
  final Widget child;

  LocalizationsWidget({Key key, this.child}) : super(key: key);

  @override
  State<LocalizationsWidget> createState() {
    return new _LocalizationsWidgetState();
  }
}

class _LocalizationsWidgetState extends State<LocalizationsWidget> {
//  StreamSubscription stream;

  @override
  Widget build(BuildContext context) {
    return new StoreBuilder<OnesGlobalState>(builder: (context, store) {
      ///通过 StoreBuilder 和 Localizations 实现实时多语言切换
      return new Localizations.override(
        context: context,
        locale: store.state.locale,
        child: widget.child,
      );
    });
  }

  @override
  void initState() {
    super.initState();
//    stream = eventBus.on<HttpErrorEvent>().listen((event) {
//      errorHandleFunction(event.code, event.message);
//    });
  }

  @override
  void dispose() {
    super.dispose();
//    if (stream != null) {
//      stream.cancel();
//      stream = null;
//    }
  }

//  errorHandleFunction(int code, message) {
//    switch (code) {
//      case Code.NETWORK_ERROR:
//        Fluttertoast.showToast(
//            msg: CommonUtils.getLocale(context).network_error);
//        break;
//      case 401:
//        Fluttertoast.showToast(
//            msg: CommonUtils.getLocale(context).network_error_401);
//        break;
//      case 403:
//        Fluttertoast.showToast(
//            msg: CommonUtils.getLocale(context).network_error_403);
//        break;
//      case 404:
//        Fluttertoast.showToast(
//            msg: CommonUtils.getLocale(context).network_error_404);
//        break;
//      case Code.NETWORK_TIMEOUT:
//        //超时
//        Fluttertoast.showToast(
//            msg: CommonUtils.getLocale(context).network_error_timeout);
//        break;
//      default:
//        Fluttertoast.showToast(
//            msg: CommonUtils.getLocale(context).network_error_unknown +
//                " " +
//                message);
//        break;
//    }
//  }
}
