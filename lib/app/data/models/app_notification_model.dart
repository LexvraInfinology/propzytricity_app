import 'package:flutter/material.dart';

enum NotificationType {
  newListing(Icons.home_work_outlined),
  enquiryReply(Icons.chat_bubble_outline_rounded),
  visitConfirmed(Icons.calendar_today_outlined),
  planActive(Icons.notifications_none_rounded),
  priceDrop(Icons.trending_down_rounded),
  savedUpdate(Icons.favorite_border_rounded),
  specialOffer(Icons.campaign_outlined);

  const NotificationType(this.icon);
  final IconData icon;
}

/// Filter chips on the notifications screen.
enum NotificationFilter {
  all('All'),
  enquiries('Enquiries'),
  newListings('New Listings'),
  visits('Visits');

  const NotificationFilter(this.label);
  final String label;

  bool matches(NotificationType type) {
    switch (this) {
      case NotificationFilter.all:
        return true;
      case NotificationFilter.enquiries:
        return type == NotificationType.enquiryReply;
      case NotificationFilter.newListings:
        return type == NotificationType.newListing ||
            type == NotificationType.priceDrop ||
            type == NotificationType.savedUpdate;
      case NotificationFilter.visits:
        return type == NotificationType.visitConfirmed;
    }
  }
}

/// Named AppNotification because Flutter already has a `Notification` class.
class AppNotification {
  const AppNotification({
    required this.id,
    required this.type,
    required this.title,
    required this.body,
    required this.age,
    this.isRead = false,
    this.thumbnail,
    this.highlight,
    this.locationTag,
    this.actionLabel,
    this.footnote,
  });

  final String id;
  final NotificationType type;
  final String title;
  final String body;

  /// How old the notification is. Replace with a real timestamp from the API.
  final Duration age;
  final bool isRead;

  /// Small photo shown instead of the type icon (listing alerts).
  final String? thumbnail;

  /// Green chip, e.g. "₹32,000/mo" or "↓ ₹3,000 Price Cut".
  final String? highlight;
  final String? locationTag;

  /// Green call to action, e.g. "Tap to open chat".
  final String? actionLabel;

  /// Verified chip at the bottom, e.g. "Agent: Vikram Sharma (Tricity Verified)".
  final String? footnote;

  String get timeLabel {
    if (age.inHours < 1) return '${age.inMinutes.clamp(1, 59)}m ago';
    if (age.inHours < 24) return '${age.inHours}h ago';
    return '${age.inDays}d ago';
  }

  String get groupLabel {
    final days = age.inHours ~/ 24;
    if (days == 0) return 'TODAY';
    if (days == 1) return 'YESTERDAY';
    return 'EARLIER';
  }

  AppNotification copyWith({bool? isRead}) {
    return AppNotification(
      id: id,
      type: type,
      title: title,
      body: body,
      age: age,
      isRead: isRead ?? this.isRead,
      thumbnail: thumbnail,
      highlight: highlight,
      locationTag: locationTag,
      actionLabel: actionLabel,
      footnote: footnote,
    );
  }
}
