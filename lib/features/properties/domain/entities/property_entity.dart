/// Property Entity
class PropertyEntity {
  final String id;
  final String titleAr;
  final String titleEn;
  final String descriptionAr;
  final String descriptionEn;
  final String category; // 'apartment', 'villa', 'studio', 'commercial', 'chalet'
  final String city;
  final String district;
  final double pricePerYear;
  final double areaM2;
  final int bedrooms;
  final int bathrooms;
  final int floor;
  final bool isFurnished;
  final bool isVerified;
  final bool isAvailable;
  final List<String> amenities;
  final List<String> images;
  final String landlordId;
  final String landlordName;
  final String landlordPhone;

  const PropertyEntity({
    required this.id,
    required this.titleAr,
    required this.titleEn,
    required this.descriptionAr,
    required this.descriptionEn,
    required this.category,
    required this.city,
    required this.district,
    required this.pricePerYear,
    required this.areaM2,
    required this.bedrooms,
    required this.bathrooms,
    required this.floor,
    required this.isFurnished,
    required this.isVerified,
    required this.isAvailable,
    required this.amenities,
    required this.images,
    required this.landlordId,
    required this.landlordName,
    required this.landlordPhone,
  });

  String localizedTitle(String langCode) => langCode == 'ar' ? titleAr : titleEn;
  String localizedDescription(String langCode) => langCode == 'ar' ? descriptionAr : descriptionEn;

  double get pricePerMonth => pricePerYear / 12.0;
}
