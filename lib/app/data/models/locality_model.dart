class LocalityModel {
  const LocalityModel({
    required this.name,
    required this.propertyCount,
    required this.image,
  });

  final String name;
  final int propertyCount;
  final String image;

  String get countLabel => '$propertyCount+ Properties';
}
