
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
//class WebViewPage extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
////    ui.platformViewRegistry.registerViewFactory(
////        'hello-world-html',
////        (int viewId) => IFrameElement()
////          ..width = '640'
////          ..height = '360'
////          ..src = 'https://www.youtube.com/embed/IyFZznAk69U'
////          ..style.border = 'none');
//
//    // TODO: implement build
//    return Scaffold(
//      appBar: AppBar(
//          title: new Text(
//            "新页面",
//            style: new TextStyle(fontSize: 16.0),
//          )) ,
//      body: Container(
//          color: Colors.orange,
//          child: RaisedButton(onPressed: () {
//            _launchURL();
//          },child: Text("open"),)
////        child: RaisedButton(onPressed: () {
////          js.context
////              .callMethod("open", ["https://stackoverflow.com/questions/ask"]);
////        },child: Text("open"),)
////      child: HtmlElementView(
////        viewType: "hello-world-html",
////      ),
//      ),
//    );
//  }
////
////  void _loadHtmlFromAssets(WebViewController webViewController) async {
////    String fileHtmlContents =
////        await rootBundle.loadString("assets/html/index.html");
////    webViewController.loadUrl(Uri.dataFromString(fileHtmlContents,
////            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
////        .toString());
////  }
//
//  _launchURL() async {
//    const url = 'https://flutter.io';
//    print(url);
//    if (await canLaunch(url)) {
//      print("launch");
//      await launch(url);
//    } else {
//      print("throw");
//      throw 'Could not launch $url';
//    }
//  }
//}



class WebViewPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return WebViewPageState();
  }
}

class WebViewPageState extends State<WebViewPage> {
  JavascriptChannel _alertJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toast',
        onMessageReceived: (JavascriptMessage message) {
          print("Toast调用消息哈哈哈:"+message.message);
        });
  }

  final Completer<WebViewController> _controller =
  Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter WebView example'),
      ),
      body: Builder(builder: (BuildContext context) {
        return WebView(
          initialUrl: 'http://192.168.1.213:8080/',//加载assets/html/js_flutter_call_each_other.html资源测试flutter和js互相调用
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
//            _controller = webViewController;
            _controller.complete(webViewController);
          },
          javascriptChannels: <JavascriptChannel>[
            _alertJavascriptChannel(context),
          ].toSet(),
          navigationDelegate: (NavigationRequest request) {
            if (request.url.startsWith('js://webview')) {
              print('blocking navigation to $request}');
              return NavigationDecision.prevent;
            }
            print('allowing navigation to $request');
            return NavigationDecision.navigate;
          },
          onPageFinished: (String url) {
            print('Page finished loading: $url');
          },
        );
      }),
      floatingActionButton: jsButton(),
    );
  }

  Widget jsButton() {
    return FutureBuilder<WebViewController>(
        future: _controller.future,
        builder: (BuildContext context,
            AsyncSnapshot<WebViewController> controller) {
          if (controller.hasData) {
            return FloatingActionButton(
              onPressed: () async {
                _controller.future.then((controller) {
                  controller
                      .evaluateJavascript('callJS("visible")')
                      .then((result) {});
                });
              },
              child: Text('call JS'),
            );
          }
          return Container();
        });
  }
}