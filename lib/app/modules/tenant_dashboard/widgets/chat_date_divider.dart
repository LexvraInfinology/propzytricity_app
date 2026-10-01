import 'package:flutter/material.dart';
import 'package:propzytricity/app/theme/app_colors.dart';

class ChatDateDivider extends StatelessWidget {
  const ChatDateDivider({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          const Expanded(child: Divider(height: 1, color: AppColors.otpBorderColor)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 10.5,
                fontWeight: FontWeight.w700,
                letterSpacing: 1,
                color: AppColors.textGrey,
              ),
            ),
          ),
          const Expanded(child: Divider(height: 1, color: AppColors.otpBorderColor)),
        ],
      ),
    );
  }
}
