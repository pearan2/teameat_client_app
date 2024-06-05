import 'package:flutter/cupertino.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';

class TEInputText extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final void Function(String) onCompleted;

  const TEInputText({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      controller: controller,
      focusNode: focusNode,
      onEditingComplete: () {
        focusNode.unfocus();
        onCompleted(controller.text);
      },
      cursorColor: DS.color.primary500,
      padding: EdgeInsets.symmetric(
          horizontal: DS.space.xSmall, vertical: DS.space.tiny),
      prefix: Padding(
        padding: EdgeInsets.only(left: DS.space.xSmall),
        child: DS.image.iconSearch,
      ),
      placeholderStyle:
          DS.textStyle.paragraph3.copyWith(color: DS.color.background400),
      placeholder: DS.text.textSearcherPlaceHolder,
      style: DS.textStyle.paragraph3,
      decoration: BoxDecoration(
        color: DS.color.background100,
        borderRadius: BorderRadius.circular(DS.space.xSmall),
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
