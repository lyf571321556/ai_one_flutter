// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User()
    ..uuid = json['uuid'] as String
    ..email = json['email'] as String
    ..token = json['token'] as String
    ..name = json['name'] as String
    ..title = json['title'] as String
    ..avatar = json['avatar'] as String
    ..createTime = json['createTime'] as num
    ..channel = json['channel'] as String
    ..FirstPinYin = json['FirstPinYin'] as String
    ..status = json['status'] as num
    ..namePinyin = json['namePinyin'] as String;
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'email': instance.email,
      'token': instance.token,
      'name': instance.name,
      'title': instance.title,
      'avatar': instance.avatar,
      'createTime': instance.createTime,
      'channel': instance.channel,
      'FirstPinYin': instance.FirstPinYin,
      'status': instance.status,
      'namePinyin': instance.namePinyin
    };
