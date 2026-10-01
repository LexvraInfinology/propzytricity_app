import 'property_model.dart';

enum EnquiryStatus {
  awaiting('Awaiting response'),
  replied('Replied'),
  scheduled('Visit scheduled');

  const EnquiryStatus(this.label);
  final String label;
}

enum EnquiryFilter {
  all('All'),
  active('Active'),
  replied('Replied'),
  scheduled('Scheduled');

  const EnquiryFilter(this.label);
  final String label;

  /// "Active" = still needs action (awaiting reply or visit scheduled).
  bool matches(EnquiryStatus status) => switch (this) {
        EnquiryFilter.all => true,
        EnquiryFilter.active =>
          status == EnquiryStatus.awaiting || status == EnquiryStatus.scheduled,
        EnquiryFilter.replied => status == EnquiryStatus.replied,
        EnquiryFilter.scheduled => status == EnquiryStatus.scheduled,
      };
}

class EnquiryModel {
  const EnquiryModel({
    required this.id,
    required this.property,
    required this.status,
    required this.updatedAt,
    this.ownerName = 'Owner',
    this.ownerInitials = 'OP',
  });

  final String id;
  final PropertyModel property;
  final EnquiryStatus status;
  final DateTime updatedAt;
  final String ownerName;
  final String ownerInitials;

  // Demo data. Replace with API response later.
  static List<EnquiryModel> samples() {
    final now = DateTime.now();
    return [
      EnquiryModel(
        id: 'enq-1',
        status: EnquiryStatus.replied,
        updatedAt: DateTime(now.year, now.month, now.day, 10, 30),
        property: const PropertyModel(
          id: 'prop-1',
          title: 'Skyline Residency 3 BHK',
          locality: 'Sector 70',
          city: 'Mohali',
          pricePerMonth: 32000,
          bhk: 3,
          areaSqFt: 1650,
          furnishing: Furnishing.semiFurnished,
          category: PropertyCategory.apartment,
          images: ['https://picsum.photos/seed/skyline1/300/360'],
        ),
      ),
      EnquiryModel(
        id: 'enq-2',
        status: EnquiryStatus.awaiting,
        updatedAt: DateTime(now.year, now.month, now.day, 16, 15)
            .subtract(const Duration(days: 1)),
        property: const PropertyModel(
          id: 'prop-2',
          title: 'Dhakoli 3 BHK Apartment',
          locality: 'Dhakoli',
          city: 'Zirakpur',
          pricePerMonth: 26000,
          bhk: 3,
          areaSqFt: 1400,
          furnishing: Furnishing.fullyFurnished,
          category: PropertyCategory.apartment,
          images: ['https://picsum.photos/seed/dhakoli/300/360'],
        ),
      ),
      EnquiryModel(
        id: 'enq-3',
        status: EnquiryStatus.replied,
        updatedAt: DateTime(2026, 9, 12),
        property: const PropertyModel(
          id: 'prop-3',
          title: 'Aero Homes 3 BHK',
          locality: 'Aerocity',
          city: 'Mohali',
          pricePerMonth: 28000,
          bhk: 3,
          areaSqFt: 1500,
          furnishing: Furnishing.semiFurnished,
          category: PropertyCategory.apartment,
          images: ['https://picsum.photos/seed/aerohomes/300/360'],
        ),
      ),
    ];
  }
}
