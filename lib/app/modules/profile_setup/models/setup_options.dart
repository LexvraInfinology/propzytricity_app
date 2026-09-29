import 'package:flutter/material.dart';
import 'package:propzytricity/app/core/constants/app_assets.dart';

enum UserRole { tenant, owner }

enum PropertyInterest {
  rent(AppIcons.apartmentIcon, 'Rent'),
  buy(AppIcons.home, 'Buy'),
  pg(AppIcons.pgIcon, 'PG');

  const PropertyInterest(this.icon, this.label);
  final String icon;
  final String label;
}

enum PropertyType {
  apartment(AppIcons.apartmentIcon, 'Apartment'),
  independentHouse(AppIcons.home, 'Independent House'),
  builderFloor(AppIcons.floorIcon, 'Builder Floor');

  const PropertyType(this.icon, this.label);
  final String icon;
  final String label;
}

/// Static choices for the dropdowns.
class SetupOptions {
  SetupOptions._();

  static const List<String> cities = [
    'Chandigarh',
    'Mohali',
    'Zirakpur',
    'Kharar',
  ];

  static const List<String> languages = ['English', 'Hindi', 'Punjabi'];

  static const double budgetMin = 0;
  static const double budgetMax = 40000;
  static const RangeValues defaultBudget = RangeValues(5000, 25000);
}
