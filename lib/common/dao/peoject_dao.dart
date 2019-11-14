//import 'package:graphql_flutter/graphql_flutter.dart';
//import 'package:ones_ai_flutter/common/api/project_api.dart';
//import 'package:ones_ai_flutter/common/net/graphql/graphql_manager.dart';
//
//class PeojectRepository {
//  Future<QueryResult> getRepositories(int numOfRepositories) async {
//    final WatchQueryOptions _options = WatchQueryOptions(
//      document: ProjectApi.GRAPHQL_PROJECT_LIST,
//      variables: <String, dynamic>{
//        'nRepositories': numOfRepositories,
//      },
//      pollInterval: 4,
//      fetchResults: true,
//    );
//    return await GraphqlManager.getInstance().getClient().query(_options);
//  }
//}
