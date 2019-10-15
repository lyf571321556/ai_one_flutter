import 'package:json_annotation/json_annotation.dart';

part 'language.g.dart';

@JsonSerializable()
class Language {
    Language();

    String titleId;
    String languageCode;
    String countryCode;
    bool isSelected;
    
    factory Language.fromJson(Map<String,dynamic> json) => _$LanguageFromJson(json);
    Map<String, dynamic> toJson() => _$LanguageToJson(this);
}
