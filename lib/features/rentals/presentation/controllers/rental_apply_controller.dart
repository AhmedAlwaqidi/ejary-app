import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ejary_app/features/rentals/domain/entities/rental_application_entity.dart';
import 'package:ejary_app/features/rentals/domain/repositories/rental_repository.dart';
import 'package:ejary_app/features/properties/domain/entities/property_entity.dart';
import 'package:ejary_app/features/auth/presentation/controllers/auth_controller.dart';
import 'package:ejary_app/app/routes/app_routes.dart';

/// RentalApplyController manages rental application form submission and payment calculations
class RentalApplyController extends GetxController {
  final RentalRepository _repository = Get.find<RentalRepository>();
  final AuthController _authController = Get.find<AuthController>();

  late final PropertyEntity property;

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final nationalIdController = TextEditingController();

  final Rx<DateTime> startDate = DateTime.now().add(const Duration(days: 7)).obs;
  final RxInt durationMonths = 12.obs;
  final RxString paymentFrequency = 'quarterly'.obs;
  final RxBool agreeTerms = true.obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    property = Get.arguments as PropertyEntity;
    final user = _authController.currentUser;
    if (user != null) {
      nameController.text = user.name;
      phoneController.text = user.phone;
      if (user.nationalId != null) {
        nationalIdController.text = user.nationalId!;
      }
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    nationalIdController.dispose();
    super.onClose();
  }

  double get calculatedInstallment {
    int count = 4;
    if (paymentFrequency.value == 'monthly') count = 12;
    if (paymentFrequency.value == 'semi_annual') count = 2;
    if (paymentFrequency.value == 'annual') count = 1;
    return property.pricePerYear / count;
  }

  Future<void> submitApplication() async {
    if (!formKey.currentState!.validate()) return;
    if (!agreeTerms.value) {
      Get.snackbar('error'.tr, 'agree_terms'.tr);
      return;
    }

    try {
      isLoading.value = true;
      final app = RentalApplicationEntity(
        id: 'app_${DateTime.now().millisecondsSinceEpoch}',
        propertyId: property.id,
        propertyTitleAr: property.titleAr,
        propertyTitleEn: property.titleEn,
        propertyCity: property.city,
        propertyDistrict: property.district,
        propertyAnnualPrice: property.pricePerYear,
        propertyImage: property.images.isNotEmpty ? property.images.first : '',
        tenantId: _authController.currentUser?.id ?? 'usr_guest',
        tenantName: nameController.text.trim(),
        tenantPhone: phoneController.text.trim(),
        tenantNationalId: nationalIdController.text.trim(),
        startDate: startDate.value,
        durationMonths: durationMonths.value,
        paymentFrequency: paymentFrequency.value,
        installmentAmount: calculatedInstallment,
        status: 'pending',
        createdAt: DateTime.now(),
      );

      await _repository.submitApplication(app);

      Get.offNamed(AppRoutes.main);
      Get.snackbar(
        'application_submitted'.tr,
        'application_success_msg'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withAlpha(200),
        colorText: Colors.white,
        duration: const Duration(seconds: 4),
      );
    } catch (e) {
      Get.snackbar('error'.tr, e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
