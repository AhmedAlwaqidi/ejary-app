import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/property_details_controller.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../app/routes/app_routes.dart';

/// PropertyDetailsPage: Full property specifications, photo gallery, amenities, and lease application CTA
class PropertyDetailsPage extends GetView<PropertyDetailsController> {
  const PropertyDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final langCode = Get.locale?.languageCode ?? 'ar';

    return Obx(() {
      final property = controller.property.value;
      if (property == null) {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      }

      return Scaffold(
        body: CustomScrollView(
          slivers: [
            // App Bar with Image Carousel
            SliverAppBar(
              expandedHeight: 280,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      property.images.isNotEmpty
                          ? property.images[controller.activeImageIndex.value]
                          : 'https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=800',
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => const Center(
                        child: Icon(Icons.home_work_rounded, size: 80, color: Colors.grey),
                      ),
                    ),
                    const DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black38,
                            Colors.transparent,
                            Colors.black54,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Property Details Content
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Price & Category Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${property.pricePerYear.toInt()} ${'sar'.tr} ${'per_year'.tr}',
                          style: AppTypography.displayMedium.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.primaryLight,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'cat_${property.category}'.tr,
                            style: AppTypography.labelSmall.copyWith(
                              color: AppColors.primaryDark,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Title
                    Text(
                      property.localizedTitle(langCode),
                      style: AppTypography.titleLarge,
                    ),
                    const SizedBox(height: 8),

                    // Location
                    Row(
                      children: [
                        const Icon(Icons.location_on, size: 18, color: AppColors.primary),
                        const SizedBox(width: 4),
                        Text(
                          '${property.city} • ${property.district}',
                          style: AppTypography.bodyMedium.copyWith(
                            color: Theme.of(context).textTheme.bodySmall?.color,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                    const Divider(),
                    const SizedBox(height: 16),

                    // Specifications Grid
                    Text('specifications'.tr, style: AppTypography.titleMedium),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildSpecTile(context, Icons.square_foot_rounded, '${property.areaM2.toInt()} m²', 'area_m2'.tr),
                        _buildSpecTile(context, Icons.bed_rounded, '${property.bedrooms}', 'bedrooms'.tr),
                        _buildSpecTile(context, Icons.bathtub_rounded, '${property.bathrooms}', 'bathrooms'.tr),
                        _buildSpecTile(context, Icons.layers_rounded, '${property.floor}', 'specifications'.tr),
                      ],
                    ),

                    const SizedBox(height: 20),
                    const Divider(),
                    const SizedBox(height: 16),

                    // Description
                    Text('description'.tr, style: AppTypography.titleMedium),
                    const SizedBox(height: 8),
                    Text(
                      property.localizedDescription(langCode),
                      style: AppTypography.bodyMedium.copyWith(height: 1.6),
                    ),

                    const SizedBox(height: 20),
                    const Divider(),
                    const SizedBox(height: 16),

                    // Amenities Chips
                    Text('amenities'.tr, style: AppTypography.titleMedium),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: property.amenities.map((amenity) {
                        return Chip(
                          avatar: const Icon(Icons.check_circle_outline, size: 16, color: AppColors.primary),
                          label: Text('amenity_$amenity'.tr),
                          backgroundColor: Theme.of(context).cardColor,
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 20),
                    const Divider(),
                    const SizedBox(height: 16),

                    // Landlord Info Card
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.withAlpha(40)),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: AppColors.primaryLight,
                            child: const Icon(Icons.person, color: AppColors.primary),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(property.landlordName, style: AppTypography.titleMedium),
                                Text(property.landlordPhone, style: AppTypography.bodySmall),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.phone, color: AppColors.primary),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 100), // Spacing for bottom CTA bar
                  ],
                ),
              ),
            ),
          ],
        ),

        // Bottom CTA Bar
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(20),
                blurRadius: 10,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: SafeArea(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${property.pricePerMonth.toInt()} ${'sar'.tr}',
                        style: AppTypography.titleLarge.copyWith(color: AppColors.primary),
                      ),
                      Text('per_month'.tr, style: AppTypography.bodySmall),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: AppButton(
                    text: 'apply_for_lease'.tr,
                    icon: Icons.assignment_turned_in_rounded,
                    onPressed: () {
                      Get.toNamed(AppRoutes.rentalApply, arguments: property);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildSpecTile(BuildContext context, IconData icon, String value, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.primary.withAlpha(20),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: AppColors.primary, size: 24),
        ),
        const SizedBox(height: 6),
        Text(value, style: AppTypography.labelLarge),
        Text(label, style: AppTypography.bodySmall),
      ],
    );
  }
}
