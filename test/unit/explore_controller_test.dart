import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:ejary_app/features/properties/data/datasources/property_mock_datasource.dart';
import 'package:ejary_app/features/properties/data/repositories/property_repository_impl.dart';
import 'package:ejary_app/features/properties/domain/repositories/property_repository.dart';
import 'package:ejary_app/features/properties/presentation/controllers/explore_controller.dart';

void main() {
  late PropertyRepository repository;

  setUp(() {
    Get.reset();
    final dataSource = PropertyMockDataSource();
    repository = PropertyRepositoryImpl(dataSource: dataSource);
    Get.put<PropertyRepository>(repository);
  });

  tearDown(() {
    Get.reset();
  });

  group('ExploreController Unit Tests', () {
    test('initializes and loads all properties into success state', () async {
      final controller = Get.put(ExploreController());
      expect(controller.status.isLoading, isTrue);

      await controller.loadProperties();
      expect(controller.status.isSuccess, isTrue);
      expect(controller.state, isNotNull);
      expect(controller.state!.length, equals(6));
      expect(controller.featuredProperties.length, equals(4));
    });

    test('onCategorySelected filters properties by selected category', () async {
      final controller = Get.put(ExploreController());
      await controller.loadProperties();

      controller.onCategorySelected('villa');
      await controller.loadProperties();

      expect(controller.selectedCategory.value, equals('villa'));
      expect(controller.state!.every((p) => p.category == 'villa'), isTrue);
    });

    test('onSearchChanged filters properties by query text', () async {
      final controller = Get.put(ExploreController());
      await controller.loadProperties();

      controller.onSearchChanged('Narjis');
      await controller.loadProperties();

      expect(controller.state!.length, greaterThan(0));
      expect(controller.state!.every((p) => p.titleEn.toLowerCase().contains('narjis') || p.district.contains('النرجس')), isTrue);
    });

    test('resetFilters clears category and search', () async {
      final controller = Get.put(ExploreController());
      controller.onCategorySelected('apartment');
      controller.onSearchChanged('Luxury');
      await controller.loadProperties();

      controller.resetFilters();
      await controller.loadProperties();

      expect(controller.selectedCategory.value, equals('all'));
      expect(controller.searchQuery.value, isEmpty);
      expect(controller.state!.length, equals(6));
    });
  });
}
