import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/button.dart';
import 'package:teameat/1_presentation/core/component/input_text.dart';
import 'package:teameat/1_presentation/core/component/on_tap.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/app_bar.dart';
import 'package:teameat/1_presentation/core/layout/scaffold.dart';
import 'package:teameat/1_presentation/core/layout/snack_bar.dart';
import 'package:teameat/3_domain/user/report/i_report_repository.dart';
import 'package:teameat/99_util/extension/text_style.dart';
import 'package:teameat/main.dart';

enum ReviewTargetType {
  voucher("VOUCHER", "이용권 사용 경험 조사"),
  store("STORE", "상점 서비스 경험 조사");

  const ReviewTargetType(this.code, this.title);

  final String code;
  final String title;
}

class TEScorePicker extends StatelessWidget {
  static const minScore = 1;

  final int maxScore;
  final int selectedScore;
  final double boxHeight;
  final double spacing;
  final Widget Function(bool activated)? iconBuilder;
  final void Function(int value) onSelectedScoreChanged;

  const TEScorePicker({
    super.key,
    this.maxScore = 5,
    this.boxHeight = 32.0,
    this.spacing = 8.0,
    this.iconBuilder,
    required this.selectedScore,
    required this.onSelectedScoreChanged,
  })  : assert(maxScore > minScore),
        assert(selectedScore <= maxScore && selectedScore >= minScore);

  Widget _buildStar(bool isActivated) {
    if (iconBuilder == null) {
      return Icon(isActivated ? Icons.star : Icons.star_border,
          size: boxHeight, color: DS.color.background600);
    } else {
      return iconBuilder!(isActivated);
    }
  }

  Widget _buildButton(int score) {
    return TEonTap(
      onTap: () => onSelectedScoreChanged(score),
      child: _buildStar(score <= selectedScore),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: boxHeight,
      child: ListView.separated(
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, idx) => _buildButton(idx + 1),
        separatorBuilder: (_, __) => SizedBox(width: spacing),
        itemCount: maxScore - minScore + 1,
      ),
    );
  }
}

class ReviewForm extends StatefulWidget {
  final int targetId;
  final int initScore;
  final int maxScore;
  final ReviewTargetType targetType;
  final void Function(int score, String text) onReviewFinished;

  const ReviewForm({
    super.key,
    required this.targetId,
    this.initScore = 3,
    this.maxScore = 5,
    required this.targetType,
    required this.onReviewFinished,
  });

  @override
  State<ReviewForm> createState() => _ReviewFormState();
}

class _ReviewFormState extends State<ReviewForm> {
  late int nowScore = widget.initScore;
  final reviewTextController = TECupertinoTextFieldController();
  final reportRepo = Get.find<IReportRepository>();

  void onReview() {
    widget.onReviewFinished(nowScore, reviewTextController.text);
    reportRepo.review(
        score: nowScore,
        report: reviewTextController.text,
        targetId: widget.targetId,
        targetTypeCode: widget.targetType.code);
    showSuccess(DS.text.reviewFinishThankyou);
  }

  @override
  void dispose() {
    reviewTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(widget.targetType.title, style: DS.textStyle.paragraph1.bold.b800),
        DS.space.vBase,
        Text(DS.text.reviewScore, style: DS.textStyle.paragraph3.semiBold.b800),
        DS.space.vTiny,
        TEScorePicker(
          selectedScore: nowScore,
          maxScore: widget.maxScore,
          onSelectedScoreChanged: (newScore) =>
              setState(() => nowScore = newScore),
        ),
        DS.space.vSmall,
        Text(DS.text.reviewText, style: DS.textStyle.paragraph3.semiBold.b800),
        DS.space.vTiny,
        TECupertinoTextField(
          controller: reviewTextController,
          autoFocus: false,
          isEssential: false,
          hintText: DS.text.reviewPleaseInputReviewText,
          maxLines: 4,
        ),
        const Expanded(child: SizedBox()),
        TEPrimaryButton(
          text: DS.text.review,
          onTap: onReview,
        )
      ],
    );
  }
}

class _ReviewFormPage extends StatelessWidget {
  final int targetId;
  final ReviewTargetType targetType;
  const _ReviewFormPage({required this.targetId, required this.targetType});

  @override
  Widget build(BuildContext context) {
    return TEScaffold(
      appBar: TEAppBar(
        title: DS.text.reviewFormTitle,
        leadingIconOnPressed: Get.back,
      ),
      body: ReviewForm(
        targetId: targetId,
        targetType: targetType,
        onReviewFinished: (_, __) => Get.back(),
      ).paddingAll(AppWidget.horizontalPadding),
    );
  }
}

Future<void> toReview(
  int targetId,
  ReviewTargetType targetType,
) async {
  Get.to(
    _ReviewFormPage(targetId: targetId, targetType: targetType),
    duration: const Duration(milliseconds: 200),
    transition: Transition.rightToLeft,
  );
}
