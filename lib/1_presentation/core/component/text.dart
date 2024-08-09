import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

class TEUnderlineText extends StatelessWidget {
  final double underlineOffsetY;
  final String text;
  final TextStyle style;
  final Color underlineColor;

  const TEUnderlineText(
    this.text, {
    super.key,
    this.underlineOffsetY = 1.5,
    required this.style,
    required this.underlineColor,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, underlineOffsetY),
      child: Text(
        text,
        style: style.copyWith(
          color: Colors.transparent,
          decoration: TextDecoration.underline,
          shadows: [
            Shadow(color: underlineColor, offset: Offset(0, -underlineOffsetY))
          ],
        ),
      ),
    );
  }
}

class TELeftRightText extends StatelessWidget {
  final Widget? divider;
  final String left;
  final String right;
  final TextStyle? style;

  const TELeftRightText(this.left, this.right,
      {super.key, this.divider, this.style});

  Widget _defaultDivider() {
    return Container(
      width: 1,
      height: DS.space.tiny,
      color: DS.color.background500,
    ).paddingSymmetric(horizontal: DS.space.xTiny);
  }

  @override
  Widget build(BuildContext context) {
    final divider = this.divider ?? _defaultDivider();
    final style = this.style ?? DS.textStyle.caption2.b500.h14;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(left, style: style),
        divider,
        Text(right, style: style),
      ],
    );
  }
}
