import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';

class TextSearcher extends StatefulWidget {
  final void Function(String) onCompleted;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final String? value;

  const TextSearcher(
      {super.key,
      required this.onCompleted,
      this.focusNode,
      this.controller,
      this.value});

  @override
  State<TextSearcher> createState() => _TextSearcherState();
}

class _TextSearcherState extends State<TextSearcher> {
  late final focusNode = widget.focusNode ?? FocusNode();
  late final controller = widget.controller ?? TextEditingController();

  void init() {
    controller.text = widget.value ?? '';
  }

  @override
  void didUpdateWidget(covariant TextSearcher oldWidget) {
    if (oldWidget.value != widget.value) {
      init();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      focusNode.dispose();
    }
    if (widget.controller == null) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      controller: controller,
      focusNode: focusNode,
      onEditingComplete: () {
        focusNode.unfocus();
        widget.onCompleted(controller.text);
      },
      cursorColor: DS.color.primary500,
      padding: EdgeInsets.symmetric(
          horizontal: DS.space.base, vertical: DS.space.tiny),
      prefix: Padding(
        padding: EdgeInsets.only(left: DS.space.base),
        child: Icon(
          Icons.search,
          size: DS.space.base,
        ),
      ),
      placeholder: DS.text.textSearcherPlaceHolder,
      style: DS.textStyle.paragraph3,
      decoration: BoxDecoration(
        color: DS.color.background000,
        borderRadius: BorderRadius.circular(300),
        boxShadow: [
          BoxShadow(
              color: DS.color.background300.withOpacity(0.5),
              blurRadius: DS.space.xBase,
              offset: Offset(0, DS.space.xTiny))
        ],
      ),
    );
  }
}
