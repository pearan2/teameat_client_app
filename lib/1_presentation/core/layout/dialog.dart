import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/button.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/2_application/core/i_react.dart';

Future<T?> showTEDialog<T>(
    {double dialogWidth = 328.0,
    double dialogMinHeight = 162.0,
    required Widget child}) async {
  return Get.dialog<T>(Dialog(
    insetPadding: EdgeInsets.zero,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(
        DS.space.small,
      ),
    ),
    child: Container(
      width: dialogWidth,
      constraints: BoxConstraints(minHeight: dialogMinHeight),
      decoration: BoxDecoration(
          color: DS.color.background000,
          borderRadius: BorderRadius.circular(DS.space.small)),
      padding: EdgeInsets.all(DS.space.tiny),
      child: child,
    ),
  ));
}

Future<bool> showTEConfirmDialog(
    {required String content,
    required String leftButtonText,
    required String rightButtonText,
    double dialogWidth = 328.0,
    double dialogMinHeight = 162.0}) async {
  final react = Get.find<IReact>();
  final ret = await showTEDialog(
      dialogMinHeight: dialogMinHeight,
      dialogWidth: dialogWidth,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.all(DS.space.base),
            child: Text(content,
                textAlign: TextAlign.center,
                style: DS.textStyle.paragraph2.copyWith(
                  fontWeight: FontWeight.bold,
                )),
          ),
          Row(
            children: [
              Expanded(
                child: TESecondaryButton(
                  onTap: () {
                    react.back<bool>(result: false);
                  },
                  text: leftButtonText,
                ),
              ),
              DS.space.hTiny,
              Expanded(
                child: TEPrimaryButton(
                  onTap: () {
                    react.back<bool>(result: true);
                  },
                  text: rightButtonText,
                ),
              )
            ],
          )
        ],
      ));
  if (ret == null) return false;
  return ret;
}
