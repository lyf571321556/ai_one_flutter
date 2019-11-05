import 'package:dio/dio.dart';
import 'package:ones_ai_flutter/common/net/dio/http_manager.dart';
import 'package:ones_ai_flutter/common/net/dio/http_result.dart';
import 'package:ones_ai_flutter/models/account/index.dart';

class ProjectApi {
  static final String GRAPHQL_PROJECT_LIST =
      r'''query PROJECTS($filter: Filter, $orderBy: OrderBy) {
  projects(filter: $filter, orderBy: $orderBy) {
    _E5gwxatN {
      avatar
      email
      key
      name
      namePinyin
      uuid
    }
    _8WuwZKfD {
      uuid
      value
      bgColor
      color
      defaultSelected
    }
    _M22iBzVh
    _R7cuJXqP
    _QKWfaDLA
    _S7k5yGnz
    _JvTksmtW
    _MpiyLCa4
    key
    uuid
    name
    status {
      uuid
      name
      category
    }
    isPin
    statusCategory
    assign {
      uuid
      name
      avatar
    }
    planStartTime
    planEndTime
    taskUpdateTime
    sprintCount
    taskCount
    taskCountDone
    taskCountInProgress
    taskCountToDo
    memberCount
  }
}''';
}
