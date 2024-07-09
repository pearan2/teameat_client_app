import 'package:freezed_annotation/freezed_annotation.dart';

part 'gift.freezed.dart';

part 'gift.g.dart';

@freezed
class GiftPreview with _$GiftPreview {
  const factory GiftPreview({
    required String id,
    required String title,
    required String description,
    required String profileImageUrl,
  }) = _GiftPreview;

  factory GiftPreview.fromJson(Map<String, Object?> json) =>
      _$GiftPreviewFromJson(json);

  factory GiftPreview.empty() => const GiftPreview(
        id: "gift preview empty id",
        title: "gift preview empty title",
        description: "gift preview empty desc",
        profileImageUrl:
            "https://tgzzmmgvheix1905536.cdn.ntruss.com/2020/03/c320a089abe34b72942aeecc9b568295",
      );
}
