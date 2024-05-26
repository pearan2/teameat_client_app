import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/snack_bar.dart';

class TEClipboard {
  static Future<void> setText(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    if (GetPlatform.isIOS) {
      showSuccess(DS.text.copyToClipboard);
    }
  }
}
