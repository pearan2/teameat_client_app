import 'package:intl/intl.dart';

extension TEIntExtension on num {
  String format(String formatString) {
    final numberFormat = NumberFormat(formatString, 'ko_KR');
    return numberFormat.format(this);
  }
}
