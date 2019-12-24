
import 'dart:html';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WebViewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ui.platformViewRegistry.registerViewFactory(
        'hello-world-html',
        (int viewId) => IFrameElement()
          ..width = '640'
          ..height = '360'
          ..src = 'https://www.baidu.com/'
          ..style.border = 'none');

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
          title: new Text(
            "新页面",
            style: new TextStyle(fontSize: 16.0),
          )) ,
      body: Container(
          color: Colors.orange,
//          child: RaisedButton(onPressed: () {
//            _launchURL();
//          },child: Text("open"),)
//        child: RaisedButton(onPressed: () {
//          js.context
//              .callMethod("open", ["https://stackoverflow.com/questions/ask"]);
//        },child: Text("open"),)
      child: HtmlElementView(
        viewType: "hello-world-html",
      ),
      ),
    );
  }
//
//  void _loadHtmlFromAssets(WebViewController webViewController) async {
//    String fileHtmlContents =
//        await rootBundle.loadString("assets/html/index.html");
//    webViewController.loadUrl(Uri.dataFromString(fileHtmlContents,
//            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
//        .toString());
//  }

  _launchURL() async {
    const url = 'https://flutter.io';
    print(url);
    if (await canLaunch(url)) {
      print("launch");
      await launch(url);
    } else {
      print("throw");
      throw 'Could not launch $url';
    }
  }
}
