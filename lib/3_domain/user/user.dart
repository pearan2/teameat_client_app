import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class BankAccount with _$BankAccount {
  const factory BankAccount({
    required String holderName,
    required String bankName,
    required String number,
  }) = _BankAccount;

  factory BankAccount.fromJson(Map<String, Object?> json) =>
      _$BankAccountFromJson(json);
}

@freezed
class User with _$User {
  const factory User({
    required String email,
    required String socialLoginType,
    required DateTime createdAt,
    required String nickname,
    required String profileImageUrl,
    required String id,
    String? oneLineIntroduce,
    BankAccount? bankAccount,
  }) = _User;

  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);

  factory User.visitor() {
    return User(
      email: 'Visitor',
      socialLoginType: 'Visitor',
      createdAt: DateTime(1991, 05, 01),
      nickname: "Unknown User",
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
    String? oneLineIntroduce,
    BankAccount? bankAccount,
  }) = _UserUpdate;

  factory UserUpdate.fromJson(Map<String, Object?> json) =>
      _$UserUpdateFromJson(json);
}

@freezed
class Summary with _$Summary {
  const factory Summary({
    required int id,
    required String nickname,
    required String profileImageUrl,
    String? oneLineIntroduce,
    required bool isMe,
    required int numberOfFollowers,
    required int numberOfCurations,
    required int numberOfCommercializedCurations,
  }) = _Summary;

  factory Summary.fromJson(Map<String, Object?> json) =>
      _$SummaryFromJson(json);

  factory Summary.empty() {
    return const Summary(
      id: -1,
      nickname: "",
      profileImageUrl:
          "https://teameat-prod-read-public.s3.ap-northeast-2.amazonaws.com/base/default_profile_image.png",
      oneLineIntroduce: "",
      isMe: false,
      numberOfFollowers: 0,
      numberOfCurations: 0,
      numberOfCommercializedCurations: 0,
    );
  }
}
