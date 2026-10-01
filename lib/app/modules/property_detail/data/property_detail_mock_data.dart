import 'package:propzytricity/app/data/models/property_detail_model.dart';
import 'package:propzytricity/app/data/models/property_model.dart';

/// Sample detail data so the UI can be built before the API exists.
/// Replace `forProperty` with a repository call that returns the same model.
class PropertyDetailMock {
  PropertyDetailMock._();

  static const List<String> _photoLibrary = [
    'assets/images/property_1.jpg',
    'assets/images/property_2.jpg',
    'assets/images/property_3.jpg',
    'assets/images/property_4.jpg',
    'assets/images/property_5.jpg',
    'assets/images/property_6.jpg',
  ];

  static PropertyDetailModel forProperty(PropertyModel p) {
    // The property's own photos first, then the rest, without repeats.
    final photos = <String>{...p.images, ..._photoLibrary}.toList();

    return PropertyDetailModel(
      property: p,
      description:
          '${p.title} in ${p.locality}, ${p.city}. Spacious ${p.bhk} BHK home '
          'with modern interiors, ample natural light and a peaceful society '
          'with all essential amenities. Ideal for families and working '
          'professionals. Close to schools, markets, hospitals and public '
          'transport.',
      postedBy: 'Owner',
      availableFrom: '1st Feb 2026',
      deposit: p.pricePerMonth * 2,
      amenities: Amenity.values,
      photos: photos,
      address: '${p.locality}, ${p.city}, Punjab',
      mapImage: 'assets/images/map_preview.jpg',
      floorPlanImage: 'assets/images/floor_plan.jpg',
    );
  }
}
