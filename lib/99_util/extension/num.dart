import 'package:intl/intl.dart';

extension TEIntExtension on num {
  String format(String formatString) {
    final numberFormat = NumberFormat(formatString, 'ko_KR');
    return numberFormat.format(this);
  }

  String strClamp({num min = 0, required num max, String maxSuffix = "+"}) {
    assert(min <= max);

    if (this < min) {
      return min.toString();
    }
    if (this > max) {
      return '$max$maxSuffix';
    }
    return toString();
  }
}
