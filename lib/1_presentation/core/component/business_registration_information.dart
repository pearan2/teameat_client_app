import 'package:flutter/widgets.dart';
import 'package:teameat/1_presentation/core/component/divider.dart';
import 'package:teameat/1_presentation/core/component/info_row.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';

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
              DS.getText().businessRegistrationInformation,
              style: DS.getTextStyle().paragraph1.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            )
          ],
        ),
        DS.getSpace().vTiny,
        PaddingInfoRow(
          title: DS.getText().businessName,
          content: '파이어니어스',
        ),
        const TEDivider(),
        PaddingInfoRow(
          title: DS.getText().businessMailOrderSalesRegistrationNumber,
          content: '309-30-01543',
        ),
        const TEDivider(),
        PaddingInfoRow(
          title: DS.getText().businessMailOrderSalesRegistrationNumber,
          content: '2023-대구수성구-0883',
        ),
        const TEDivider(),
        PaddingInfoRow(
          title: DS.getText().businessCEO,
          content: '이세웅',
        ),
        const TEDivider(),
        PaddingInfoRow(
          title: DS.getText().businessCOCEO,
          content: '황재용',
        ),
        const TEDivider(),
        PaddingInfoRow(
          title: DS.getText().businessEmail,
          content: 'sadol7797@teameat.kr',
        ),
        const TEDivider(),
        PaddingInfoRow(
          title: DS.getText().businessAddress,
          content: '대구광역시 수성구 알파시티1로4길 8, 608호(대흥동)',
        ),
        const TEDivider(),
        PaddingInfoRow(
          title: DS.getText().businessPhone,
          content: '010-2995-2797',
        ),
      ],
    );
  }
}

class PaddingInfoRow extends StatelessWidget {
  final String title;
  final String content;

  const PaddingInfoRow({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: DS.getSpace().xSmall,
        horizontal: DS.getSpace().xBase,
      ),
      child: InfoRow(
        title: title,
        content: content,
        titleWidth: null,
      ),
    );
  }
}
