import 'package:get/get.dart';
import '../../domain/entities/rental_application_entity.dart';
import '../../domain/repositories/rental_repository.dart';

/// MyRentalsController manages the tenant's active lease contracts and payment tracker
class MyRentalsController extends GetxController with StateMixin<List<LeaseContractEntity>> {
  final RentalRepository _repository = Get.find<RentalRepository>();

  @override
  void onInit() {
    super.onInit();
    loadRentals();
  }

  Future<void> loadRentals() async {
    change(null, status: RxStatus.loading());
    try {
      final contracts = await _repository.getMyContracts();
      if (contracts.isEmpty) {
        change([], status: RxStatus.empty());
      } else {
        change(contracts, status: RxStatus.success());
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }
}
