import 'package:flutter/cupertino.dart';
import 'package:teameat/1_presentation/core/component/text.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/99_util/text.dart';

class TECupertinoTextFieldController {
  late final TextEditingController c;
  final focusNode = FocusNode();
  TECupertinoTextFieldController({String? text}) {
    c = TextEditingController(text: text);
  }

  bool Function(String value)? validate;

  String get text => c.text;
  set text(String value) {
    c.text = value;
  }

  bool checkIsValid() {
    if (validate == null) {
      return true;
    }
    final isValid = validate!.call(c.text);
    if (!isValid) {
      requestFocus();
    }
    return isValid;
  }

  void requestFocus() {
    focusNode.requestFocus();
  }

  void unFocus() {
    focusNode.unfocus();
  }

  void dispose() {
    focusNode.dispose();
    c.dispose();
  }
}

// ignore: must_be_immutable
class TECupertinoTextField extends StatefulWidget {
  final TECupertinoTextFieldController controller;

  late final Color focusedBorderColor;
  late final Color emptyBorderColor;
  late final Color filledBorderColor;
  late final String hintText;
  late final String? helperText;
  late final TextStyle hintTextStyle;
  late final TextStyle textStyle;
  late final TextStyle? helperTextStyle;
  late final bool autoFocus;
  late final TextStyle? suffixTextStyle;

  final int? maxLines;

  final TextInputType? keyboardType;
  final String? suffixText;
  final double? widgetWidth;
  final double? helperTextSpacing;

  late final String errorText;
  late final TextStyle errorTextStyle;

  final void Function(String value)? onChanged;
  final bool Function(String value)? validate;
  final void Function()? onEditingComplete;
  final void Function(String value)? onSubmitted;
  final void Function()? onFocused;

  final bool isEssential;

  final bool enabled;

  TECupertinoTextField({
    super.key,
    required this.controller,
    Color? focusedBorderColor,
    Color? emptyBorderColor,
    Color? filledBorderColor,
    this.maxLines = 1,
    this.onChanged,
    this.validate,
    this.onEditingComplete,
    this.onSubmitted,
    this.onFocused,
    String? hintText,
    this.keyboardType,
    TextStyle? hintTextStyle,
    this.helperText,
    TextStyle? helperTextStyle,
    TextStyle? textStyle,
    bool? autoFocus,
    String? errorText,
    TextStyle? errorTextStyle,
    this.suffixText,
    this.widgetWidth,
    TextStyle? suffixTextStyle,
    this.helperTextSpacing = 8.0,
    this.isEssential = false,
    this.enabled = true,
  }) {
    this.focusedBorderColor = focusedBorderColor ?? DS.color.primary600;
    this.emptyBorderColor = emptyBorderColor ?? DS.color.background400;
    this.filledBorderColor = filledBorderColor ?? DS.color.background800;
    this.hintText = hintText ?? '';
    this.hintTextStyle = hintTextStyle ??
        DS.textStyle.paragraph2.copyWith(color: DS.color.background400);
    this.textStyle = textStyle ??
        DS.textStyle.paragraph2.copyWith(color: DS.color.background800);
    this.autoFocus = autoFocus ?? true;

    this.helperTextStyle = helperTextStyle ??
        DS.textStyle.paragraph3
            .copyWith(color: DS.color.background700, letterSpacing: -0.2);
    this.errorText = errorText ?? '';
    this.errorTextStyle = errorTextStyle ??
        DS.textStyle.caption1
            .copyWith(color: DS.color.point500, letterSpacing: -0.2);

    this.suffixTextStyle = suffixTextStyle ??
        DS.textStyle.caption1
            .copyWith(color: DS.color.background800, letterSpacing: -0.2);

    if (suffixText != null && widgetWidth == null) {
      throw 'invalid params';
    }
  }

  @override
  // ignore: library_private_types_in_public_api
  _TECupertinoTextFieldState createState() => _TECupertinoTextFieldState();
}

class _TECupertinoTextFieldState extends State<TECupertinoTextField> {
  late bool isEmpty;
  late bool isFocused;
  late bool isValid;
  bool isDisposed = false;

  bool isOneLine() {
    return widget.maxLines == 1;
  }

  @override
  void initState() {
    super.initState();
    isEmpty = widget.controller.text.isEmpty;
    isFocused = widget.controller.focusNode.hasFocus;
    if (widget.validate == null) {
      isValid = true;
    } else {
      isValid = widget.validate!(widget.controller.text);
    }
    widget.controller.focusNode.addListener(focusNodeListener);
    widget.controller.validate = widget.validate;
  }

  void focusNodeListener() {
    if (isDisposed) return;
    setState(() {
      final before = isFocused;
      isFocused = widget.controller.focusNode.hasFocus;
      final after = isFocused;
      if (after && !before) {
        widget.onFocused?.call();
      }
    });
  }

  @override
  void dispose() {
    isDisposed = true;
    widget.controller.focusNode.removeListener(focusNodeListener);
    super.dispose();
  }

  Widget _buildHelperText() {
    if (widget.helperText == null) {
      return const SizedBox();
    } else {
      return Padding(
        padding: EdgeInsets.only(bottom: widget.helperTextSpacing ?? 0.0),
        child: widget.isEssential
            ? TEEssentialText(
                widget.helperText!,
                style: widget.helperTextStyle,
              )
            : Text(
                widget.helperText!,
                style: widget.helperTextStyle,
              ),
      );
    }
  }

  Widget _buildErrorText() {
    if (widget.validate == null) {
      return const SizedBox();
    } else {
      late final String errorText;
      if (widget.controller.text.isEmpty) {
        errorText = '';
      } else {
        if (isValid) {
          errorText = '';
        } else {
          errorText = widget.errorText;
        }
      }
      return Padding(
        padding: EdgeInsets.only(top: DS.space.tiny),
        child: Text(errorText, style: widget.errorTextStyle),
      );
    }
  }

  Widget _buildTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHelperText(),
        _buildInnerTextField(),
        _buildErrorText(),
      ],
    );
  }

  Widget? _buildSuffix() {
    if (widget.suffixText == null) {
      return null;
    } else {
      final maxWidth = widget.widgetWidth! - DS.space.xTiny;
      final minWidth = getTextPainter(
        text: widget.suffixText!,
        maxLine: widget.maxLines,
        maxWidth: widget.widgetWidth!,
        style: widget.suffixTextStyle,
      ).size.width;
      final textSize = getTextPainter(
        maxLine: widget.maxLines,
        text: widget.controller.text.isEmpty
            ? widget.hintText
            : widget.controller.text,
        style: widget.textStyle,
        maxWidth: widget.widgetWidth!,
      ).size;
      double suffixWidth = maxWidth - textSize.width;
      if (suffixWidth < minWidth) {
        suffixWidth = minWidth;
      }
      return Container(
        padding: EdgeInsets.only(bottom: DS.space.tiny),
        width: suffixWidth,
        child: Text(
          widget.suffixText!,
          style: widget.suffixTextStyle,
        ),
      );
    }
  }

  Color _getBorderColor() {
    if (isOneLine()) {
      return isFocused
          ? widget.focusedBorderColor
          : (isEmpty ? widget.emptyBorderColor : widget.filledBorderColor);
    } else {
      return isFocused
          ? widget.focusedBorderColor
          : (isEmpty ? DS.color.background200 : widget.filledBorderColor);
    }
  }

  Widget _buildInnerTextField() {
    return AbsorbPointer(
      absorbing: !widget.enabled,
      child: CupertinoTextField(
        controller: widget.controller.c,
        autofocus: widget.autoFocus,
        cursorColor: DS.color.primary600,
        padding: isOneLine()
            ? EdgeInsets.only(bottom: DS.space.tiny)
            : EdgeInsets.all(DS.space.small),
        focusNode: widget.controller.focusNode,
        maxLines: widget.maxLines,
        onChanged: (value) {
          setState(() {
            isEmpty = value.isEmpty;
            if (widget.validate != null) {
              isValid = widget.validate!(value);
            }
          });
          widget.onChanged?.call(value);
        },
        suffix: _buildSuffix(),
        onEditingComplete: widget.onEditingComplete,
        onSubmitted: widget.onSubmitted,
        style: isValid
            ? widget.textStyle
            : widget.textStyle.copyWith(color: DS.color.point500),
        placeholder: widget.hintText,
        placeholderStyle: widget.hintTextStyle,
        keyboardType: widget.keyboardType,
        decoration: BoxDecoration(
          color: isOneLine() ? null : DS.color.background200,
          borderRadius:
              isOneLine() ? null : BorderRadius.circular(DS.space.tiny),
          border: !isOneLine()
              ? Border.all(width: 1, color: _getBorderColor())
              : widget.enabled
                  ? Border(
                      bottom: BorderSide(width: 2, color: _getBorderColor()),
                    )
                  : null,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTextField();
  }
}
