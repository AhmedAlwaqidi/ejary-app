import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ejary_app/features/properties/domain/entities/property_entity.dart';
import 'package:ejary_app/features/properties/domain/repositories/property_repository.dart';
import 'package:ejary_app/features/auth/presentation/controllers/auth_controller.dart';
import 'package:ejary_app/features/properties/presentation/controllers/explore_controller.dart';

/// AddPropertyController handles landlord property publishing with validation
class AddPropertyController extends GetxController {
  final PropertyRepository _repository = Get.find<PropertyRepository>();
  final AuthController _authController = Get.find<AuthController>();

  final formKey = GlobalKey<FormState>();

  final titleArController = TextEditingController();
  final titleEnController = TextEditingController();
  final descriptionArController = TextEditingController();
  final descriptionEnController = TextEditingController();
  final cityController = TextEditingController(text: 'الرياض');
  final districtController = TextEditingController();
  final priceController = TextEditingController();
  final areaController = TextEditingController();
  final bedroomsController = TextEditingController(text: '3');
  final bathroomsController = TextEditingController(text: '2');
  final floorController = TextEditingController(text: '1');

  final RxString selectedCategory = 'apartment'.obs;
  final RxBool isFurnished = false.obs;
  final RxBool isLoading = false.obs;
  final RxList<String> selectedAmenities = <String>['parking', 'ac'].obs;

  @override
  void onClose() {
    titleArController.dispose();
    titleEnController.dispose();
    descriptionArController.dispose();
    descriptionEnController.dispose();
    cityController.dispose();
    districtController.dispose();
    priceController.dispose();
    areaController.dispose();
    bedroomsController.dispose();
    bathroomsController.dispose();
    floorController.dispose();
    super.onClose();
  }

  void toggleAmenity(String amenity) {
    if (selectedAmenities.contains(amenity)) {
      selectedAmenities.remove(amenity);
    } else {
      selectedAmenities.add(amenity);
    }
  }

  Future<void> submitProperty() async {
    if (!formKey.currentState!.validate()) return;

    try {
      isLoading.value = true;
      final newProperty = PropertyEntity(
        id: 'prop_${DateTime.now().millisecondsSinceEpoch}',
        titleAr: titleArController.text.trim(),
        titleEn: titleEnController.text.trim().isEmpty
            ? titleArController.text.trim()
            : titleEnController.text.trim(),
        descriptionAr: descriptionArController.text.trim(),
        descriptionEn: descriptionEnController.text.trim().isEmpty
            ? descriptionArController.text.trim()
            : descriptionEnController.text.trim(),
        category: selectedCategory.value,
        city: cityController.text.trim(),
        district: districtController.text.trim(),
        pricePerYear: double.parse(priceController.text.trim()),
        areaM2: double.parse(areaController.text.trim()),
        bedrooms: int.parse(bedroomsController.text.trim()),
        bathrooms: int.parse(bathroomsController.text.trim()),
        floor: int.parse(floorController.text.trim()),
        isFurnished: isFurnished.value,
        isVerified: true,
        isAvailable: true,
        amenities: selectedAmenities.toList(),
        images: [
          'https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=800',
        ],
        landlordId: _authController.currentUser?.id ?? 'll_01',
        landlordName: _authController.currentUser?.name ?? 'مؤجر إيجاري',
        landlordPhone: _authController.currentUser?.phone ?? '+966500000000',
      );

      await _repository.addProperty(newProperty);

      // Refresh Explore catalog if ExploreController is active
      if (Get.isRegistered<ExploreController>()) {
        Get.find<ExploreController>().loadProperties();
      }

      Get.back();
      Get.snackbar(
        'success'.tr,
        'property_added_success'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withAlpha(200),
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'error'.tr,
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withAlpha(200),
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
