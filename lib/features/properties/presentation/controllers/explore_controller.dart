import 'package:get/get.dart';
import '../../domain/entities/property_entity.dart';
import '../../domain/entities/property_filter.dart';
import '../../domain/repositories/property_repository.dart';

/// ExploreController manages property discovery, search, and category filtering with StateMixin
class ExploreController extends GetxController with StateMixin<List<PropertyEntity>> {
  final PropertyRepository _repository = Get.find<PropertyRepository>();

  final RxString selectedCategory = 'all'.obs;
  final RxString searchQuery = ''.obs;
  final RxList<PropertyEntity> featuredProperties = <PropertyEntity>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadProperties();
  }

  Future<void> loadProperties() async {
    change(null, status: RxStatus.loading());
    try {
      // Load featured
      featuredProperties.value = await _repository.getFeaturedProperties();

      // Load filtered catalog
      final filter = PropertyFilter(
        category: selectedCategory.value == 'all' ? null : selectedCategory.value,
        searchQuery: searchQuery.value.isEmpty ? null : searchQuery.value,
      );

      final list = await _repository.getProperties(filter: filter);
      if (list.isEmpty) {
        change([], status: RxStatus.empty());
      } else {
        change(list, status: RxStatus.success());
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  void onCategorySelected(String category) {
    if (selectedCategory.value == category) return;
    selectedCategory.value = category;
    loadProperties();
  }

  void onSearchChanged(String query) {
    searchQuery.value = query;
    loadProperties();
  }

  void resetFilters() {
    selectedCategory.value = 'all';
    searchQuery.value = '';
    loadProperties();
  }
}
