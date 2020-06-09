// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class User extends DataClass implements Insertable<User> {
  final String uuid;
  final String name;
  final String json;
  User({@required this.uuid, @required this.name, @required this.json});
  factory User.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return User(
      uuid: stringType.mapFromDatabaseResponse(data['${effectivePrefix}uuid']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      json: stringType.mapFromDatabaseResponse(data['${effectivePrefix}json']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || uuid != null) {
      map['uuid'] = Variable<String>(uuid);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || json != null) {
      map['json'] = Variable<String>(json);
    }
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      uuid: uuid == null && nullToAbsent ? const Value.absent() : Value(uuid),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      json: json == null && nullToAbsent ? const Value.absent() : Value(json),
    );
  }

  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return User(
      uuid: serializer.fromJson<String>(json['uuid']),
      name: serializer.fromJson<String>(json['name']),
      json: serializer.fromJson<String>(json['json']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uuid': serializer.toJson<String>(uuid),
      'name': serializer.toJson<String>(name),
      'json': serializer.toJson<String>(json),
    };
  }

  User copyWith({String uuid, String name, String json}) => User(
        uuid: uuid ?? this.uuid,
        name: name ?? this.name,
        json: json ?? this.json,
      );
  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('uuid: $uuid, ')
          ..write('name: $name, ')
          ..write('json: $json')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(uuid.hashCode, $mrjc(name.hashCode, json.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is User &&
          other.uuid == this.uuid &&
          other.name == this.name &&
          other.json == this.json);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<String> uuid;
  final Value<String> name;
  final Value<String> json;
  const UsersCompanion({
    this.uuid = const Value.absent(),
    this.name = const Value.absent(),
    this.json = const Value.absent(),
  });
  UsersCompanion.insert({
    @required String uuid,
    @required String name,
    @required String json,
  })  : uuid = Value(uuid),
        name = Value(name),
        json = Value(json);
  static Insertable<User> custom({
    Expression<String> uuid,
    Expression<String> name,
    Expression<String> json,
  }) {
    return RawValuesInsertable({
      if (uuid != null) 'uuid': uuid,
      if (name != null) 'name': name,
      if (json != null) 'json': json,
    });
  }

  UsersCompanion copyWith(
      {Value<String> uuid, Value<String> name, Value<String> json}) {
    return UsersCompanion(
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      json: json ?? this.json,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (json.present) {
      map['json'] = Variable<String>(json.value);
    }
    return map;
  }
}

class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  final GeneratedDatabase _db;
  final String _alias;
  $UsersTable(this._db, [this._alias]);
  final VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  GeneratedTextColumn _uuid;
  @override
  GeneratedTextColumn get uuid => _uuid ??= _constructUuid();
  GeneratedTextColumn _constructUuid() {
    return GeneratedTextColumn('uuid', $tableName, false,
        minTextLength: 6, maxTextLength: 32);
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn('name', $tableName, false,
        minTextLength: 6, maxTextLength: 32);
  }

  final VerificationMeta _jsonMeta = const VerificationMeta('json');
  GeneratedTextColumn _json;
  @override
  GeneratedTextColumn get json => _json ??= _constructJson();
  GeneratedTextColumn _constructJson() {
    return GeneratedTextColumn(
      'json',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [uuid, name, json];
  @override
  $UsersTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'users';
  @override
  final String actualTableName = 'users';
  @override
  VerificationContext validateIntegrity(Insertable<User> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('uuid')) {
      context.handle(
          _uuidMeta, uuid.isAcceptableOrUnknown(data['uuid'], _uuidMeta));
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('json')) {
      context.handle(
          _jsonMeta, json.isAcceptableOrUnknown(data['json'], _jsonMeta));
    } else if (isInserting) {
      context.missing(_jsonMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  User map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return User.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(_db, alias);
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $UsersTable _users;
  $UsersTable get users => _users ??= $UsersTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [users];
}
