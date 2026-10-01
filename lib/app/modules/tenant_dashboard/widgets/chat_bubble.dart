import 'package:flutter/material.dart';
import 'package:propzytricity/app/data/models/chat_message_model.dart';
import 'package:propzytricity/app/theme/app_colors.dart';
import 'package:propzytricity/app/theme/app_fonts.dart';
import 'package:propzytricity/app/utils/date_time_extension.dart';
import 'package:propzytricity/app/widgets/initials_avatar.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.message,
    required this.initials,
    required this.name,
    this.showAvatar = true,
  });

  final ChatMessageModel message;
  final String initials;
  final String name;
  final bool showAvatar;

  static const _avatarSize = 26.0;

  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.sizeOf(context).width * 0.70;
    return message.isMine ? _mine(maxWidth) : _theirs(maxWidth);
  }

  Widget _mine(double maxWidth) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Container(
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 6),
          decoration: BoxDecoration(
            color: AppColors.primaryLight.withValues(alpha: 0.14),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(4),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(message.text, style: _textStyle),
              const SizedBox(height: 4),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(message.sentAt.timeLabel, style: _timeStyle),
                  const SizedBox(width: 4),
                  Icon(
                    message.isRead ? Icons.done_all : Icons.done,
                    size: 14,
                    color: message.isRead ? AppColors.primaryLight : AppColors.textGrey,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _theirs(double maxWidth) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: showAvatar
              ?  InitialsAvatar(
                      name: name,
                      size: _avatarSize,
                      onTap: () {},
                    )
              : const SizedBox(width: _avatarSize),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.textGrey.withValues(alpha: 0.12),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                      bottomLeft: Radius.circular(4),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                  child: Text(message.text, style: _textStyle),
                ),
                const SizedBox(height: 4),
                Text(message.sentAt.timeLabel, style: _timeStyle),
              ],
            ),
          ),
        ),
      ],
    );
  }

  static const _textStyle = TextStyle(
    fontSize: 13.5,
    height: 1.35,
    fontFamily: FontFamily.plusJakartaSansRegular,
    color: AppColors.textLightBlack,
  );

  static const _timeStyle = TextStyle(fontSize: 10,
      fontFamily: FontFamily.plusJakartaSansRegular,
      color: AppColors.textGrey);
}
