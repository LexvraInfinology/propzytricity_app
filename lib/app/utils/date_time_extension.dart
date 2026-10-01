const _months = [
  'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
  'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
];

extension DateTimeLabels on DateTime {
  /// 10:16 AM
  String get timeLabel {
    final h = hour % 12 == 0 ? 12 : hour % 12;
    final m = minute.toString().padLeft(2, '0');
    return '$h:$m ${hour < 12 ? 'AM' : 'PM'}';
  }

  bool isSameDay(DateTime other) =>
      year == other.year && month == other.month && day == other.day;

  /// Today / Yesterday / 12 Sep 2026
  String get dayLabel {
    final now = DateTime.now();
    if (isSameDay(now)) return 'Today';
    if (isSameDay(now.subtract(const Duration(days: 1)))) return 'Yesterday';
    return '$day ${_months[month - 1]} $year';
  }

  /// Today, 10:30 AM / Yesterday, 4:15 PM / 12 Sep 2026
  String get enquiryLabel {
    final label = dayLabel;
    final isRecent = label == 'Today' || label == 'Yesterday';
    return isRecent ? '$label, $timeLabel' : label;
  }
}
