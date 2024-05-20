import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';

void _showSnackBar({
  required String title,
  required String message,
  Duration duration = const Duration(seconds: 3),
  SnackPosition position = SnackPosition.TOP,
}) {
  if (Get.isSnackbarOpen) {
    return;
  }

  Get.snackbar(
    '',
    '',
    titleText: Text(title,
        style:
            DS.getTextStyle().paragraph2.copyWith(fontWeight: FontWeight.bold)),
    messageText: Text(message, style: DS.getTextStyle().paragraph3),
    backgroundColor: DS.getColor().background300,
    duration: duration,
    snackPosition: position,
    margin: EdgeInsets.symmetric(horizontal: DS.getSpace().small),
  );
}

void showError(String message) {
  return _showSnackBar(title: DS.getText().errorOccurred, message: message);
}

void showSuccess(String message) {
  return _showSnackBar(title: DS.getText().success, message: message);
}
