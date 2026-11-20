/// Filter Criteria Entity
class PropertyFilter {
  final String? category;
  final String? city;
  final double? minPrice;
  final double? maxPrice;
  final int? minBedrooms;
  final String? searchQuery;

  const PropertyFilter({
    this.category,
    this.city,
    this.minPrice,
    this.maxPrice,
    this.minBedrooms,
    this.searchQuery,
  });

  bool get isEmpty =>
      (category == null || category == 'all') &&
      (city == null || city!.isEmpty) &&
      minPrice == null &&
      maxPrice == null &&
      minBedrooms == null &&
      (searchQuery == null || searchQuery!.trim().isEmpty);

  PropertyFilter copyWith({
    String? category,
    String? city,
    double? minPrice,
    double? maxPrice,
    int? minBedrooms,
    String? searchQuery,
  }) {
    return PropertyFilter(
      category: category ?? this.category,
      city: city ?? this.city,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      minBedrooms: minBedrooms ?? this.minBedrooms,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}
