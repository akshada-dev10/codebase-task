import 'package:json_annotation/json_annotation.dart';

part 'user_entities.g.dart';

@JsonSerializable()
class User {
  final int? id;
  @JsonKey(name: 'first_name')
  final String? firstName;
  @JsonKey(name: 'last_name')
  final String? lastName;
  @JsonKey(name: 'avatar')
  final String? profilePicture;
  final String? email;

  User({this.id, this.firstName, this.lastName, this.profilePicture, this.email});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
