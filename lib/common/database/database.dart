import 'package:flutter/foundation.dart';
import 'package:moor/moor.dart';

part 'database.g.dart';

@DataClassName('User')
class Users extends Table {
  TextColumn get uuid => text().withLength(min: 6, max: 32)();

  TextColumn get name => text().withLength(min: 6, max: 32)();

  TextColumn get json => text().named('json')();
}

@UseMoor(tables: [Users])
class Database extends _$Database {
  Database(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 1;

  @override
  // TODO: implement migration
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) {
        return m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        debugPrint("数据库版本升级");
      },
      beforeOpen: (detail) async {
        if (detail.wasCreated) {
          List<UsersCompanion> allUsers = [];
          for (int i = 0; i < 10; i++) {
            allUsers.add(UsersCompanion.insert(
                uuid: 'uuid is $i',
                name: 'tom is $i',
                json: {"age": "($i\*10)"}.toString()));
          }
          await batch((batch) {
            batch.insertAll(users, allUsers);
          });
          debugPrint("首次创建");
          //默认插入数据
          await into(users).insert(UsersCompanion(
              uuid: Value("123123"),
              name: Value("tom123"),
              json: Value({"age": "12"}.toString())));
        }
      },
    );
  }

  @override
  Migrator createMigrator() {
    // TODO: implement createMigrator
    return super.createMigrator();
  }

  //分页查询数据
  Future<List<User>> queryAllUsers(int limit, {int offset}) {
    final query = select(users);
    query..where((tbl) => tbl.name.contains("tom"));
    //排序
    query..orderBy([(t) => OrderingTerm(expression: t.name)]);
    return (query..limit(limit, offset: offset)).get();
  }
}
