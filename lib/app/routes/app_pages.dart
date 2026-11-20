import 'package:get/get.dart';
import 'app_routes.dart';
import '../../features/splash/presentation/splash_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/shell/presentation/pages/main_page.dart';
import '../../features/properties/presentation/pages/property_details_page.dart';
import '../../features/properties/presentation/controllers/property_details_controller.dart';
import '../../features/properties/presentation/pages/add_property_page.dart';
import '../../features/properties/presentation/controllers/add_property_controller.dart';
import '../../features/rentals/presentation/pages/rental_apply_page.dart';
import '../../features/rentals/presentation/controllers/rental_apply_controller.dart';
import '../../features/rentals/presentation/pages/contract_details_page.dart';
import '../../features/rentals/presentation/controllers/contract_details_controller.dart';

/// Centralized route registry
class AppPages {
  static const String initial = AppRoutes.splash;

  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashPage(),
      transition: Transition.fade,
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterPage(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.main,
      page: () => const MainPage(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.propertyDetails,
      page: () => const PropertyDetailsPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<PropertyDetailsController>(() => PropertyDetailsController());
      }),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.rentalApply,
      page: () => const RentalApplyPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<RentalApplyController>(() => RentalApplyController());
      }),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.contractDetails,
      page: () => const ContractDetailsPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<ContractDetailsController>(() => ContractDetailsController());
      }),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.addProperty,
      page: () => const AddPropertyPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<AddPropertyController>(() => AddPropertyController());
      }),
      transition: Transition.downToUp,
    ),
  ];
}
