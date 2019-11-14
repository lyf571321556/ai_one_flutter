import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      alignment: Alignment.center,
      child: WebView(
          initialUrl: "assets/html/index.html",
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController web) {},
          javascriptChannels: <JavascriptChannel>[
            _alertJavascriptChannel(context),
          ].toSet(),
          onPageFinished: (value) {}),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

JavascriptChannel _alertJavascriptChannel(BuildContext context) {
  return JavascriptChannel(
      name: 'Toast',
      onMessageReceived: (JavascriptMessage message) {
        print("flutter" + message.message);
      });
}
