import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:ones_ai_flutter/common/routes/page_route.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WikiListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _WikiListPageContentState();
  }
}

class _WikiListPageContentState extends State<WikiListPage>
    with AutomaticKeepAliveClientMixin {
  final flutterWebViewPlugin = FlutterWebviewPlugin();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //assets/html/index.html
    return Container(
      alignment: Alignment.center,
//      child: RaisedButton(onPressed: (){
//        flutterWebViewPlugin.launch(
//          selectedUrl,
//          wi
//          rect: Rect.fromLTWH(
//              0.0, 0.0, MediaQuery.of(context).size.width, 300.0),
//          userAgent: kAndroidUserAgent,
//          invalidUrlRegex:
//          r'^(https).+(twitter)', // prevent redirecting to twitter when user click on its icon in flutter website
//        );
//      },child: Text("webview"),),
      child: RaisedButton(
        onPressed: () {
          PageRouteManager.openNewPage(
              context, PageRouteManager.themeWebViewPath);
        },
        child: Text("open"),
      ),
//      child: WebView(
//          initialUrl: "",
//          javascriptMode: JavascriptMode.unrestricted,
//          onWebViewCreated: (WebViewController web) {
//            _loadHtmlFromAssets(web);
//          },
//          javascriptChannels: <JavascriptChannel>[
//            _alertJavascriptChannel(context),
//          ].toSet(),
//          onPageFinished: (value) {}),
    );
  }

  void _loadHtmlFromAssets(WebViewController webViewController) async {
    String fileHtmlContents =
        await rootBundle.loadString("assets/html/index.html");
    webViewController.loadUrl(Uri.dataFromString(fileHtmlContents,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    flutterWebViewPlugin.close();
  }
}

JavascriptChannel _alertJavascriptChannel(BuildContext context) {
  return JavascriptChannel(
      name: 'Toast',
      onMessageReceived: (JavascriptMessage message) {
        print("flutter" + message.message);
      });
}
