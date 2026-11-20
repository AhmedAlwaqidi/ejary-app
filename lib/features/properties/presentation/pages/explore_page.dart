import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/explore_controller.dart';
import '../widgets/category_chip_bar.dart';
import '../widgets/property_card.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/widgets/empty_state_view.dart';
import '../../../../core/widgets/error_state_view.dart';

/// ExplorePage: The main discovery and property browsing experience
class ExplorePage extends GetView<ExploreController> {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.home_work_rounded, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 8),
            Text('app_name'.tr, style: AppTypography.titleLarge),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: controller.loadProperties,
        child: CustomScrollView(
          slivers: [
            // Search Bar
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                child: TextField(
                  onChanged: controller.onSearchChanged,
                  decoration: InputDecoration(
                    hintText: 'search_hint'.tr,
                    prefixIcon: const Icon(Icons.search_rounded, color: AppColors.primary),
                    suffixIcon: Obx(() {
                      if (controller.searchQuery.value.isNotEmpty) {
                        return IconButton(
                          icon: const Icon(Icons.clear_rounded),
                          onPressed: () => controller.onSearchChanged(''),
                        );
                      }
                      return const SizedBox.shrink();
                    }),
                  ),
                ),
              ),
            ),

            // Horizontal Categories
            SliverToBoxAdapter(
              child: Obx(
                () => CategoryChipBar(
                  selectedCategory: controller.selectedCategory.value,
                  onSelected: controller.onCategorySelected,
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 16)),

            // Section Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('all_properties'.tr, style: AppTypography.titleMedium),
                  ],
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 12)),

            // StateMixin Content List
            controller.obx(
              (properties) => SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final property = properties![index];
                      return PropertyCard(property: property);
                    },
                    childCount: properties?.length ?? 0,
                  ),
                ),
              ),
              onLoading: const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              ),
              onEmpty: SliverFillRemaining(
                child: EmptyStateView(
                  title: 'no_properties_found'.tr,
                  message: 'filter_all'.tr,
                  icon: Icons.search_off_rounded,
                  actionLabel: 'retry'.tr,
                  onAction: controller.resetFilters,
                ),
              ),
              onError: (error) => SliverFillRemaining(
                child: ErrorStateView(
                  message: error ?? 'error'.tr,
                  onRetry: controller.loadProperties,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
