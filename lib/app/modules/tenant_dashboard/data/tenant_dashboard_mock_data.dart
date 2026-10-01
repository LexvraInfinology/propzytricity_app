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
}
