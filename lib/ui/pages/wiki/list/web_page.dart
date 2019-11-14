import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebViewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WebviewScaffold(
      appBar: new AppBar(
        title: new Text("Widget webview"),
      ),
      url: "assets/html/index.html",
      allowFileURLs: true,
      withLocalUrl: true,
      withLocalStorage: true,
    );
  }
}
