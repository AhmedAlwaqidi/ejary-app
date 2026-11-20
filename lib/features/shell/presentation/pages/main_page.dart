import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ejary_app/features/shell/presentation/controllers/main_controller.dart';
import 'package:ejary_app/features/properties/presentation/pages/explore_page.dart';
import 'package:ejary_app/features/properties/presentation/pages/my_properties_view.dart';
import 'package:ejary_app/features/rentals/presentation/pages/my_rentals_page.dart';
import 'package:ejary_app/features/profile/presentation/pages/profile_page.dart';
import 'package:ejary_app/core/constants/app_colors.dart';

/// MainPage: Persistent shell with BottomNavigationBar
class MainPage extends GetView<MainController> {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pages = [
      const ExplorePage(),
      const MyRentalsPage(),
      const MyPropertiesView(),
      const ProfilePage(),
    ];

    return Obx(
      () => Scaffold(
        body: IndexedStack(
          index: controller.currentIndex.value,
          children: pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: controller.changeTab,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.explore_outlined),
              activeIcon: const Icon(Icons.explore_rounded),
              label: 'nav_explore'.tr,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.assignment_outlined),
              activeIcon: const Icon(Icons.assignment_rounded),
              label: 'nav_rentals'.tr,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.domain_outlined),
              activeIcon: const Icon(Icons.domain_rounded),
              label: 'nav_properties'.tr,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person_outline_rounded),
              activeIcon: const Icon(Icons.person_rounded),
              label: 'nav_profile'.tr,
            ),
          ],
        ),
      ),
    );
  }
}
