import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class ExpandableText extends StatefulWidget {
  const ExpandableText({
    super.key,
    required this.text,
    this.trimLines = 3,
    this.style,
  });

  final String text;
  final int trimLines;
  final TextStyle? style;

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _expanded = false;

  TextStyle get _style =>
      widget.style ??
      const TextStyle(fontSize: 12.5, height: 1.5, color: AppColors.textGrey);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final painter = TextPainter(
          text: TextSpan(text: widget.text, style: _style),
          maxLines: widget.trimLines,
          textDirection: TextDirection.ltr,
        )..layout(maxWidth: constraints.maxWidth);
        final overflows = painter.didExceedMaxLines;
        painter.dispose();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedSize(
              duration: const Duration(milliseconds: 200),
              alignment: Alignment.topCenter,
              child: Text(
                widget.text,
                style: _style,
                maxLines: _expanded ? null : widget.trimLines,
                overflow: _expanded ? TextOverflow.visible : TextOverflow.ellipsis,
              ),
            ),
            if (overflows)
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => setState(() => _expanded = !_expanded),
                child: Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _expanded ? 'Show less' : 'Read more',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryLight,
                        ),
                      ),
                      Icon(
                        _expanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        size: 16,
                        color: AppColors.primaryLight,
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
