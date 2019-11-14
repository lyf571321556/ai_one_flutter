//import 'dart:async';
//
//import 'package:graphql_flutter/graphql_flutter.dart';
//import 'package:ones_ai_flutter/common/dao/user_dao.dart';
//import 'package:ones_ai_flutter/models/account/user.dart';
//
//class GraphqlManager {
//  factory GraphqlManager() => _sharedInstance();
//  String _userId, _token;
//  GraphQLClient _graphQLClient;
//  static GraphqlManager _instance;
//
//  GraphqlManager._internal() {
//    _initClient();
//  }
//
//  static GraphqlManager _sharedInstance() {
//    if (_instance == null) {
//      _instance = GraphqlManager._internal();
//    }
//    return _instance;
//  }
//
//  static GraphqlManager getInstance() => new GraphqlManager();
//
//  void _initClient() {
//    print("graphql _initClient start");
//    final HttpLink _httpLink = HttpLink(
//        uri:
//            'https://devapi.myones.net/project/master/api/project/team/DaXf8REY/items/graphql',
//        headers: <String, String>{
//          'Ones-User-Id': _userId,
//          'Ones-Auth-Token': _token,
//          "Access-Control-Allow-Origin": "*"
//        });
//    print("graphql _initClient mid");
////    final Link _link = _onesAuthLink.concat(_httpLink);
//    _graphQLClient = GraphQLClient(
//      cache: OptimisticCache(
//        dataIdFromObject: typenameDataIdFromObject,
//      ),
//      link: _httpLink,
//    );
//
//    print("graphql _initClient endr");
//  }
//
//  initAuthorization(String userId, String token) {
//    print("graphql initAuthorization start");
//    _userId = userId;
//    _token = token;
//    _initClient();
//    print("graphql initAuthorization end");
//  }
//
//  clearAuthorization() {
//    print("graphql clearAuthorization start");
//    _userId = null;
//    _token = null;
//    _initClient();
//    print("graphql clearAuthorization end");
//  }
//
//  GraphQLClient getClient() {
//    return _graphQLClient;
//  }
//}
////
////class OnesAuthLink extends Link {
////  String userId, userToken;
////
////  OnesAuthLink({this.userId, this.userToken})
////      : super(
////          request: (Operation operation, [NextLink forward]) {
////            StreamController<FetchResult> controller;
////
////            Future<void> onListen() async {
////              try {
////                User user = await UserDao.getUserInfo()();
////                if (user != null) {
////                  userId = user.uuid;
////                  userToken = user.token;
////                }
////
////                operation.setContext(<String, Map<String, String>>{
////                  'headers': <String, String>{
////                    'Ones-User-Id': userId,
////                    'Ones-Auth-Token': userToken
////                  }
////                });
////              } catch (error) {
////                controller.addError(error);
////              }
////
////              await controller.addStream(forward(operation));
////              await controller.close();
////            }
////
////            controller = StreamController<FetchResult>(onListen: onListen);
////
////            return controller.stream;
////          },
////        );
////}
