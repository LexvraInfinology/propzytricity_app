/// Indian number grouping: 1650 -> "1,650", 2600000 -> "26,00,000".
class PriceFormatter {
  PriceFormatter._();

  static String number(num value) {
    final digits = value.round().toString();
    if (digits.length <= 3) return digits;

    final lastThree = digits.substring(digits.length - 3);
    var rest = digits.substring(0, digits.length - 3);
    final groups = <String>[];
    while (rest.length > 2) {
      groups.insert(0, rest.substring(rest.length - 2));
      rest = rest.substring(0, rest.length - 2);
    }
    if (rest.isNotEmpty) groups.insert(0, rest);
    return '${groups.join(',')},$lastThree';
  }

  /// 32000 -> "₹32,000"
  static String rupees(num value) => '₹${number(value)}';
}


extension InrFormat on num {
  /// 1650 -> 1,650 | 6400000 -> 64,00,000
  String get toGrouped {
    return round().toString().replaceAllMapped(
      RegExp(r'(\d)(?=(\d\d)+\d$)'),
          (m) => '${m[1]},',
    );
  }

  /// 32000 -> ₹32,000 | 6400000 -> ₹64,00,000
  String get toInr => '₹$toGrouped';
}
