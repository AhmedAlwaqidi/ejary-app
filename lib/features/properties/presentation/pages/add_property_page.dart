import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/add_property_controller.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';

/// AddPropertyPage: Landlord listing publication form
class AddPropertyPage extends GetView<AddPropertyController> {
  const AddPropertyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('add_new_property'.tr)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('property_title'.tr, style: AppTypography.labelLarge),
              const SizedBox(height: 8),
              AppTextField(
                hint: 'شقة فاخرة بحي الملقا...',
                controller: controller.titleArController,
                validator: (v) => (v == null || v.isEmpty) ? 'validation_required'.tr : null,
              ),
              const SizedBox(height: 16),

              // Category Selector Dropdown
              Text('select_role'.tr, style: AppTypography.labelLarge),
              const SizedBox(height: 8),
              Obx(
                () => DropdownButtonFormField<String>(
                  initialValue: controller.selectedCategory.value,
                  decoration: const InputDecoration(),
                  items: [
                    DropdownMenuItem(value: 'apartment', child: Text('cat_apartment'.tr)),
                    DropdownMenuItem(value: 'villa', child: Text('cat_villa'.tr)),
                    DropdownMenuItem(value: 'studio', child: Text('cat_studio'.tr)),
                    DropdownMenuItem(value: 'commercial', child: Text('cat_commercial'.tr)),
                    DropdownMenuItem(value: 'chalet', child: Text('cat_chalet'.tr)),
                  ],
                  onChanged: (v) {
                    if (v != null) controller.selectedCategory.value = v;
                  },
                ),
              ),
              const SizedBox(height: 16),

              // City & District Row
              Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      label: 'city'.tr,
                      hint: 'الرياض',
                      controller: controller.cityController,
                      validator: (v) => (v == null || v.isEmpty) ? 'validation_required'.tr : null,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppTextField(
                      label: 'district'.tr,
                      hint: 'حي الملقا',
                      controller: controller.districtController,
                      validator: (v) => (v == null || v.isEmpty) ? 'validation_required'.tr : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Price & Area Row
              Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      label: 'annual_price'.tr,
                      hint: '55000',
                      controller: controller.priceController,
                      keyboardType: TextInputType.number,
                      validator: (v) => (v == null || v.isEmpty) ? 'validation_required'.tr : null,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppTextField(
                      label: 'area_m2'.tr,
                      hint: '180',
                      controller: controller.areaController,
                      keyboardType: TextInputType.number,
                      validator: (v) => (v == null || v.isEmpty) ? 'validation_required'.tr : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Bedrooms & Bathrooms Row
              Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      label: 'bedrooms'.tr,
                      hint: '3',
                      controller: controller.bedroomsController,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppTextField(
                      label: 'bathrooms'.tr,
                      hint: '2',
                      controller: controller.bathroomsController,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Description
              AppTextField(
                label: 'description'.tr,
                hint: 'تفاصيل ومميزات العقار...',
                controller: controller.descriptionArController,
                maxLines: 3,
                validator: (v) => (v == null || v.isEmpty) ? 'validation_required'.tr : null,
              ),
              const SizedBox(height: 20),

              // Amenities multi-select
              Text('amenities'.tr, style: AppTypography.labelLarge),
              const SizedBox(height: 10),
              Obx(
                () => Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    'parking',
                    'elevator',
                    'ac',
                    'furnished',
                    'balcony',
                    'security',
                    'central_gas'
                  ].map((amenity) {
                    final isSelected = controller.selectedAmenities.contains(amenity);
                    return FilterChip(
                      selected: isSelected,
                      label: Text('amenity_$amenity'.tr),
                      selectedColor: AppColors.primary,
                      checkmarkColor: Colors.white,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : null,
                      ),
                      onSelected: (_) => controller.toggleAmenity(amenity),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 32),

              Obx(
                () => AppButton(
                  text: 'publish_property'.tr,
                  isLoading: controller.isLoading.value,
                  onPressed: controller.submitProperty,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
