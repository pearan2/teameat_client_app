import 'package:flutter/material.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';

class TEEssentialText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  const TEEssentialText(this.text, {super.key, this.style});

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? const TextStyle();
    return Text.rich(TextSpan(children: <TextSpan>[
      TextSpan(text: text, style: style),
      TextSpan(text: '*', style: style.copyWith(color: DS.color.point500))
    ]));
  }
}
