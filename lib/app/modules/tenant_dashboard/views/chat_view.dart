import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propzytricity/app/modules/tenant_dashboard/controllers/tenant_dashboard_controller.dart';
import 'package:propzytricity/app/modules/tenant_dashboard/widgets/chat_bubble.dart';
import 'package:propzytricity/app/modules/tenant_dashboard/widgets/chat_date_divider.dart';
import 'package:propzytricity/app/modules/tenant_dashboard/widgets/chat_header.dart';
import 'package:propzytricity/app/modules/tenant_dashboard/widgets/chat_input_bar.dart';
import 'package:propzytricity/app/modules/tenant_dashboard/widgets/chat_property_card.dart';
import 'package:propzytricity/app/modules/tenant_dashboard/widgets/chat_status_banner.dart';
import 'package:propzytricity/app/theme/app_colors.dart';
import 'package:propzytricity/app/utils/date_time_extension.dart';


class ChatView extends GetView<TenantDashboardController> {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    final enquiry = controller.activeEnquiry.value;
    if (enquiry == null) return const SizedBox.shrink();

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            ChatHeader(
              name: enquiry.ownerName,
              initials: enquiry.ownerInitials,
              subtitle: controller.lastSeenLabel,
              onBack: () => Get.back(),
              onMore: controller.onMoreTap,
            ),
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: ChatPropertyCard(
              property: enquiry.property,
              onTap: controller.onPropertyTap,
            ),
          ),
            const Padding(
              padding: EdgeInsets.only(bottom: 4),
              child: ChatStatusBanner(
                title: 'Owner responded',
                subtitle:
                'You can continue the conversation or schedule a visit.',
              ),
            ),
            Expanded(
              child: Obx(() {
                final messages = controller.messages;
                return ListView.builder(
                  controller: controller.scrollController,
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
                  itemCount: messages.length ,
                  itemBuilder: (context, index) {
                    final i = index ;
                    final message = messages[i];
                    final prev = i > 0 ? messages[i - 1] : null;
                    final newDay = prev == null || !prev.sentAt.isSameDay(message.sentAt);
                    final showAvatar =
                        !message.isMine && (newDay || (prev?.isMine ?? true));

                    return Column(
                      children: [
                        if (newDay)
                          ChatDateDivider(label: message.sentAt.dayLabel.toUpperCase()),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: ChatBubble(
                            message: message,
                            initials: enquiry.ownerInitials,
                            showAvatar: showAvatar,
                            name: enquiry.ownerName,
                          ),
                        ),
                      ],
                    );
                  },
                );
              }),
            ),
            ChatInputBar(
              controller: controller.inputController,
              onSend: controller.sendMessage,
              onAttach: controller.onAttachTap,
            ),
          ],
        ),
      ),
    );
  }
}
