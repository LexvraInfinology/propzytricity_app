import 'package:flutter/material.dart';
import 'package:propzytricity/app/theme/app_colors.dart';

/// White bar pinned to the bottom of a screen (CTA buttons). Pass it as
/// `Scaffold.bottomNavigationBar`; it handles the safe area itself.
class BottomActionBar extends StatelessWidget {
  const BottomActionBar({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: const Border(top: BorderSide(color: AppColors.otpBorderColor)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 14, 24, 14),
          child: child,
        ),
      ),
    );
  }
}
