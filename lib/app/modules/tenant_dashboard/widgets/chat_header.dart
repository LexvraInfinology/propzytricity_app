import 'package:flutter/material.dart';
import 'package:propzytricity/app/theme/app_colors.dart';
import 'package:propzytricity/app/theme/app_fonts.dart';
import 'package:propzytricity/app/widgets/initials_avatar.dart';
import 'package:propzytricity/app/widgets/round_icon_button.dart';

class ChatHeader extends StatelessWidget {
  const ChatHeader({
    super.key,
    required this.name,
    required this.initials,
    required this.subtitle,
    required this.onBack,
    this.onMore,
  });

  final String name;
  final String initials;
  final String subtitle;
  final VoidCallback onBack;
  final VoidCallback? onMore;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 8, 10),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.otpBorderColor)),
      ),
      child: Row(
        children: [
          RoundIconButton(icon: Icons.chevron_left, iconSize: 22, onTap: onBack),
          const SizedBox(width: 10),
          InitialsAvatar(
            name: name,
            onTap: () {},
          ),
          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 14.5,
                    fontFamily: FontFamily.plusJakartaSansBold,
                    color: AppColors.textLightBlack,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 11,
                      fontFamily: FontFamily.plusJakartaSansRegular,
                      color: AppColors.textGrey),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onMore,
            icon: const Icon(Icons.more_vert, color: AppColors.textGrey),
          ),
        ],
      ),
    );
  }
}
