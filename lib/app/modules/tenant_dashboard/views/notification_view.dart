import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propzytricity/app/data/models/app_notification_model.dart';
import 'package:propzytricity/app/modules/tenant_dashboard/controllers/tenant_dashboard_controller.dart';
import 'package:propzytricity/app/modules/tenant_dashboard/widgets/notification_card.dart';
import 'package:propzytricity/app/theme/app_colors.dart';
import 'package:propzytricity/app/theme/app_fonts.dart';
import 'package:propzytricity/app/widgets/circle_icon_button.dart';

class NotificationView extends GetView<TenantDashboardController> {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
              child: Row(
                children: [
                  CircleIconButton(
                    icon: Icons.chevron_left_rounded,
                    onTap: Get.back,
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Notifications',
                        style: TextStyle(
                          fontSize: 17,
                          fontFamily: FontFamily.plusJakartaSansBold,
                          color: AppColors.textPrimaryLight,
                        ),
                      ),
                    ),
                  ),
                  // Keeps the title centred.
                  const SizedBox(width: 44),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              // Everything is read inside this Obx, so the chips, badge and
              // list all update together.
              child: Obx(() {
                final filter = controller.notificationFilter.value;
                final unread = controller.unreadCount;
                final items = controller.visibleNotifications;

                final groups = <String, List<AppNotification>>{};
                for (final item in items) {
                  groups.putIfAbsent(item.groupLabel, () => []).add(item);
                }

                return Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        children: [
                          for (final f in NotificationFilter.values) ...[
                            if (f != NotificationFilter.values.first)
                              const SizedBox(width: 8),
                            PillChip(
                              label: f.label,
                              selected: f == filter,
                              badge: f == NotificationFilter.all ? unread : null,
                              onTap: () => controller.selectNotificationFilter(f),
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: items.isEmpty
                          ? const _EmptyNotifications()
                          : ListView(
                              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                              children: [
                                for (final entry in groups.entries) ...[
                                  _GroupHeading(
                                    label: entry.key,
                                    trailing: entry.key == groups.keys.first
                                        ? TenantDashboardController.notificationAreas
                                        : null,
                                  ),
                                  const SizedBox(height: 10),
                                  for (final n in entry.value) ...[
                                    NotificationCard(
                                      notification: n,
                                      onTap: () => controller.openNotification(n),
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                  const SizedBox(height: 8),
                                ],
                              ],
                            ),
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class _GroupHeading extends StatelessWidget {
  const _GroupHeading({required this.label, this.trailing});

  final String label;
  final String? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            letterSpacing: 1.2,
            fontFamily: FontFamily.plusJakartaSansRegular,
            color: AppColors.textGrey,
          ),
        ),
        if (trailing != null)
          Text(
            trailing!,
            style: const TextStyle(
              fontSize: 10.5,
              fontFamily: FontFamily.plusJakartaSansRegular,
              color: AppColors.textGrey,
            ),
          ),
      ],
    );
  }
}

class _EmptyNotifications extends StatelessWidget {
  const _EmptyNotifications();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.notifications_off_outlined,
            size: 44,
            color: AppColors.primary.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 12),
          const Text(
            'No notifications here',
            style: TextStyle(
              fontSize: 15,
              fontFamily: FontFamily.plusJakartaSansSemiBold,
              color: AppColors.textPrimaryLight,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'You are all caught up.',
            style: TextStyle(
              fontSize: 12.5,
              fontFamily: FontFamily.plusJakartaSansRegular,
              color: AppColors.textGrey,
            ),
          ),
        ],
      ),
    );
  }
}

class PillChip extends StatelessWidget {
  const PillChip({
    super.key,
    required this.label,
    required this.onTap,
    this.selected = false,
    this.soft = false,
    this.showChevron = false,
    this.badge,
  });

  final String label;
  final VoidCallback onTap;
  final bool selected;
  final bool soft;
  final bool showChevron;

  /// Small count bubble after the label (hidden when null or 0).
  final int? badge;

  @override
  Widget build(BuildContext context) {
    final Color background;
    final Color borderColor;
    final Color foreground;

    if (selected && soft) {
      background = AppColors.primary.withValues(alpha: 0.08);
      borderColor = AppColors.primaryLight;
      foreground = AppColors.primaryLight;
    } else if (selected) {
      background = AppColors.primaryLight;
      borderColor = AppColors.primaryLight;
      foreground = AppColors.textWhite;
    } else {
      background = Colors.white;
      borderColor = AppColors.otpBorderColor;
      foreground = AppColors.textLightBlack;
    }

    return Material(
      color: background,
      shape: StadiumBorder(side: BorderSide(color: borderColor)),
      child: InkWell(
        customBorder: const StadiumBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: selected
                      ? FontFamily.plusJakartaSansSemiBold
                      : FontFamily.plusJakartaSansMedium,
                  color: foreground,
                ),
              ),
              if (badge != null && badge! > 0) ...[
                const SizedBox(width: 6),
                Container(
                  constraints: const BoxConstraints(minWidth: 16),
                  height: 16,
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: selected && !soft ? AppColors.textWhite : AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '$badge',
                    style: TextStyle(
                      fontSize: 9.5,
                      fontFamily: FontFamily.plusJakartaSansBold,
                      color: selected && !soft ? AppColors.primary : AppColors.textWhite,
                    ),
                  ),
                ),
              ],
              if (showChevron) ...[
                const SizedBox(width: 4),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 16,
                  color: foreground,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}