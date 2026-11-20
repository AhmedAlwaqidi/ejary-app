import 'package:get/get.dart';
import '../../core/services/storage_service.dart';
import '../../core/theme/theme_controller.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/presentation/controllers/auth_controller.dart';
import '../../features/properties/data/datasources/property_mock_datasource.dart';
import '../../features/properties/domain/repositories/property_repository.dart';
import '../../features/properties/data/repositories/property_repository_impl.dart';
import '../../features/properties/presentation/controllers/explore_controller.dart';
import '../../features/rentals/data/datasources/rental_mock_datasource.dart';
import '../../features/rentals/domain/repositories/rental_repository.dart';
import '../../features/rentals/data/repositories/rental_repository_impl.dart';
import '../../features/rentals/presentation/controllers/my_rentals_controller.dart';
import '../../features/shell/presentation/controllers/main_controller.dart';
import '../../features/profile/presentation/controllers/profile_controller.dart';

/// InitialBinding registers all core services, repositories, and root controllers
class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Core Services
    if (!Get.isRegistered<StorageService>()) {
      Get.put<StorageService>(StorageService(), permanent: true);
    }
    Get.put<ThemeController>(ThemeController(), permanent: true);

    // Repositories & Data Sources
    Get.put<AuthRepository>(AuthRepositoryImpl(), permanent: true);
    Get.put<AuthController>(AuthController(), permanent: true);

    final propertyDataSource = PropertyMockDataSource();
    Get.put<PropertyMockDataSource>(propertyDataSource, permanent: true);
    Get.put<PropertyRepository>(
      PropertyRepositoryImpl(dataSource: propertyDataSource),
      permanent: true,
    );

    final rentalDataSource = RentalMockDataSource();
    Get.put<RentalMockDataSource>(rentalDataSource, permanent: true);
    Get.put<RentalRepository>(
      RentalRepositoryImpl(dataSource: rentalDataSource),
      permanent: true,
    );

    // Shell & Navigation Controllers
    Get.put<MainController>(MainController(), permanent: true);
    Get.put<ExploreController>(ExploreController(), permanent: true);
    Get.put<MyRentalsController>(MyRentalsController(), permanent: true);
    Get.put<ProfileController>(ProfileController(), permanent: true);
  }
}
