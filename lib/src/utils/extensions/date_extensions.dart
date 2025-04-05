import 'package:intl/intl.dart';

DateTime firstDayInDateMonth(DateTime date) {
  return DateTime(date.year, date.month, 1);
}

DateTime lastDayInDateMonth(DateTime date) {
  final firstDayOfNextMonth = DateTime(date.year, date.month + 1, 1);
  final lastDayOfThisMonth =
      firstDayOfNextMonth.subtract(const Duration(days: 1));
  return lastDayOfThisMonth;
}

DateTime get firstDayInCurrentMonth {
  return firstDayInDateMonth(DateTime.now());
}

DateTime get lastDayInCurrentMonth {
  return lastDayInDateMonth(DateTime.now());
}

extension DateExtension on DateTime {
  /// dd/MM/yyyy
  String get formatDate => DateFormat('dd/MM/yyyy').format(this);
  String get formatDateFull => DateFormat('dd MMMM y').format(this);

  String get formatDatePretty => DateFormat('EEE, d MMM').format(this);
  String get formatDateDayMonthDate => DateFormat('EEE, MMM d').format(this);

  String get formatDateTimePretty =>
      DateFormat('d MMM yyyy, hh:mma').format(this);

  /// dd/MM/yy
  String get formatDateShort => DateFormat('dd/MM/yy').format(this);

  /// yyyy-MM-dd
  String get formatDateDash => DateFormat('yyyy-MM-dd').format(this);

  /// yyyy MMMM
  String get formatYearMonth => DateFormat('yyyy MMMM').format(this);

  /// yyyy MMMM
  String get formatMonthDay => DateFormat('MMM dd').format(this);

  /// dd/MM/yyyy hh:mm
  String get formatDateAndTime => DateFormat('dd/MM/yyyy hh:mm').format(this);
  String get formatTime => DateFormat('hh:mm').format(this);
  String get formatTimeOnly24 => DateFormat('HH:mm').format(this);
  String get formatTimeOnly24WithSeconds => DateFormat('HH:mm:ss').format(this);
  String get formatTimeOnlyWithSeconds => DateFormat('hh:mm:ss a').format(this);
  String get formatTimeOnlyWithSecondsAndDate =>
      DateFormat('dd/MM/yyyy hh:mm:ss a').format(this);
  String get formatTimeOnlyWithSecondsAndDate24 =>
      DateFormat('dd/MM/yyyy HH:mm:ss').format(this);
  String get formatTimeOnlyWithSecondsAndDate24WithDash =>
      DateFormat('dd-MM-yyyy HH:mm:ss').format(this);

  /// is same day as
  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  /// is same day as
  bool get isCurrentDay {
    final other = DateTime.now();
    return year == other.year && month == other.month && day == other.day;
  }
}
