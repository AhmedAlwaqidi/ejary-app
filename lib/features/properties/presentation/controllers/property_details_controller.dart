import 'package:get/get.dart';
import '../../domain/entities/property_entity.dart';
import '../../domain/repositories/property_repository.dart';

/// PropertyDetailsController manages detailed property viewing and landlord contact actions
class PropertyDetailsController extends GetxController {
  final PropertyRepository _repository = Get.find<PropertyRepository>();

  final Rx<PropertyEntity?> property = Rx<PropertyEntity?>(null);
  final RxInt activeImageIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is PropertyEntity) {
      property.value = Get.arguments as PropertyEntity;
    } else if (Get.parameters['id'] != null) {
      _loadById(Get.parameters['id']!);
    }
  }

  Future<void> _loadById(String id) async {
    property.value = await _repository.getPropertyById(id);
  }

  void onImageChanged(int index) {
    activeImageIndex.value = index;
  }
}
