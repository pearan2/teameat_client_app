import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/button.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/2_application/core/i_react.dart';

Future<bool> showTEConfirmDialog(
    {required String content,
    required String leftButtonText,
    required String rightButtonText,
    double dialogWidth = 328.0,
    double dialogMinHeight = 162.0}) async {
  final react = Get.find<IReact>();

  final ret = await Get.dialog<bool>(Dialog(
    insetPadding: EdgeInsets.zero,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(
        DS.getSpace().small,
      ),
    ),
    child: Container(
      width: dialogWidth,
      constraints: BoxConstraints(minHeight: dialogMinHeight),
      decoration: BoxDecoration(
          color: DS.getColor().background000,
          borderRadius: BorderRadius.circular(DS.getSpace().small)),
      padding: EdgeInsets.all(DS.getSpace().tiny),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.all(DS.getSpace().base),
            child: Text(content,
                textAlign: TextAlign.center,
                style: DS.getTextStyle().paragraph2.copyWith(
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
              DS.getSpace().hTiny,
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
      ),
    ),
  ));
  if (ret == null) return false;
  return ret;
}



// ignore: slash_for_doc_comments
/**
 left button click 시 기본적으로 Get.back(result: false); 를 실행하고 onPressed();
 right button click 시 기본적으로 Get.back(result: true); 를 실행하고 onPressed();
 따라서 이 함수의 리턴값은 좌측 버튼 클릭시는 false, 우측 버튼 클릭시는 true 가 됩니다.
 */
// Future<bool> showTwoButtonDialog({
//   required String titleText,
//   required String middleText,
//   double buttonRowHeight = 42.0,
//   required String leftButtonText,
//   required void Function() leftOnPressed,
//   required String rightButtonText,
//   required void Function() rightOnPressed,
// }) async {
//   const radius = 16.0;
//   const dialogWidth = 328.0;
//   final router = Get.find<IOliRouter>();
//   final ret = await Get.dialog<bool>(
//     Dialog(
//       insetPadding: EdgeInsets.zero,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(radius),
//       ),
//       child: Container(
//         width: dialogWidth,
//         constraints: const BoxConstraints(maxHeight: 900),
//         decoration: BoxDecoration(
//           color: OliColorScheme.background800,
//           borderRadius: const BorderRadius.all(
//             Radius.circular(radius),
//           ),
//         ),
//         child: Padding(
//           padding: EdgeInsets.all(OliSpacing.base),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 titleText,
//                 style: OliTextTheme.paragraph1.copyWith(
//                   color: OliColorScheme.background200,
//                   fontWeight: FontWeight.bold,
//                   letterSpacing: 0.2,
//                 ),
//               ),
//               OliSpacing.vTiny,
//               Text(
//                 middleText,
//                 style: OliTextTheme.paragraph3.copyWith(
//                   color: OliColorScheme.background300,
//                   letterSpacing: -0.2,
//                 ),
//               ),
//               OliSpacing.vSmall,
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     child: OliWidthInfinityButton(
//                       onPressed: () {
//                         router.backWithBool(
//                           result: false,
//                           closeOverlay: false,
//                         );
//                         leftOnPressed();
//                       },
//                       text: leftButtonText,
//                       textStyle: OliTextTheme.paragraph1.copyWith(
//                         fontWeight: FontWeight.w600,
//                         fontSize: 14,
//                         color: OliColorScheme.background400,
//                       ),
//                       borderRadius: 8,
//                       borderWidth: 1,
//                       height: buttonRowHeight,
//                       primaryColor: OliColorScheme.background600,
//                       secondaryColor: OliColorScheme.background600,
//                     ),
//                   ),
//                   OliSpacing.hTiny,
//                   Expanded(
//                     child: OliWidthInfinityButton(
//                       borderRadius: 8,
//                       borderWidth: 0,
//                       height: buttonRowHeight,
//                       text: rightButtonText,
//                       textStyle: OliTextTheme.paragraph1.copyWith(
//                         fontWeight: FontWeight.w600,
//                         fontSize: 14,
//                         color: OliColorScheme.background0,
//                       ),
//                       onPressed: () {
//                         router.backWithBool(
//                           closeOverlay: false,
//                         );
//                         rightOnPressed();
//                       },
//                     ),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     ),
//   );
//   if (ret == null || ret == false) {
//     return false;
//   } else {
//     return true;
//   }
// }
