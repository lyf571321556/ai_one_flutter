// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Language _$LanguageFromJson(Map<String, dynamic> json) {
  return Language()
    ..titleId = json['titleId'] as String
    ..languageCode = json['languageCode'] as String
    ..countryCode = json['countryCode'] as String
    ..isSelected = json['isSelected'] as bool;
}

Map<String, dynamic> _$LanguageToJson(Language instance) => <String, dynamic>{
      'titleId': instance.titleId,
      'languageCode': instance.languageCode,
      'countryCode': instance.countryCode,
      'isSelected': instance.isSelected
    };
