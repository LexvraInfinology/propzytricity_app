import 'package:flutter/material.dart';
import 'package:propzytricity/app/theme/app_colors.dart';
import 'package:propzytricity/app/theme/app_fonts.dart';

/// Two-thumb slider with the selected amounts shown under the thumbs.
class BudgetRangeSlider extends StatelessWidget {
  const BudgetRangeSlider({
    super.key,
    required this.values,
    required this.onChanged,
    this.min = 0,
    this.max = 40000,
    this.divisions = 40,
  });

  final RangeValues values;
  final ValueChanged<RangeValues> onChanged;
  final double min;
  final double max;
  final int divisions;

  /// 25000 -> "₹25,000", 250000 -> "₹2,50,000" (Indian grouping).
  static String formatRupees(num value) {
    final digits = value.round().toString();
    if (digits.length <= 3) return '₹$digits';

    final lastThree = digits.substring(digits.length - 3);
    var rest = digits.substring(0, digits.length - 3);
    final groups = <String>[];
    while (rest.length > 2) {
      groups.insert(0, rest.substring(rest.length - 2));
      rest = rest.substring(0, rest.length - 2);
    }
    if (rest.isNotEmpty) groups.insert(0, rest);
    return '₹${groups.join(',')},$lastThree';
  }

  @override
  Widget build(BuildContext context) {
    final startFraction = (values.start - min) / (max - min);
    final endFraction = (values.end - min) / (max - min);

    const labelStyle = TextStyle(
      fontSize: 12,
      fontFamily: FontFamily.plusJakartaSansSemiBold,
      color: AppColors.textLightBlack,
    );

    return Column(
      children: [
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 4,
            activeTrackColor: AppColors.onBoardingIndicatorColor,
            inactiveTrackColor: AppColors.otpBorderColor,
            overlayColor: AppColors.onBoardingIndicatorColor.withValues(alpha: 0.12),
            // `divisions` makes the slider snap to steps, but Flutter also
            // draws a dot for every step. Make those dots invisible.
            activeTickMarkColor: Colors.transparent,
            inactiveTickMarkColor: Colors.transparent,
            rangeThumbShape: const _RingRangeThumbShape(),
            rangeTrackShape: const RoundedRectRangeSliderTrackShape(),
          ),
          child: RangeSlider(
            values: values,
            min: min,
            max: max,
            divisions: divisions,
            onChanged: onChanged,
          ),
        ),
        SizedBox(
          height: 20,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment(2 * startFraction - 1, 0),
                  child: Text(formatRupees(values.start), style: labelStyle),
                ),
                Align(
                  alignment: Alignment(2 * endFraction - 1, 0),
                  child: Text(formatRupees(values.end), style: labelStyle),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// White thumb with a green ring.
class _RingRangeThumbShape extends RangeSliderThumbShape {
  const _RingRangeThumbShape();

  static const double _radius = 10;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) =>
      const Size.fromRadius(_radius);

  @override
  void paint(
      PaintingContext context,
      Offset center, {
        required Animation<double> activationAnimation,
        required Animation<double> enableAnimation,
        bool isDiscrete = false,
        bool isEnabled = false,
        bool? isOnTop,
        required SliderThemeData sliderTheme,
        TextDirection? textDirection,
        Thumb? thumb,
        bool? isPressed,
      }) {
    final canvas = context.canvas;
    canvas.drawCircle(center, _radius, Paint()..color = Colors.white);
    canvas.drawCircle(
      center,
      _radius - 1.5,
      Paint()
        ..color = AppColors.onBoardingIndicatorColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3,
    );
    canvas.drawCircle(center, 2.5, Paint()..color = AppColors.onBoardingIndicatorColor);
  }
}