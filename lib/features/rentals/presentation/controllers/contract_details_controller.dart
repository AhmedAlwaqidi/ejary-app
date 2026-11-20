import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/entities/rental_application_entity.dart';
import '../../domain/repositories/rental_repository.dart';

/// ContractDetailsController handles viewing digital contract clauses and executing installment payments
class ContractDetailsController extends GetxController {
  final RentalRepository _repository = Get.find<RentalRepository>();

  final Rx<LeaseContractEntity?> contract = Rx<LeaseContractEntity?>(null);
  final RxBool isPaying = false.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is LeaseContractEntity) {
      contract.value = Get.arguments as LeaseContractEntity;
    }
  }

  Future<void> payInstallment(String installmentId) async {
    if (contract.value == null) return;

    try {
      isPaying.value = true;
      final success = await _repository.payInstallment(contract.value!.id, installmentId);
      if (success) {
        // Refresh contract view
        final updated = await _repository.getContractById(contract.value!.id);
        if (updated != null) {
          contract.value = updated;
        }
        Get.snackbar(
          'success'.tr,
          'payment_success'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withAlpha(200),
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar('error'.tr, e.toString());
    } finally {
      isPaying.value = false;
    }
  }
}
