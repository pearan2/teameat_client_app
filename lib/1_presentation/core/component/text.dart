import 'package:flutter/material.dart';
import 'package:teameat/1_presentation/core/component/on_tap.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/99_util/extension/text_style.dart';

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

class TEReadMoreText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final int visibleLength;

  const TEReadMoreText(
    this.text, {
    super.key,
    this.style,
    this.visibleLength = 100,
  });

  @override
  State<TEReadMoreText> createState() => _TEReadMoreTextState();
}

class _TEReadMoreTextState extends State<TEReadMoreText> {
  late bool isSeeAll = widget.text.length <= widget.visibleLength;
  late String shortText = widget.text.substring(0, widget.visibleLength);

  void toggle() {
    if (widget.text.length <= widget.visibleLength) {
      return;
    }
    setState(() => isSeeAll = !isSeeAll);
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style ?? DS.textStyle.paragraph2Long;
    if (isSeeAll) {
      return TEonTap(onTap: toggle, child: Text(widget.text, style: style));
    }
    return TEonTap(
      onTap: toggle,
      child: Text.rich(TextSpan(children: <TextSpan>[
        TextSpan(text: shortText, style: style),
        TextSpan(text: '... ${DS.text.readMore}', style: style.bold.b800)
      ])),
    );
  }
}
