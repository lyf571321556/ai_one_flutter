import 'package:fluintl/fluintl.dart';
import 'package:flutter/material.dart';
import 'package:ones_ai_flutter/resources/font_icons.dart';
import 'package:ones_ai_flutter/resources/index.dart';
import 'package:ones_ai_flutter/utils/utils_index.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ones_ai_flutter/widget/button/gradient_button.dart';

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
  static bool _showPlaintext = true, _autoValied = false;
  static String _userName, _password;

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
          SizedBox(height: 20.0),
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
                    SizedBox(height: _autoValied ? 8 : 10.0),
                    _buildPasswordTextField(),
                    _buildForgetPasswordWidget(),
                    _buildLoginWidget()
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
      onSaved: (String value) {
        _userName = value;
      },
      keyboardType: TextInputType.text,
      maxLines: 1,
      style: TextStyle(
        color: Colors.black,
        fontSize: 18,
      ),
      autofocus: false,
      autovalidate: true,
      controller: _accountController,
      decoration: InputDecoration(
          border: UnderlineInputBorder(
              borderSide: BorderSide(width: double.infinity)),
          hintStyle: TextStyle(
            fontSize: 14,
          ),
          hintText: IntlUtil.getString(context, Strings.titleAccountHint),
          prefixIcon: Icon(
            FontIcons.ACCOUNT,
            size: 25,
          ),
          suffixIcon: IconButton(
              icon: Icon(FontIcons.CANCLE),
              onPressed: () {
//                _accountController.clear();
                WidgetsBinding.instance
                    .addPostFrameCallback((_) => _accountController.clear());
              })),
      validator: (value) {
        var accountReg = RegExp(
            r"[\w!#$%&'*+/=?^_`{|}~-]+(?:\.[\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\w](?:[\w-]*[\w])?\.)+[\w](?:[\w-]*[\w])?");

        return accountReg.hasMatch(value)
            ? null
            : IntlUtil.getString(context, Strings.titleAccountError);
      },
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      onSaved: (String value) {
        _password = value;
      },
      keyboardType: TextInputType.text,
      maxLines: 1,
      style: TextStyle(
        color: Colors.black,
        fontSize: 18,
      ),
      autofocus: false,
      autovalidate: true,
      controller: _passwordController,
      obscureText: _showPlaintext,
      decoration: InputDecoration(
          border: UnderlineInputBorder(
              borderSide: BorderSide(width: double.infinity)),
          hintStyle: TextStyle(
            fontSize: 14,
          ),
          hintText: IntlUtil.getString(context, Strings.titlePasswordHint),
          prefixIcon: Icon(
            FontIcons.PASSWORD,
            size: 25,
          ),
          suffixIcon: IconButton(
              icon: Icon(
                  _showPlaintext ? FontIcons.CLOSED_EYE : FontIcons.OPEND_EYE),
              onPressed: () {
                setState(() {
                  _showPlaintext = !_showPlaintext;
                });
              })),
      validator: (value) {
        var passwordReg = RegExp(r"^(?=.*\d)(?=.*[a-zA-Z])[\x21-\x7E]{8,32}$");

        return passwordReg.hasMatch(value)
            ? null
            : IntlUtil.getString(context, Strings.titlePasswordError);
      },
    );
  }

  Widget _buildForgetPasswordWidget() {
    return Container(
      margin: EdgeInsets.only(top: _autoValied ? 5 : 5),
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: () {
          Fluttertoast.showToast(msg: "to do!");
        },
        child: Text(
          IntlUtil.getString(
            context,
            Strings.titleForgetPassword,
          ),
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Theme.of(context).primaryColor,
              decorationStyle: TextDecorationStyle.solid,
              decoration: TextDecoration.underline),
        ),
      ),
    );
  }

  Widget _buildLoginWidget() {
    return Container(
      child: GradientButton(
        child: Text(IntlUtil.getString(context, Strings.titleLogin),
            style: TextStyle(fontSize: 16)),
        borderRadius: BorderRadius.circular(8),
        onPressed: () {
          if (!_formKey.currentState.validate()) {
            setState(() {
              _autoValied = true;
            });
          } else {
            setState(() {
//              _autoValied = false;
            });
            _formKey.currentState.save();
          }
          print(_userName);
          print(_password);
          Fluttertoast.showToast(msg: "login start!");
        },
        childPadding: EdgeInsets.symmetric(vertical: 11),
      ),
      margin: EdgeInsets.only(top: 18, bottom: 5),
    );
  }
}
