import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
    User();

    String uuid;
    String email;
    String token;
    String name;
    String title;
    String avatar;
    num createTime;
    String channel;
    String FirstPinYin;
    num status;
    String namePinyin;
    
    factory User.fromJson(Map<String,dynamic> json) => _$UserFromJson(json);
    Map<String, dynamic> toJson() => _$UserToJson(this);
}
