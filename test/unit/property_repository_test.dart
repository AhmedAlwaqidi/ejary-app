import 'package:flutter_test/flutter_test.dart';
import 'package:ejary_app/features/properties/data/datasources/property_mock_datasource.dart';
import 'package:ejary_app/features/properties/data/repositories/property_repository_impl.dart';
import 'package:ejary_app/features/properties/domain/entities/property_filter.dart';
import 'package:ejary_app/features/properties/domain/entities/property_entity.dart';

void main() {
  late PropertyMockDataSource dataSource;
  late PropertyRepositoryImpl repository;

  setUp(() {
    dataSource = PropertyMockDataSource();
    repository = PropertyRepositoryImpl(dataSource: dataSource);
  });

  group('PropertyRepository Unit Tests', () {
    test('getProperties returns all seed properties when filter is null', () async {
      final properties = await repository.getProperties();
      expect(properties, isNotEmpty);
      expect(properties.length, greaterThanOrEqualTo(5));
    });

    test('getProperties correctly filters by category', () async {
      final filter = const PropertyFilter(category: 'villa');
      final villas = await repository.getProperties(filter: filter);
      expect(villas, isNotEmpty);
      expect(villas.every((p) => p.category == 'villa'), isTrue);
    });

    test('getProperties correctly filters by city', () async {
      final filter = const PropertyFilter(city: 'جدة');
      final jeddahProps = await repository.getProperties(filter: filter);
      expect(jeddahProps, isNotEmpty);
      expect(jeddahProps.every((p) => p.city.contains('جدة')), isTrue);
    });

    test('addProperty inserts new property and retrieves it', () async {
      const newProp = PropertyEntity(
        id: 'prop_test_99',
        titleAr: 'عقار تجريبي',
        titleEn: 'Test Property',
        descriptionAr: 'وصف تجريبي',
        descriptionEn: 'Test description',
        category: 'apartment',
        city: 'الرياض',
        district: 'الياسمين',
        pricePerYear: 45000,
        areaM2: 120,
        bedrooms: 2,
        bathrooms: 2,
        floor: 1,
        isFurnished: false,
        isVerified: true,
        isAvailable: true,
        amenities: ['parking'],
        images: [],
        landlordId: 'll_test',
        landlordName: 'مالك تجريبي',
        landlordPhone: '+966500000000',
      );

      final added = await repository.addProperty(newProp);
      expect(added.id, 'prop_test_99');

      final fetched = await repository.getPropertyById('prop_test_99');
      expect(fetched, isNotNull);
      expect(fetched?.titleAr, 'عقار تجريبي');
    });
  });
}
