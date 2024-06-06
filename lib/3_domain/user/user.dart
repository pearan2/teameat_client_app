import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String email,
    required String socialLoginType,
    required DateTime createdAt,
    required String nickname,
    required String profileImageUrl,
    required String id,
  }) = _User;

  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);

  factory User.visitor() {
    return User(
      email: 'Visitor',
      socialLoginType: 'Visitor Login',
      createdAt: DateTime(1991, 05, 01),
      nickname: "Anonymous",
      profileImageUrl:
          "https://teameat-prod-read-public.s3.ap-northeast-2.amazonaws.com/base/default_profile_image.png",
      id: 'visitor user Id',
    );
  }
}

@freezed
class UserUpdate with _$UserUpdate {
  const factory UserUpdate({
    required String email,
    required String profileImageUrl,
    required String nickname,
  }) = _UserUpdate;

  factory UserUpdate.fromJson(Map<String, Object?> json) =>
      _$UserUpdateFromJson(json);
}
