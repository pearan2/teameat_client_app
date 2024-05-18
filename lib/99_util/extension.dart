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

    final formatted = dateTimeFormat.format(this);
    return formatted.replaceAll('PM', '오후').replaceAll('AM', '오전');
  }

  String dDay() {
    final dayLeft = difference(DateTime.now()).inDays;
    if (dayLeft < 0) return '';
    if (dayLeft == 0) return 'D-Day';
    return 'D-$dayLeft';
  }
}
