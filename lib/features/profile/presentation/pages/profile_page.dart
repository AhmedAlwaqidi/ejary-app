import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ejary_app/features/profile/presentation/controllers/profile_controller.dart';
import 'package:ejary_app/core/constants/app_colors.dart';
import 'package:ejary_app/core/constants/app_typography.dart';
import 'package:ejary_app/core/constants/app_constants.dart';

/// ProfilePage: Manage theme, language, user roles, and account settings
class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('profile_title'.tr)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // User Card
          Obx(() {
            final user = controller.authController.currentUser;
            final isLandlord = controller.authController.isLandlord;

            return Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey.withAlpha(40)),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: AppColors.primaryLight,
                    child: const Icon(Icons.person, size: 36, color: AppColors.primary),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user?.name ?? 'guest_user'.tr,
                          style: AppTypography.titleLarge,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          user?.email ?? 'app_tagline'.tr,
                          style: AppTypography.bodySmall,
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: isLandlord
                                ? AppColors.secondary.withAlpha(20)
                                : AppColors.primary.withAlpha(20),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            isLandlord ? 'active_role_landlord'.tr : 'active_role_tenant'.tr,
                            style: AppTypography.labelSmall.copyWith(
                              color: isLandlord ? AppColors.secondary : AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),

          const SizedBox(height: 24),
          Text('settings'.tr.isEmpty ? 'الإعدادات' : 'settings'.tr, style: AppTypography.titleMedium),
          const SizedBox(height: 12),

          // Role Switcher Tile
          Card(
            child: ListTile(
              leading: const Icon(Icons.swap_horiz_rounded, color: AppColors.primary),
              title: Text('switch_role'.tr),
              subtitle: Obx(
                () => Text(
                  controller.authController.isLandlord ? 'role_tenant'.tr : 'role_landlord'.tr,
                ),
              ),
              trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
              onTap: controller.switchRole,
            ),
          ),
          const SizedBox(height: 8),

          // Theme Switcher Tile
          Card(
            child: Obx(
              () => SwitchListTile(
                secondary: Icon(
                  controller.themeController.isDarkMode ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                  color: AppColors.primary,
                ),
                title: Text('theme_mode'.tr),
                subtitle: Text(
                  controller.themeController.isDarkMode ? 'theme_dark'.tr : 'theme_light'.tr,
                ),
                value: controller.themeController.isDarkMode,
                onChanged: (_) => controller.toggleTheme(),
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Language Selector Tile
          Card(
            child: ListTile(
              leading: const Icon(Icons.language_rounded, color: AppColors.primary),
              title: Text('language'.tr),
              subtitle: Obx(
                () => Text(
                  controller.currentLanguage.value == 'ar' ? 'lang_arabic'.tr : 'lang_english'.tr,
                ),
              ),
              trailing: PopupMenuButton<String>(
                icon: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                onSelected: controller.switchLanguage,
                itemBuilder: (context) => [
                  PopupMenuItem(value: 'ar', child: Text('lang_arabic'.tr)),
                  PopupMenuItem(value: 'en', child: Text('lang_english'.tr)),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // App Info
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.info_outline_rounded, color: AppColors.primary),
                  title: Text('about_app'.tr),
                  subtitle: Text('app_tagline'.tr),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.verified_outlined, color: AppColors.primary),
                  title: Text('version'.tr),
                  trailing: Text('v${AppConstants.appVersion}', style: AppTypography.bodySmall),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Logout Button
          OutlinedButton.icon(
            icon: const Icon(Icons.logout_rounded, color: AppColors.error),
            label: Text('logout'.tr, style: const TextStyle(color: AppColors.error)),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColors.error),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: controller.logout,
          ),
        ],
      ),
    );
  }
}
