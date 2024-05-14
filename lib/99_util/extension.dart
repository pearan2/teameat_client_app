import 'package:intl/intl.dart';

extension TEIntExtension on int {
  String format(String formatString) {
    final numberFormat = NumberFormat(formatString, 'ko_KR');
    return numberFormat.format(this);
  }
}

extension TEDateTimeExtension on DateTime {
  String format(String formatString) {
    final dateTimeFormat = DateFormat(formatString, 'ko_KR');
    return dateTimeFormat.format(this);
  }
}
