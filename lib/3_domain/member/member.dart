import 'package:freezed_annotation/freezed_annotation.dart';

part 'member.freezed.dart';

part 'member.g.dart';

@freezed
class Member with _$Member {
  const factory Member({
    required String reason,
    required int quantity,
    required DateTime usedAt,
  }) = _Member;

  factory Member.fromJson(Map<String, Object?> json) => _$MemberFromJson(json);

  factory Member.empty() {
    return Member(reason: '', quantity: 0, usedAt: DateTime.now());
  }
}
