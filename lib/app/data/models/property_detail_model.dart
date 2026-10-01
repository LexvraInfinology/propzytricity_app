import 'package:flutter/material.dart';
import 'package:propzytricity/app/data/models/property_model.dart';

enum Amenity {
  parking(Icons.local_parking_rounded, 'Parking'),
  lift(Icons.elevator_outlined, 'Lift'),
  powerBackup(Icons.bolt_rounded, 'Power Backup'),
  security(Icons.shield_outlined, 'Security'),
  gym(Icons.fitness_center_rounded, 'Gym'),
  clubHouse(Icons.weekend_outlined, 'Club House'),
  kidsPlay(Icons.child_care_rounded, 'Kids Play'),
  garden(Icons.yard_outlined, 'Garden'),
  cctv(Icons.videocam_outlined, 'CCTV'),
  waterSupply(Icons.water_drop_outlined, 'Water Supply');

  const Amenity(this.icon, this.label);
  final IconData icon;
  final String label;
}

/// Everything the detail page shows, on top of the list-card [PropertyModel].
class PropertyDetailModel {
  const PropertyDetailModel({
    required this.property,
    required this.description,
    required this.postedBy,
    required this.availableFrom,
    required this.deposit,
    required this.amenities,
    required this.photos,
    required this.address,
    required this.mapImage,
    required this.floorPlanImage,
  });

  final PropertyModel property;
  final String description;
  final String postedBy;
  final String availableFrom;
  final int deposit;
  final List<Amenity> amenities;
  final List<String> photos;
  final String address;
  final String mapImage;
  final String floorPlanImage;
}
