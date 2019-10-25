import 'package:fluintl/fluintl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ones_ai_flutter/common/api/user_api.dart';
import 'package:ones_ai_flutter/common/config/app_config.dart';
import 'package:ones_ai_flutter/common/dao/user_dao.dart';
import 'package:ones_ai_flutter/common/redux/global/ones_state.dart';
import 'package:ones_ai_flutter/common/routes/page_route.dart';
import 'package:ones_ai_flutter/resources/font_icons.dart';
import 'package:ones_ai_flutter/resources/index.dart';
import 'package:ones_ai_flutter/widget/button/gradient_button.dart';
import 'package:redux/redux.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginPageState();
  }
}

enum LoginState { LOGIN_DEFAULT, LOGIN_SUCCESS, LOGIN_FAILED }

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  static final double _loginButtonMinWidth = 45;
  AnimationController _loginAanimationController;
  AnimationController _loginSuccessAnimationController;
  Animation<double> _loginButtonWidthAnimation;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  static bool _showPlaintext = true,
      _autoValied = false,
      _userNameValied = false,
      _passwordValied = false;
  LoginState _loginState = LoginState.LOGIN_DEFAULT;

  static String _userName, _password;

  Animation<EdgeInsets> _containerCircleAnimation;
  Animation _buttomZoomOut;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loginAanimationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    _loginButtonWidthAnimation =
        Tween<double>(begin: 1000, end: _loginButtonMinWidth).animate(
            CurvedAnimation(
                parent: _loginAanimationController,
                curve: Interval(.0, 0.25, curve: Curves.ease))
              ..addListener(() {
                if (_loginButtonWidthAnimation.isCompleted) {}
              }));
    _loginSuccessAnimationController = new AnimationController(
        duration: new Duration(milliseconds: 1500), vsync: this);
    _loginSuccessAnimationController.addListener(() {
      if (_loginSuccessAnimationController.isCompleted) {
        PageRouteManager.openNewPage(context, PageRouteManager.homePagePath,
            replace: true);
      }
    });
    _buttomZoomOut = new Tween(
      begin: _loginButtonMinWidth,
      end: 1000.0,
    ).animate(
      new CurvedAnimation(
        parent: _loginSuccessAnimationController,
        curve: new Interval(
          0.550,
          0.999,
          curve: Curves.bounceOut,
        ),
      ),
    );
    _containerCircleAnimation = new EdgeInsetsTween(
      begin: const EdgeInsets.only(bottom: 50.0),
      end: const EdgeInsets.only(bottom: 0.0),
    ).animate(
      new CurvedAnimation(
        parent: _loginSuccessAnimationController,
        curve: new Interval(
          0.500,
          0.800,
          curve: Curves.ease,
        ),
      ),
    );
    _accountController.text = "huangjinfan+5001@ones.ai";
    _passwordController.text = "11111111";
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _loginAanimationController.dispose();
    _loginSuccessAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
//        appBar: AppBar(
//          centerTitle: true,
//          title: Text(IntlUtil.getString(context, Strings.titleLogin)),
//        ),
        body: Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child:
                ListView(padding: const EdgeInsets.all(0.0), children: <Widget>[
              Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  new Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SizedBox(height: MediaQuery.of(context).padding.top),
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
                      Form(
                        key: _formKey,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 18),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              _buildAccountTextField(),
                              SizedBox(height: _userNameValied ? 10 : 10),
                              _buildPasswordTextField(),
                              _buildForgetPasswordWidget(),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 60.0),
                    ],
                  ),
                  _buildLoginWidget()
//              _loginState == LoginState.LOGIN_SUCCESS
//                  ? new LoginSuccessStaggerWidget(
//                      buttonController: _loginSuccessAnimationController.view)
//                  : Padding(padding: EdgeInsets.all(0))
                ],
              )
            ])));
    //            _loginState == LoginState.LOGIN_SUCCESS
//                ? LoginSuccessStaggerWidget(
//                    buttonController: _loginSuccessAnimationController.view)
//                : Padding(padding: EdgeInsets.all(0))
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
      autovalidate: _autoValied,
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
        _userNameValied = accountReg.hasMatch(value);
        return _userNameValied
            ? null
            : IntlUtil.getString(context, Strings.titleAccountError);
      },
    );
  }

  Widget _buildPasswordTextField() {
    return Container(
      margin: EdgeInsets.only(bottom: _passwordValied ? 12 : 12),
      child: TextFormField(
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
        autovalidate: _autoValied,
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
                icon: Icon(_showPlaintext
                    ? FontIcons.CLOSED_EYE
                    : FontIcons.OPEND_EYE),
                onPressed: () {
                  setState(() {
                    _showPlaintext = !_showPlaintext;
                  });
                })),
        validator: (value) {
          var passwordReg =
              RegExp(r"^(?=.*\d)(?=.*[a-zA-Z])[\x21-\x7E]{8,32}$");
          _passwordValied = value != null &&
              value.length >= 8; // passwordReg.hasMatch(value);
          return _passwordValied
              ? null
              : IntlUtil.getString(context, Strings.titlePasswordError);
        },
      ),
    );
  }

  Widget _buildForgetPasswordWidget() {
    return Container(
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
    Store<OnesGlobalState> store = StoreProvider.of(context);
    return Hero(
        tag: Config.LOGIN_HERO_TAG,
        child: AnimatedBuilder(
          animation: _loginState == LoginState.LOGIN_SUCCESS
              ? _loginSuccessAnimationController
              : _loginAanimationController,
          builder: (context, child) {
            return Container(
              height: _loginState == LoginState.LOGIN_SUCCESS
                  ? _buttomZoomOut.value
                  : _loginButtonMinWidth,
              width: _loginState == LoginState.LOGIN_SUCCESS
                  ? _buttomZoomOut.value
                  : _loginButtonWidthAnimation.value,
              decoration: BoxDecoration(
                  shape: _buttomZoomOut.value < 500
                      ? BoxShape.circle
                      : BoxShape.rectangle,
                  color: Theme.of(context).primaryColor),
              alignment: Alignment.center,
              child: _loginState == LoginState.LOGIN_SUCCESS
                  ? null
                  : _loginButtonWidthAnimation.value > _loginButtonMinWidth
                      ? Padding(
                          padding: EdgeInsets.symmetric(horizontal: 18),
                          child: GradientButton(
                            child: Text(
                                IntlUtil.getString(context, Strings.titleLogin),
                                style: TextStyle(fontSize: 16)),
                            borderRadius: BorderRadius.circular(8),
                            onPressed: () async {
                              _autoValied = true;
                              if (!_formKey.currentState.validate()) {
                              } else {
                                await _loginAanimationController
                                    .forward()
                                    .orCancel;
                                _formKey.currentState.save();
                                UserApi.login(_userName, _password, null)
                                    .then((result) async {
                                  if (result.isSuccess) {
                                    print(result.data.email);
                                    setState(() {
                                      _loginState = LoginState.LOGIN_SUCCESS;
                                    });
                                    await UserDao.saveLoginUserInfo(
                                        result.data, store);
                                    await _playLoginSuccessAnimation();
                                  } else {
                                    setState(() {
                                      _loginState = LoginState.LOGIN_FAILED;
                                    });
                                    await _loginAanimationController
                                        .reverse()
                                        .orCancel;
                                    Fluttertoast.showToast(
                                        msg: "login failed,please retry!");
                                  }
                                });
                              }
                            },
                            childPadding: EdgeInsets.symmetric(vertical: 8),
                          ),
                        )
                      : CircularProgressIndicator(
                          valueColor:
                              new AlwaysStoppedAnimation<Color>(Colors.white),
                          strokeWidth: 2,
                        ),
            );
          },
        ));
  }

  void _playLoginSuccessAnimation() async {
    try {
      await _loginSuccessAnimationController.forward().orCancel;
      await _loginSuccessAnimationController.reverse().orCancel;
    } on TickerCanceled {}
  }
}
