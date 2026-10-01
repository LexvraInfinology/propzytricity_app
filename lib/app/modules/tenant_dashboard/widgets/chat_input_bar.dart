import 'package:flutter/material.dart';
import 'package:propzytricity/app/theme/app_colors.dart';

class ChatInputBar extends StatelessWidget {
  const ChatInputBar({
    super.key,
    required this.controller,
    required this.onSend,
    this.onAttach,
  });

  final TextEditingController controller;
  final VoidCallback onSend;
  final VoidCallback? onAttach;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 10, 12, 10),
      decoration: const BoxDecoration(
        color: AppColors.backgroundLight,
        border: Border(top: BorderSide(color: AppColors.otpBorderColor)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IconButton(
            onPressed: onAttach,
            icon: const Icon(Icons.attach_file_rounded, color: AppColors.textGrey),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              minLines: 1,
              maxLines: 4,
              textCapitalization: TextCapitalization.sentences,
              style: const TextStyle(fontSize: 13.5, color: AppColors.textLightBlack),
              decoration: InputDecoration(
                hintText: 'Type a message...',
                hintStyle: const TextStyle(fontSize: 13.5, color: AppColors.textGrey),
                filled: true,
                fillColor: AppColors.textGrey.withValues(alpha: 0.08),
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              enabledBorder:  OutlineInputBorder(
               borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: AppColors.otpBorderColor)
               ),
                focusedBorder:  OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: AppColors.primaryLight),
                ),
                disabledBorder:  OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: AppColors.otpBorderColor),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: AppColors.otpBorderColor)
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Material(
            color: AppColors.primaryLight,
            shape: const CircleBorder(),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: onSend,
              child: const SizedBox(
                width: 44,
                height: 44,
                child: Icon(Icons.send_rounded, size: 20, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
