import 'package:flutter/material.dart';

enum PropertyCategory {
  apartment(Icons.apartment_rounded, 'Apartment', 'Apartments'),
  independentHouse(Icons.home_outlined, 'Independent House', 'Independent Houses'),
  villa(Icons.villa_outlined, 'Villa', 'Villas'),
  pg(Icons.groups_outlined, 'PG / Co-living', 'PG / Co-living');

  const PropertyCategory(this.icon, this.label, this.plural);
  final IconData icon;
  final String label;
  final String plural;
}

enum Furnishing {
  unfurnished('Unfurnished'),
  semiFurnished('Semi-Furnished'),
  fullyFurnished('Fully Furnished');

  const Furnishing(this.label);
  final String label;
}

class PropertyModel {
  const PropertyModel({
    required this.id,
    required this.title,
    required this.locality,
    required this.city,
    required this.pricePerMonth,
    required this.bhk,
    required this.areaSqFt,
    required this.furnishing,
    required this.category,
    required this.images,
    this.isVerified = true,
    this.isNew = false,
    this.isFavorite = false,
    this.addedDaysAgo = 0,
  });

  final String id;
  final String title;
  final String locality;
  final String city;
  final int pricePerMonth;
  final int bhk;
  final int areaSqFt;
  final Furnishing furnishing;
  final PropertyCategory category;
  final List<String> images;
  final bool isVerified;
  final bool isNew;
  final bool isFavorite;
  final int addedDaysAgo;

  String get location => '$locality, $city';

  PropertyModel copyWith({bool? isFavorite}) {
    return PropertyModel(
      id: id,
      title: title,
      locality: locality,
      city: city,
      pricePerMonth: pricePerMonth,
      bhk: bhk,
      areaSqFt: areaSqFt,
      furnishing: furnishing,
      category: category,
      images: images,
      isVerified: isVerified,
      isNew: isNew,
      isFavorite: isFavorite ?? this.isFavorite,
      addedDaysAgo: addedDaysAgo,
    );
  }
}
