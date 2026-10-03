import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:propzytricity/app/theme/app_colors.dart';
import 'package:propzytricity/app/theme/app_fonts.dart';
import 'package:propzytricity/app/theme/app_text_styles.dart';

/// Form field with the label ABOVE the box (Edit Profile style).
///
/// - Normal: pass a [controller].
/// - Read-only (grey box): pass [readOnlyValue] instead.
/// - Text area: `maxLines: 4`, and `maxLength` to get the "92/200" counter.
/// - [prefixText]: fixed text before the input, e.g. "+91".
class LabeledInputField extends StatefulWidget {
  const LabeledInputField({
    super.key,
    required this.label,
    this.controller,
    this.readOnlyValue,
    this.hint,
    this.errorText,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.maxLines = 1,
    this.maxLength,
    this.prefixText,
    this.onChanged,
  }) : assert(controller != null || readOnlyValue != null);

  final String label;
  final TextEditingController? controller;
  final String? readOnlyValue;
  final String? hint;
  final String? errorText;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final int maxLines;
  final int? maxLength;
  final String? prefixText;
  final ValueChanged<String>? onChanged;

  @override
  State<LabeledInputField> createState() => _LabeledInputFieldState();
}

class _LabeledInputFieldState extends State<LabeledInputField> {
  final FocusNode _node = FocusNode();

  @override
  void dispose() {
    _node.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final readOnly = widget.readOnlyValue != null;
    final multiline = widget.maxLines > 1;
    final hasError = widget.errorText != null;

    final textStyle = AppTextStyles.body.copyWith(
      fontSize: 12,
      fontFamily: FontFamily.plusJakartaSansMedium,
      color: AppColors.textBlack,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontSize: 12,
            fontFamily: FontFamily.plusJakartaSansMedium,
            color: AppColors.textLightBlack,
          ),
        ),
        const SizedBox(height: 8),
        ListenableBuilder(
          listenable: _node,
          builder: (context, _) {
            final borderColor = hasError
                ? AppColors.error
                : (_node.hasFocus ? AppColors.primary : AppColors.otpBorderColor);

            return AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: 14,
                vertical: multiline ? 12 : 14,
              ),
              decoration: BoxDecoration(
                color: readOnly
                    ? AppColors.otpBorderColor.withValues(alpha: 0.35)
                    : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: borderColor,
                  width: (_node.hasFocus || hasError) ? 1.4 : 1,
                ),
              ),
              child: readOnly
                  ? Text(
                      widget.readOnlyValue!,
                      style: textStyle.copyWith(color: AppColors.textGrey),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          crossAxisAlignment: multiline
                              ? CrossAxisAlignment.start
                              : CrossAxisAlignment.center,
                          children: [
                            if (widget.prefixText != null) ...[
                              Text(widget.prefixText!, style: textStyle),
                              const SizedBox(width: 8),
                            ],
                            Expanded(
                              child: TextField(
                                controller: widget.controller,
                                focusNode: _node,
                                keyboardType: widget.keyboardType,
                                textCapitalization: widget.textCapitalization,
                                minLines: widget.maxLines,
                                maxLines: widget.maxLines,
                                onChanged: widget.onChanged,
                                inputFormatters: [
                                  ...?widget.inputFormatters,
                                  if (widget.maxLength != null)
                                    LengthLimitingTextInputFormatter(
                                      widget.maxLength,
                                    ),
                                ],
                                style: textStyle,
                                // The theme fills every field; FieldBox draws
                                // the border here, so strip the theme's.
                                decoration: InputDecoration(
                                  hintText: widget.hint,
                                  hintStyle: textStyle.copyWith(
                                    color: AppColors.textGrey,
                                  ),
                                  isCollapsed: true,
                                  filled: false,
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  focusedErrorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (widget.maxLength != null && widget.controller != null)
                          ValueListenableBuilder<TextEditingValue>(
                            valueListenable: widget.controller!,
                            builder: (context, value, _) => Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Text(
                                '${value.text.length}/${widget.maxLength}',
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontFamily: FontFamily.plusJakartaSansMedium,
                                  color: AppColors.textGrey,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
            );
          },
        ),
        if (hasError)
          Padding(
            padding: const EdgeInsets.only(top: 6, left: 4),
            child: Text(
              widget.errorText!,
              style: const TextStyle(
                fontSize: 12,
                fontFamily: FontFamily.plusJakartaSansRegular,
                color: AppColors.error,
              ),
            ),
          ),
      ],
    );
  }
}
