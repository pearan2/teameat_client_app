import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String email,
    required String socialLoginType,
    required DateTime createdAt,
    required String id,
  }) = _User;

  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);

  factory User.visitor() {
    return User(
      email: 'Visitor',
      socialLoginType: 'Visitor Login',
      createdAt: DateTime(1991, 05, 01),
      id: 'visitor user Id',
    );
  }
}
