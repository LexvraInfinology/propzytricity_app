import 'package:flutter/material.dart';
import 'package:propzytricity/app/data/models/app_notification_model.dart';
import 'package:propzytricity/app/theme/app_colors.dart';
import 'package:propzytricity/app/theme/app_fonts.dart';
import 'package:propzytricity/app/widgets/asset_photo.dart';

/// One notification. Unread ones get a green tint and a dot.
class NotificationCard extends StatelessWidget {
  const NotificationCard({
    super.key,
    required this.notification,
    required this.onTap,
  });

  final AppNotification notification;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final n = notification;
    final unread = !n.isRead;

    return Material(
      color: unread ? AppColors.primary.withValues(alpha: 0.07) : Colors.white,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(
          color: unread
              ? AppColors.primary.withValues(alpha: 0.2)
              : AppColors.otpBorderColor,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Leading(notification: n),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Flexible(
                                child: Text(
                                  n.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontFamily: FontFamily.plusJakartaSansRegular,
                                    color: AppColors.textBlack,
                                  ),
                                ),
                              ),
                              if (unread)
                                Container(
                                  margin: const EdgeInsets.only(left: 6),
                                  height: 8,
                                  width: 8,
                                  decoration: const BoxDecoration(
                                    color: AppColors.primary,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          n.timeLabel,
                          style: const TextStyle(
                            fontSize: 11,
                            fontFamily: FontFamily.plusJakartaSansRegular,
                            color: AppColors.textGrey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Text(
                      n.body,
                      style: const TextStyle(
                        fontSize: 11,
                        height: 1.45,
                        fontFamily: FontFamily.plusJakartaSansRegular,
                        color: AppColors.textGrey,
                      ),
                    ),
                    if (n.highlight != null || n.locationTag != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Row(
                          children: [
                            if (n.highlight != null)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withValues(alpha: 0.10),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  n.highlight!,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontFamily: FontFamily.plusJakartaSansRegular,
                                    color: AppColors.textGreen,
                                  ),
                                ),
                              ),
                            if (n.highlight != null && n.locationTag != null)
                              const SizedBox(width: 8),
                            if (n.locationTag != null)
                              Flexible(
                                child: Text(
                                  n.locationTag!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontFamily: FontFamily.plusJakartaSansRegular,
                                    color: AppColors.textGrey,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    if (n.actionLabel != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              n.actionLabel!,
                              style: const TextStyle(
                                fontSize: 11,
                                fontFamily: FontFamily.plusJakartaSansSemiBold,
                                color: AppColors.textGreen,
                              ),
                            ),
                            const Icon(
                              Icons.chevron_right_rounded,
                              size: 15,
                              color: AppColors.textGreen,
                            ),
                          ],
                        ),
                      ),
                    if (n.footnote != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: AppColors.otpBorderColor),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.verified_rounded,
                                size: 12,
                                color: AppColors.primary,
                              ),
                              const SizedBox(width: 4),
                              Flexible(
                                child: Text(
                                  n.footnote!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontFamily: FontFamily.plusJakartaSansMedium,
                                    color: AppColors.textLightBlack,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Leading extends StatelessWidget {
  const _Leading({required this.notification});

  final AppNotification notification;

  @override
  Widget build(BuildContext context) {
    final thumbnail = notification.thumbnail;

    if (thumbnail != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: SizedBox(height: 44, width: 44, child: AssetPhoto(thumbnail)),
      );
    }

    return Container(
      height: 48,
      width: 48,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(notification.type.icon, size: 20, color: AppColors.primary),
    );
  }
}
