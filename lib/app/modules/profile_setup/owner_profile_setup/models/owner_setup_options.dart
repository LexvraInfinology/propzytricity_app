import 'package:flutter/material.dart';
import 'package:propzytricity/app/core/constants/app_assets.dart';

/// Step 2: what the owner wants to do with the property.
enum OwnerGoal {
  sell(AppIcons.sellIcon, 'Sell', 'Find buyers for my property.'),
  rent(AppIcons.keyIcon, 'Rent', 'Find tenants for my property.');

  const OwnerGoal(this.icon, this.label, this.description);
  final String icon;
  final String label;
  final String description;
}

/// Step 2: who is listing.
enum OwnerType {
  individualOwner(
    AppIcons.profileIcon,
    'Individual Owner',
    'I own the property personally.',
  ),
  builderAgent(
    AppIcons.apartmentIcon,
    'Builder / Agent',
    'I represent a builder or real estate agency.',
  );

  const OwnerType(this.icon, this.label, this.description);
  final String icon;
  final String label;
  final String description;
}
