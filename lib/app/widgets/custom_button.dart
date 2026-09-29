import 'package:flutter/material.dart';
import 'package:propzytricity/app/theme/app_colors.dart';
import 'package:propzytricity/app/theme/app_text_styles.dart';

enum CustomButtonVariant { filled, outlined }

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.variant = CustomButtonVariant.filled,
    this.isLoading = false,
    this.leading,
    this.trailing,
    this.expand = true,
    this.height = 52,
    this.radius = 16,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.textStyle,
  });

  final String text;
  final VoidCallback? onPressed;
  final CustomButtonVariant variant;
  final bool isLoading;
  final Widget? leading;
  final Widget? trailing;
  final bool expand;
  final double height;
  final double radius;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final TextStyle? textStyle;

  bool get _filled => variant == CustomButtonVariant.filled;

  @override
  Widget build(BuildContext context) {
    final bg = backgroundColor ?? (_filled ? AppColors.primary : Colors.white);
    final fg = foregroundColor ??
        (_filled ? Colors.white : AppColors.textPrimaryLight);

    final onTap = isLoading ? null : onPressed;
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius),
    );
    final minSize = Size(expand ? double.infinity : 0, height);
    final label = textStyle ?? AppTextStyles.button;

    final child = isLoading
        ? SizedBox(
      height: 22,
      width: 22,
      child: CircularProgressIndicator(strokeWidth: 2.4, color: fg),
    )
        : Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (leading != null) ...[leading!, const SizedBox(width: 10)],
        Flexible(child: Text(text, overflow: TextOverflow.ellipsis)),
        if (trailing != null) ...[const SizedBox(width: 8), trailing!],
      ],
    );

    if (_filled) {
      return ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: bg,
          foregroundColor: fg,
          // Keep the same colours while loading instead of turning grey.
          disabledBackgroundColor: isLoading ? bg : null,
          disabledForegroundColor: isLoading ? fg : null,
          elevation: 0,
          minimumSize: minSize,
          textStyle: label,
          shape: shape,
        ),
        child: child,
      );
    }

    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        backgroundColor: bg,
        foregroundColor: fg,
        disabledBackgroundColor: isLoading ? bg : null,
        disabledForegroundColor: isLoading ? fg : null,
        side: BorderSide(color: borderColor ?? AppColors.otpBorderColor),
        minimumSize: minSize,
        textStyle: label,
        shape: shape,
      ),
      child: child,
    );
  }
}