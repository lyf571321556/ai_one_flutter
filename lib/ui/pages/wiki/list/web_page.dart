import 'dart:ui' as ui;
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WebViewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ui.platformViewRegistry.registerViewFactory(
        'hello-world-html',
        (int viewId) => html.IFrameElement()
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


//通过iframe加载外部页面
class WebIframePage extends StatelessWidget {
  // This widget is the root of your application.

  void jsAlert(String msg) {
//    js.context.callMethod('alert', [msg]);
  }

  @override
  Widget build(BuildContext context) {
    // final viewType = 'editor-html';
    final iframe = html.IFrameElement()
      ..width = '640'
      ..height = '360'
    // ..src = './assets/assets/single.html'
      ..src = './assets/assets/html/index.html'
      ..id = 'rtxeditor'
      ..name = 'rtxeditor'
      ..style.border = 'none';
    // html.window.addEventListener('JSEvent', (event) {
    //   if (event is html.CustomEvent) {
    //     final detail = event.detail;
    //     jsAlert(event.detail.toString());
    //   }
    // });
    html.window.addEventListener('message', (event) {
      print('1111');
      print(event);
      if (event is html.MessageEvent) {
        final msg = event.data.toString();
        print('Flutter print: $msg');
        jsAlert(msg);
      }
    });

    ui.platformViewRegistry.registerViewFactory('editor-html', (int viewId) => iframe);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Yay!'),
          actions: <Widget>[
            new IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                // final event = html.Event("FLTEvent");
                // final result = iframe.contentWindow.dispatchEvent(event);
                // if(!result) {
                //   jsAlert('dispatch Failed!');
                // }
                iframe.contentWindow.postMessage('{"event":"setEditorContent","param":"aaaa"}', '*');
              },
            )
          ],
        ),
        body: HtmlElementView(viewType: 'editor-html'),
      ),
    );
  }
}