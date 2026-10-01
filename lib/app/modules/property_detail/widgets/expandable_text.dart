import 'package:flutter/material.dart';
import 'package:propzytricity/app/theme/app_colors.dart';
import 'package:propzytricity/app/theme/app_fonts.dart';

/// Paragraph clipped to [maxLines] with a "Read more" toggle. The toggle only
/// appears when the text really is longer than [maxLines].
class ExpandableText extends StatefulWidget {
  const ExpandableText(
    this.text, {
    super.key,
    this.maxLines = 4,
    this.style = const TextStyle(
      fontSize: 13,
      height: 1.6,
      fontFamily: FontFamily.plusJakartaSansRegular,
      color: AppColors.textGrey,
    ),
  });

  final String text;
  final int maxLines;
  final TextStyle style;

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final painter = TextPainter(
          text: TextSpan(text: widget.text, style: widget.style),
          maxLines: widget.maxLines,
          textDirection: TextDirection.ltr,
        )..layout(maxWidth: constraints.maxWidth);
        final overflows = painter.didExceedMaxLines;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedSize(
              duration: const Duration(milliseconds: 200),
              alignment: Alignment.topCenter,
              child: Text(
                widget.text,
                style: widget.style,
                maxLines: _expanded ? null : widget.maxLines,
                overflow: _expanded ? TextOverflow.visible : TextOverflow.ellipsis,
              ),
            ),
            if (overflows)
              GestureDetector(
                onTap: () => setState(() => _expanded = !_expanded),
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _expanded ? 'Read less' : 'Read more',
                        style: const TextStyle(
                          fontSize: 12.5,
                          fontFamily: FontFamily.plusJakartaSansSemiBold,
                          color: AppColors.textGreen,
                        ),
                      ),
                      Icon(
                        _expanded
                            ? Icons.keyboard_arrow_up_rounded
                            : Icons.keyboard_arrow_down_rounded,
                        size: 18,
                        color: AppColors.textGreen,
                      ),
                    ],
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
