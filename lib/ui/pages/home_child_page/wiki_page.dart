import 'package:flutter/material.dart';

class WikiPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _WikiPageContentState();
  }
}

class _WikiPageContentState extends State<WikiPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      alignment: Alignment.center,
      child: Text("wiki page"),
    );
  }
}
