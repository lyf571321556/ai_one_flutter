import 'package:flutter/material.dart';

class ProjectPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProjectPageContentState();
  }
}

class _ProjectPageContentState extends State<ProjectPage> with AutomaticKeepAliveClientMixin{
  bool _clicked = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      alignment: Alignment.center,
      child: InkWell(
        child: Text(_clicked ? "project page" : "project click page"),
        onTap: () {
          setState(() {
            _clicked = !_clicked;
          });
        },
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
