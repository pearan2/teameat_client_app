import 'package:intl/intl.dart';

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

  String dayOfWeekKor() {
    final korDayOfWeeks = ['월', '화', '수', '목', '금', '토', '일'];
    return korDayOfWeeks[weekday - 1];
  }

  DateTime firstDateOfTheWeek() {
    return subtract(Duration(days: weekday - 1));
  }

  DateTime lastDayOfTheWeek() {
    return add(Duration(days: DateTime.daysPerWeek - weekday));
  }

  String dateString({String formatString = "yyyy-MM-dd"}) {
    final dateTimeFormat = DateFormat(formatString, 'ko_KR');
    return dateTimeFormat.format(this);
  }
}
