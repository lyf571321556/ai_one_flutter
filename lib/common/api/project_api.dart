import 'package:dio/dio.dart';
import 'package:ones_ai_flutter/common/net/dio/http_manager.dart';
import 'package:ones_ai_flutter/common/net/dio/http_result.dart';
import 'package:ones_ai_flutter/models/account/index.dart';

class ProjectApi {
  static final String PROJECT_LIST_URL = r"team/{teamId}/projects/my_project";
  static final String graphql_project_list = r'''{
    buckets(
        groupBy: {
            projects: {}
        }
        pagination: {
            first: 10
            after: "{after}"
        }
    ) {
	key
        pageInfo {
            count
            totalCount
            startCursor
            endCursor
            hasNextPage
            unstable
        }
        projects(
            filter: {
                project_in: ["GAy6uL3m3WDwkYTL"]
            }
            orderBy: {
                number: ASC
            }
        ) {
            name
            namePinyin
        }
    }
}''';

  static Future<HttpResult> fetchProjectList(
      String userName, String password, CancelToken token) async {
    Map<String, dynamic> requestParams = {
      "password": password,
      "email": userName,
    };
    dynamic data = await HttpManager.getInstance()
        .post(PROJECT_LIST_URL, bodyParams: requestParams)
        .then((result) {
      if (result.isSuccess) {
        result.data = User.fromJson(result.data["user"]);
      }
      return result;
    });
    return Future.value(data);
  }
}
