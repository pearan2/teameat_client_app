import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/on_tap.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/2_application/core/loading_provider.dart';

class TEPrimaryButton extends GetView<LoadingProvider> {
  final void Function() onTap;
  final bool isLoginRequired;
  final String text;

  const TEPrimaryButton({
    super.key,
    required this.onTap,
    required this.text,
    this.isLoginRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return TEonTap(
      onTap: onTap,
      isLoginRequired: isLoginRequired,
      child: Container(
        width: double.infinity,
        height: DS.getSpace().large,
        decoration: BoxDecoration(
            color: DS.getColor().primary500,
            borderRadius: BorderRadius.circular(DS.getSpace().tiny)),
        child: Center(
          child: Text(
            text,
            style: DS.getTextStyle().paragraph1.copyWith(
                  color: DS.getColor().background000,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
    );
  }
}
