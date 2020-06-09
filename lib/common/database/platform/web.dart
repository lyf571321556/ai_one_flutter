import 'package:moor/moor_web.dart';

import '../database.dart';

Database createDatabase({bool logStatements = false}) {
  return Database(WebDatabase('db', logStatements: logStatements));
}
