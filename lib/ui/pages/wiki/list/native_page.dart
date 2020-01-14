import 'package:flutter/material.dart';

class WebViewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
            title: new Text(
          "新页面",
          style: new TextStyle(fontSize: 16.0),
        )),
        body: Container(
            color: Colors.orange,
            child: RaisedButton(
              onPressed: () {},
              child: Text("open"),
            )));
  }
}
