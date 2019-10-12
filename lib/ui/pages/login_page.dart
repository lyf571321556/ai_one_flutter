import 'package:fluintl/fluintl.dart';
import 'package:flutter/material.dart';
import 'package:ones_ai_flutter/resources/index.dart';
import 'package:ones_ai_flutter/utils/utils_index.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(IntlUtil.getString(context, Strings.titleLogin)),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            width: 80,
            height: 80,
            margin: EdgeInsets.only(top: 60.0, bottom: 10.0),
            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage("assets/images/ones_icon.png"),
              ),
            ),
          ),
          SizedBox(height: 40.0),
          Card(
            margin: EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _buildAccountTextField(),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildAccountTextField() {
    return TextFormField(
      style: TextStyle(
        color: Colors.black,
        fontSize: 18,
      ),
      autofocus: false,
      controller: _accountController,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 4),
          border: UnderlineInputBorder(
              borderSide: BorderSide(width: double.infinity)),
          hintStyle: TextStyle(fontSize: 14),
          hintText: "手机号或者邮箱",
          prefixIcon: Icon(Icons.person),
          suffixIcon: IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                _accountController.clear();
              })),
      validator: (value) {
        return value.trim().length >= 8 ? null : "用户名至少为8位!";
      },
    );
  }
}
