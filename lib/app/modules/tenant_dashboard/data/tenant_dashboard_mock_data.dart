import 'package:propzytricity/app/data/models/app_notification_model.dart';
import 'package:propzytricity/app/data/models/locality_model.dart';
import 'package:propzytricity/app/data/models/property_model.dart';

/// Sample data so the UI can be built before the API exists.
/// Replace with a repository call (see TenantDashboardController.onInit).
class TenantDashboardMock {
  TenantDashboardMock._();

  static const List<String> cities = [
    'Chandigarh',
    'Mohali',
    'Zirakpur',
    'Kharar',
  ];

  static const List<PropertyModel> properties = [
    PropertyModel(
      id: 'p1',
      title: 'Skyline Residence 3 BHK',
      locality: 'Sector 70',
      city: 'Mohali',
      pricePerMonth: 32000,
      bhk: 3,
      areaSqFt: 1650,
      furnishing: Furnishing.semiFurnished,
      category: PropertyCategory.apartment,
      images: ['assets/images/onboarding_2.png', 'assets/images/onboarding_1.png'],
      addedDaysAgo: 3,
    ),
    PropertyModel(
      id: 'p2',
      title: 'Dhakoli 3 BHK Apartment',
      locality: 'Dhakoli',
      city: 'Zirakpur',
      pricePerMonth: 26000,
      bhk: 3,
      areaSqFt: 1520,
      furnishing: Furnishing.semiFurnished,
      category: PropertyCategory.apartment,
      images: ['assets/images/sub_onboarding_1.png'],
      addedDaysAgo: 1,
    ),
    PropertyModel(
      id: 'p3',
      title: 'Aerocity Independent House',
      locality: 'Aerocity',
      city: 'Mohali',
      pricePerMonth: 48000,
      bhk: 4,
      areaSqFt: 2600,
      furnishing: Furnishing.fullyFurnished,
      category: PropertyCategory.independentHouse,
      images: ['assets/images/sub_onboarding_2.png'],
      isNew: true,
      addedDaysAgo: 0,
    ),
    PropertyModel(
      id: 'p4',
      title: 'Green Valley Villa',
      locality: 'Sector 79',
      city: 'Mohali',
      pricePerMonth: 55000,
      bhk: 4,
      areaSqFt: 3100,
      furnishing: Furnishing.fullyFurnished,
      category: PropertyCategory.villa,
      images: ['assets/images/login_background.png'],
      addedDaysAgo: 5,
    ),
    PropertyModel(
      id: 'p5',
      title: 'Scholars PG for Students',
      locality: 'Phase 7',
      city: 'Mohali',
      pricePerMonth: 9500,
      bhk: 1,
      areaSqFt: 220,
      furnishing: Furnishing.fullyFurnished,
      category: PropertyCategory.pg,
      images: ['assets/images/sub_onboarding_2.png'],
      addedDaysAgo: 2,
    ),
    PropertyModel(
      id: 'p6',
      title: 'Sunrise 2 BHK Flat',
      locality: 'Sector 115',
      city: 'Kharar',
      pricePerMonth: 18000,
      bhk: 2,
      areaSqFt: 1100,
      furnishing: Furnishing.unfurnished,
      category: PropertyCategory.apartment,
      images: ['assets/images/onboarding_2.png'],
      isNew: true,
      addedDaysAgo: 0,
    ),
  ];

  static const List<LocalityModel> localities = [
    LocalityModel(name: 'Sector 70', propertyCount: 120, image: 'assets/images/onboarding_1.png'),
    LocalityModel(name: 'Zirakpur', propertyCount: 95, image: 'assets/images/onboarding_2.png'),
    LocalityModel(name: 'Panchkula', propertyCount: 80, image: 'assets/images/sub_onboarding_1.png'),
    LocalityModel(name: 'Kharar', propertyCount: 60, image: 'assets/images/sub_onboarding_2.png'),
  ];



  /// Options for the Location field on Edit Profile.
  static const List<String> locations = [
    'Chandigarh',
    'Mohali, Punjab',
    'Zirakpur, Punjab',
    'Kharar, Punjab',
    'Panchkula, Haryana',
  ];

  static const List<AppNotification> notifications = [
    AppNotification(
      id: 'n1',
      type: NotificationType.newListing,
      title: 'New listing in your area',
      body: 'A new 3 BHK apartment is available in Sector 70, Mohali. '
          'Matches your saved budget filter.',
      age: Duration(hours: 2),
      thumbnail: 'assets/images/property_1.jpg',
      highlight: '₹32,000/mo',
      locationTag: 'Sector 70, Mohali',
    ),
    AppNotification(
      id: 'n2',
      type: NotificationType.enquiryReply,
      title: 'Owner replied to your enquiry',
      body: 'The owner has responded to your enquiry for Skyline Residency 3 BHK.',
      age: Duration(hours: 4),
      actionLabel: 'Tap to open chat',
    ),
    AppNotification(
      id: 'n3',
      type: NotificationType.visitConfirmed,
      title: 'Visit confirmed',
      body: 'Your property visit for Aero Homes 3 BHK is confirmed for '
          'Sat, 21 Sep at 11:00 AM.',
      age: Duration(hours: 6),
      footnote: 'Agent: Vikram Sharma (Tricity Verified)',
    ),
    AppNotification(
      id: 'n4',
      type: NotificationType.planActive,
      title: 'Your plan is now active',
      body: 'You have successfully purchased the Premium Plan. '
          'You can now unlock owner details and send enquiries.',
      age: Duration(hours: 8),
      isRead: true,
    ),
    AppNotification(
      id: 'n5',
      type: NotificationType.priceDrop,
      title: 'Price drop alert',
      body: 'The rent for TDI Heights 3 BHK has dropped to ₹34,000/month.',
      age: Duration(days: 1),
      isRead: true,
      thumbnail: 'assets/images/property_2.jpg',
      highlight: '↓ ₹3,000 Price Cut',
      locationTag: 'Sector 118, Mohali',
    ),
    AppNotification(
      id: 'n6',
      type: NotificationType.savedUpdate,
      title: 'Saved property update',
      body: 'A saved property in Aerocity, Mohali is now available.',
      age: Duration(days: 1),
      isRead: true,
    ),
    AppNotification(
      id: 'n7',
      type: NotificationType.specialOffer,
      title: 'Special offer just for you',
      body: 'Get 20% extra credits on your plan upgrade. '
          'Limited time festival offer!',
      age: Duration(days: 1),
      isRead: true,
    ),
  ];
}
