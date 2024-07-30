import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/button.dart';
import 'package:teameat/1_presentation/core/component/input_text.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/dialog.dart';
import 'package:teameat/main.dart';

Future<void> showReport(void Function(String? report) onReport) async {
  await showTEDialog(child: _ReportDialog((r) {
    Get.back();
    onReport(r);
  }));
}

class _ReportDialog extends StatelessWidget {
  final void Function(String? report) onReport;

  const _ReportDialog(this.onReport);

  @override
  Widget build(BuildContext context) {
    final controller = TECupertinoTextFieldController();
    return Padding(
      padding: const EdgeInsets.all(AppWidget.horizontalPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TECupertinoTextField(
            controller: controller,
            isEssential: false,
            autoFocus: false,
            helperText: DS.text.reportHelperText,
            hintText: DS.text.reportHintText,
            maxLines: 4,
          ),
          DS.space.vTiny,
          TEPrimaryButton(
            text: DS.text.report,
            onTap: () => onReport(controller.text),
          )
        ],
      ),
    );
  }
}
