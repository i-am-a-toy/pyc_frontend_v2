import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  /// getDifferenceNow
  ///
  /// 날짜와 현재 시간의 차이를 return하는 method
  String getDifferenceNow() {
    final today = DateTime.now().dateOnly();
    final target = dateOnly();

    if (DateUtils.isSameDay(today, target)) return '오늘';

    final Duration duration = today.difference(target);
    return duration.inDays < 2 ? '${duration.inDays}일전' : DateFormat('yyyy-MM-dd HH:mm').format(this);
  }

  /// dateOnly
  ///
  /// 시간을 제외한 날짜를 만들어 주는 method
  DateTime dateOnly() {
    return DateTime(year, month, day);
  }

  /// isAfterOrEqualTo
  ///
  /// 시간이 인자로 받은 시간과 동일하거나 이후인지 비교해주는 method
  bool isAfterOrEqualTo(DateTime dateTime) {
    final isAtSameMomentAs = dateTime.isAtSameMomentAs(this);
    return isAtSameMomentAs | isAfter(dateTime);
  }

  DateTime getStartOfWeek() {
    return dateOnly().subtract(Duration(days: weekday));
  }

  DateTime getEndOfWeek() {
    return dateOnly().add(Duration(days: DateTime.daysPerWeek - weekday));
  }

  String toYYYYMMDD() {
    return DateFormat('yyyy-MM-dd').format(this);
  }

  String toYYMMDD() {
    return DateFormat('yy-MM-dd').format(this);
  }

  String toHHmm() {
    return DateFormat('HH:mm').format(this);
  }

  String toMMDDHHmm() {
    return DateFormat('MM-dd HH:mm').format(this);
  }

  String toMMDD() {
    return DateFormat('MM-dd').format(this);
  }
}
