import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';

/// Horizontal Category Selector Bar
class CategoryChipBar extends StatelessWidget {
  final String selectedCategory;
  final ValueChanged<String> onSelected;

  const CategoryChipBar({
    super.key,
    required this.selectedCategory,
    required this.onSelected,
  });

  static const List<Map<String, dynamic>> categories = [
    {'key': 'all', 'label': 'filter_all', 'icon': Icons.grid_view_rounded},
    {'key': 'apartment', 'label': 'cat_apartment', 'icon': Icons.apartment_rounded},
    {'key': 'villa', 'label': 'cat_villa', 'icon': Icons.home_rounded},
    {'key': 'studio', 'label': 'cat_studio', 'icon': Icons.single_bed_rounded},
    {'key': 'commercial', 'label': 'cat_commercial', 'icon': Icons.storefront_rounded},
    {'key': 'chalet', 'label': 'cat_chalet', 'icon': Icons.pool_rounded},
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final item = categories[index];
          final isSelected = selectedCategory == item['key'];

          return FilterChip(
            selected: isSelected,
            showCheckmark: false,
            avatar: Icon(
              item['icon'] as IconData,
              size: 18,
              color: isSelected ? Colors.white : AppColors.primary,
            ),
            label: Text(
              (item['label'] as String).tr,
              style: TextStyle(
                color: isSelected ? Colors.white : null,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            selectedColor: AppColors.primary,
            backgroundColor: Theme.of(context).cardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(
                color: isSelected ? AppColors.primary : Colors.grey.withAlpha(50),
              ),
            ),
            onSelected: (_) => onSelected(item['key'] as String),
          );
        },
      ),
    );
  }
}
