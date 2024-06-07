import 'package:flutter/widgets.dart';
import 'package:teameat/1_presentation/core/component/divider.dart';
import 'package:teameat/1_presentation/core/component/info_row.dart';
import 'package:teameat/1_presentation/core/component/on_tap.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/2_application/core/clipboard.dart';
import 'package:url_launcher/url_launcher_string.dart';

class BusinessRegistrationInformation extends StatelessWidget {
  const BusinessRegistrationInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DS.text.businessRegistrationInformation,
              style: DS.textStyle.paragraph1.copyWith(
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
        DS.space.vTiny,
        PaddingInfoRow(
          title: DS.text.businessName,
          content: '파이어니어스',
        ),
        const TEDivider(),
        PaddingInfoRow(
          title: DS.text.businessMailOrderSalesRegistrationNumber,
          content: '309-30-01543',
        ),
        const TEDivider(),
        PaddingInfoRow(
          title: DS.text.businessMailOrderSalesRegistrationNumber,
          content: '2023-대구수성구-0883',
        ),
        const TEDivider(),
        PaddingInfoRow(
          title: DS.text.businessCEO,
          content: '이세웅',
        ),
        const TEDivider(),
        PaddingInfoRow(
          title: DS.text.businessCOCEO,
          content: '황재용',
        ),
        const TEDivider(),
        PaddingInfoRow(
          title: DS.text.businessEmail,
          content: 'sadol7797@teameat.kr',
        ),
        const TEDivider(),
        TEonTap(
          onTap: () => TEClipboard.setText('대구광역시 수성구 알파시티1로4길 8, 608호(대흥동)'),
          child: PaddingInfoRow(
            title: DS.text.businessAddress,
            content: '대구광역시 수성구 알파시티1로4길 8, 608호(대흥동)',
          ),
        ),
        const TEDivider(),
        TEonTap(
          onTap: () => launchUrlString('tel:010-2995-2797'),
          child: PaddingInfoRow(
            withUnderLine: true,
            title: DS.text.businessPhone,
            content: '010-2995-2797',
          ),
        ),
      ],
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
