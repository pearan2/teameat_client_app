import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';

class TextSearcher extends StatefulWidget {
  const TextSearcher({super.key});

  @override
  State<TextSearcher> createState() => _TextSearcherState();
}

class _TextSearcherState extends State<TextSearcher> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      cursorColor: DS.getColor().primary500,
      padding: EdgeInsets.symmetric(
          horizontal: DS.getSpace().base, vertical: DS.getSpace().tiny),
      prefix: Padding(
        padding: EdgeInsets.only(left: DS.getSpace().base),
        child: Icon(
          Icons.search,
          size: DS.getSpace().base,
        ),
      ),
      placeholder: DS.getText().textSearcherPlaceHolder,
      style: DS.getTextStyle().paragraph3,
      decoration: BoxDecoration(
        color: DS.getColor().background000,
        borderRadius: BorderRadius.circular(300),
        boxShadow: [
          BoxShadow(
              color: DS.getColor().background300.withOpacity(0.5),
              blurRadius: DS.getSpace().xBase,
              offset: Offset(0, DS.getSpace().xTiny))
        ],
      ),
    );
  }
}
