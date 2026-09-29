import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:propzytricity/app/theme/app_colors.dart';
import 'package:propzytricity/app/theme/app_text_styles.dart';

/// Row of OTP boxes driven by one invisible TextField.
///
/// Using a single real field (instead of one per box) keeps paste, backspace
/// and SMS autofill (`AutofillHints.oneTimeCode`) working properly.
class OtpInput extends StatelessWidget {
  const OtpInput({
    super.key,
    required this.length,
    required this.controller,
    required this.focusNode,
    this.onChanged,
    this.onCompleted,
    this.hasError = false,
    this.autofocus = false,
    this.gap = 10,
    this.maxBoxWidth = 52,
    this.boxHeight = 56,
  });

  final int length;
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onCompleted;
  final bool hasError;

  /// Opens the keyboard as soon as the screen is shown.
  final bool autofocus;
  final double gap;
  final double maxBoxWidth;
  final double boxHeight;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: focusNode.requestFocus,
      child: Stack(
        children: [
          ListenableBuilder(
            listenable: Listenable.merge([controller, focusNode]),
            builder: (context, _) => _buildBoxes(context),
          ),
          // The real input: invisible, but it owns the keyboard and the text.
          Positioned(
            left: 0,
            top: 0,
            child: Opacity(
              opacity: 0,
              child: SizedBox(
                width: 1,
                height: 1,
                child: TextField(
                  controller: controller,
                  focusNode: focusNode,
                  autofocus: autofocus,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  autofillHints: const [AutofillHints.oneTimeCode],
                  enableInteractiveSelection: false,
                  showCursor: false,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(length),
                  ],
                  onChanged: (value) {
                    onChanged?.call(value);
                    if (value.length == length) onCompleted?.call(value);
                  },
                  decoration: const InputDecoration.collapsed(hintText: ''),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBoxes(BuildContext context) {
    final text = controller.text;
    final activeIndex = text.length >= length ? length - 1 : text.length;
    final errorColor = Theme.of(context).colorScheme.error;

    return LayoutBuilder(
      builder: (context, constraints) {
        final available = constraints.maxWidth - gap * (length - 1);
        final boxWidth = math.max(0.0, math.min(maxBoxWidth, available / length));

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var i = 0; i < length; i++) ...[
              if (i > 0) SizedBox(width: gap),
              _OtpBox(
                width: boxWidth,
                height: boxHeight,
                char: i < text.length ? text[i] : '',
                active: focusNode.hasFocus && i == activeIndex,
                hasError: hasError,
                errorColor: errorColor,
              ),
            ],
          ],
        );
      },
    );
  }
}

class _OtpBox extends StatelessWidget {
  const _OtpBox({
    required this.width,
    required this.height,
    required this.char,
    required this.active,
    required this.hasError,
    required this.errorColor,
  });

  final double width;
  final double height;
  final String char;
  final bool active;
  final bool hasError;
  final Color errorColor;

  @override
  Widget build(BuildContext context) {
    final Color borderColor;
    if (hasError) {
      borderColor = errorColor;
    } else if (active) {
      borderColor = AppColors.onBoardingIndicatorColor;
    } else if (char.isNotEmpty) {
      borderColor = AppColors.primary.withValues(alpha: 0.45);
    } else {
      borderColor = AppColors.otpBorderColor;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      width: width,
      height: height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: active ? AppColors.textWhite:AppColors.otpFiledColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: borderColor, width: active ? 1.6 : 1.2),
      ),
      child: char.isNotEmpty
          ? Text(char, style: AppTextStyles.heading2.copyWith(fontSize: 20))
          : (active ? const _BlinkingCursor() : null),
    );
  }
}

class _BlinkingCursor extends StatefulWidget {
  const _BlinkingCursor();

  @override
  State<_BlinkingCursor> createState() => _BlinkingCursorState();
}

class _BlinkingCursorState extends State<_BlinkingCursor>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 600),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: Container(
        width: 1.6,
        height: 22,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(1),
        ),
      ),
    );
  }
}
