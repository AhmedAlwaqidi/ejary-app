import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/entities/property_entity.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../app/routes/app_routes.dart';

/// Reusable PropertyCard displaying image, badges, specs, and price
class PropertyCard extends StatelessWidget {
  final PropertyEntity property;
  final VoidCallback? onTap;

  const PropertyCard({
    super.key,
    required this.property,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final langCode = Get.locale?.languageCode ?? 'ar';
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap ?? () => Get.toNamed(AppRoutes.propertyDetails, arguments: property),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Stack with badges
            Stack(
              children: [
                Container(
                  height: 180,
                  width: double.infinity,
                  color: isDark ? AppColors.surfaceDark : Colors.grey[200],
                  child: Image.network(
                    property.images.isNotEmpty
                        ? property.images.first
                        : 'https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=800',
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => Center(
                      child: Icon(
                        Icons.apartment_rounded,
                        size: 64,
                        color: isDark ? Colors.white24 : Colors.grey[400],
                      ),
                    ),
                  ),
                ),
                // Category Pill
                Positioned(
                  top: 12,
                  left: langCode == 'ar' ? null : 12,
                  right: langCode == 'ar' ? 12 : null,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.secondary.withAlpha(220),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'cat_${property.category}'.tr,
                      style: AppTypography.labelSmall.copyWith(color: Colors.white),
                    ),
                  ),
                ),
                // Verified Badge
                if (property.isVerified)
                  Positioned(
                    top: 12,
                    left: langCode == 'ar' ? 12 : null,
                    right: langCode == 'ar' ? null : 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.verified, size: 14, color: Colors.white),
                          const SizedBox(width: 4),
                          Text(
                            'verified'.tr,
                            style: AppTypography.labelSmall.copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    property.localizedTitle(langCode),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.titleMedium,
                  ),
                  const SizedBox(height: 6),
                  // Location
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, size: 16, color: AppColors.primary),
                      const SizedBox(width: 4),
                      Text(
                        '${property.city} • ${property.district}',
                        style: AppTypography.bodySmall.copyWith(
                          color: Theme.of(context).textTheme.bodySmall?.color,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Divider(height: 1),
                  const SizedBox(height: 12),
                  // Specs Strip & Price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Specs
                      Row(
                        children: [
                          if (property.bedrooms > 0) ...[
                            const Icon(Icons.bed_outlined, size: 16),
                            const SizedBox(width: 4),
                            Text('${property.bedrooms}', style: AppTypography.bodySmall),
                            const SizedBox(width: 12),
                          ],
                          const Icon(Icons.bathtub_outlined, size: 16),
                          const SizedBox(width: 4),
                          Text('${property.bathrooms}', style: AppTypography.bodySmall),
                          const SizedBox(width: 12),
                          const Icon(Icons.square_foot_outlined, size: 16),
                          const SizedBox(width: 4),
                          Text('${property.areaM2.toInt()} m²', style: AppTypography.bodySmall),
                        ],
                      ),
                      // Price
                      Text(
                        '${property.pricePerYear.toInt()} ${'sar'.tr} ${'per_year'.tr}',
                        style: AppTypography.labelLarge.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
