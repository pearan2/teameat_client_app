import 'package:flutter/widgets.dart';
import 'package:teameat/1_presentation/core/component/info_row.dart';
import 'package:teameat/1_presentation/core/component/text.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/99_util/extension/text_style.dart';
import 'package:teameat/99_util/extension/widget.dart';

class BusinessRegistrationInformation extends StatelessWidget {
  const BusinessRegistrationInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return TETitleContentText(
      titles: [
        DS.text.businessName,
        DS.text.businessRegistrationNumber,
        DS.text.businessMailOrderSalesRegistrationNumber,
        DS.text.businessCEO,
        DS.text.businessCOCEO,
        DS.text.businessEmail,
        DS.text.businessAddress,
        DS.text.businessPhone,
      ],
      contents: const [
        '파이어니어스',
        '309-30-01543',
        '2023-대구수성구-0883',
        '이세웅',
        '황재용',
        'sadol7797@teameat.kr',
        '대구광역시 수성구 알파시티1로4길 8, 608호(대흥동)',
        '010-2995-2797',
      ],
      titleStyle: DS.textStyle.caption1.semiBold.b600.h14,
      contentStyle: DS.textStyle.caption1.b600.h14,
    ).withTitle(
      DS.text.businessRegistrationInformation,
      spacing: DS.space.tiny,
      style: DS.textStyle.paragraph2.semiBold.b800.h14,
      withBasePadding: false,
    );
  }
}

class PaddingInfoRow extends StatelessWidget {
  final String title;
  final String content;
  final bool withUnderLine;

  const PaddingInfoRow({
    super.key,
    required this.title,
    required this.content,
    this.withUnderLine = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: DS.space.xSmall,
        horizontal: DS.space.xBase,
      ),
      child: InfoRow(
        title: title,
        content: content,
        withUnderLine: withUnderLine,
      ),
    );
  }
}
