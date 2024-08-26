import 'dart:async';

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
  final dynamic left;
  final dynamic right;
  final TextStyle? style;
  final bool useDefaultDivider;

  const TELeftRightText(this.left, this.right,
      {super.key, this.divider, this.style, this.useDefaultDivider = true})
      : assert((left is String || left is Widget) &&
            (right is String || right is Widget));

  Widget _defaultDivider() {
    if (!useDefaultDivider) return const SizedBox();
    return Container(
      width: 1,
      height: DS.space.tiny,
      color: DS.color.background500,
    ).paddingSymmetric(horizontal: DS.space.xTiny);
  }

  Widget _toWidget(dynamic src) {
    if (src is Widget) {
      return src;
    } else if (src is String) {
      final style = this.style ?? DS.textStyle.caption2.b500.h14;
      return Text(src,
          style: style, maxLines: 1, overflow: TextOverflow.ellipsis);
    } else {
      return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    final divider = this.divider ?? _defaultDivider();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(child: _toWidget(left)),
        divider,
        _toWidget(right),
      ],
    );
  }
}

class TEDDateText extends StatefulWidget {
  final DateTime futurePoint;
  final bool withMillis;
  final TextStyle style;
  final int countdownMillis;

  const TEDDateText({
    super.key,
    required this.futurePoint,
    required this.withMillis,
    required this.style,
    this.countdownMillis = 100,
  });

  @override
  State<TEDDateText> createState() => _TEDDateTextState();
}

class _TEDDateTextState extends State<TEDDateText> {
  int millis = 0;
  Timer? timer;
  late Duration diff;

  void timerCallback() {
    setState(() => millis += widget.countdownMillis);
  }

  void init() {
    millis = 0;
    timer?.cancel();
    diff = widget.futurePoint.difference(DateTime.now());
    timer = Timer.periodic(Duration(milliseconds: widget.countdownMillis),
        (timer) => timerCallback());
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  String calcRemainSaleDuration() {
    final remainMillis = diff.inMilliseconds - millis;

    final remainSec = remainMillis ~/ 1000;
    final intDay = remainSec ~/ (3600 * 24);
    final intHour = remainSec % (3600 * 24) ~/ 3600;
    final intMin = remainSec % 3600 ~/ 60;
    final intSec = remainSec % 60;

    String hourString = intHour.toString();
    if (hourString.length == 1) {
      hourString = '0$hourString';
    }
    String minString = intMin.toString();
    if (minString.length == 1) {
      minString = '0$minString';
    }
    String secString = intSec.toString();
    if (secString.length == 1) {
      secString = '0$secString';
    }
    String timeString = '$hourString:$minString:$secString';
    if (widget.withMillis) {
      timeString += '.${((remainMillis % 1000) / 100).floor()}';
    }
    if (intDay > 0) {
      timeString = '$intDay${DS.text.day} $timeString';
    }
    return timeString;
  }

  @override
  Widget build(BuildContext context) {
    return Text(calcRemainSaleDuration(), style: widget.style);
  }
}

class TETitleContentText extends StatelessWidget {
  final List<String> titles;
  final List<String> contents;

  final TextStyle titleStyle;
  final TextStyle contentStyle;

  final double spaceBetweenTitleAndContent;
  final double spaceBetweenRows;

  const TETitleContentText({
    super.key,
    required this.titles,
    required this.contents,
    required this.titleStyle,
    required this.contentStyle,
    this.spaceBetweenTitleAndContent = 4.0,
    this.spaceBetweenRows = 4.0,
  }) : assert(titles.length == contents.length);

  Widget _buildRow(String title, String content) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: titleStyle),
        SizedBox(width: spaceBetweenTitleAndContent),
        Flexible(child: Text(content, style: contentStyle)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemBuilder: (_, idx) => _buildRow(titles[idx], contents[idx]),
      separatorBuilder: (_, __) => SizedBox(height: spaceBetweenRows),
      itemCount: titles.length,
    );
  }
}

class InfoTitleText extends StatelessWidget {
  final String text;

  const InfoTitleText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: DS.textStyle.paragraph2.copyWith(
        color: DS.color.background800,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
