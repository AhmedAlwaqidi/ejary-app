import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/rental_apply_controller.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';

/// RentalApplyPage: Step-by-step lease application form
class RentalApplyPage extends GetView<RentalApplyController> {
  const RentalApplyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final langCode = Get.locale?.languageCode ?? 'ar';
    final prop = controller.property;

    return Scaffold(
      appBar: AppBar(title: Text('rental_apply_title'.tr)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Property Summary Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.withAlpha(40)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withAlpha(30),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.home_work_rounded, color: AppColors.primary, size: 36),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(prop.localizedTitle(langCode), style: AppTypography.titleMedium),
                          const SizedBox(height: 4),
                          Text('${prop.city} • ${prop.district}', style: AppTypography.bodySmall),
                          const SizedBox(height: 6),
                          Text(
                            '${prop.pricePerYear.toInt()} ${'sar'.tr} ${'per_year'.tr}',
                            style: AppTypography.labelLarge.copyWith(color: AppColors.primary),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
              Text('lease_terms'.tr, style: AppTypography.titleMedium),
              const SizedBox(height: 16),

              // Duration selector
              Text('lease_duration'.tr, style: AppTypography.labelLarge),
              const SizedBox(height: 8),
              Obx(
                () => Row(
                  children: [
                    Expanded(
                      child: ChoiceChip(
                        label: Center(child: Text('duration_6_months'.tr)),
                        selected: controller.durationMonths.value == 6,
                        selectedColor: AppColors.primary,
                        checkmarkColor: Colors.white,
                        labelStyle: TextStyle(
                          color: controller.durationMonths.value == 6 ? Colors.white : null,
                        ),
                        onSelected: (v) {
                          if (v) controller.durationMonths.value = 6;
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ChoiceChip(
                        label: Center(child: Text('duration_1_year'.tr)),
                        selected: controller.durationMonths.value == 12,
                        selectedColor: AppColors.primary,
                        checkmarkColor: Colors.white,
                        labelStyle: TextStyle(
                          color: controller.durationMonths.value == 12 ? Colors.white : null,
                        ),
                        onSelected: (v) {
                          if (v) controller.durationMonths.value = 12;
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ChoiceChip(
                        label: Center(child: Text('duration_2_years'.tr)),
                        selected: controller.durationMonths.value == 24,
                        selectedColor: AppColors.primary,
                        checkmarkColor: Colors.white,
                        labelStyle: TextStyle(
                          color: controller.durationMonths.value == 24 ? Colors.white : null,
                        ),
                        onSelected: (v) {
                          if (v) controller.durationMonths.value = 24;
                        },
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Payment Frequency selector
              Text('payment_frequency'.tr, style: AppTypography.labelLarge),
              const SizedBox(height: 8),
              Obx(
                () => DropdownButtonFormField<String>(
                  initialValue: controller.paymentFrequency.value,
                  decoration: const InputDecoration(),
                  items: [
                    DropdownMenuItem(value: 'monthly', child: Text('frequency_monthly'.tr)),
                    DropdownMenuItem(value: 'quarterly', child: Text('frequency_quarterly'.tr)),
                    DropdownMenuItem(value: 'semi_annual', child: Text('frequency_semi_annual'.tr)),
                    DropdownMenuItem(value: 'annual', child: Text('frequency_annual'.tr)),
                  ],
                  onChanged: (v) {
                    if (v != null) controller.paymentFrequency.value = v;
                  },
                ),
              ),

              const SizedBox(height: 16),

              // Calculated installment amount box
              Obx(
                () => Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('calculated_installment'.tr, style: AppTypography.labelLarge.copyWith(color: AppColors.primaryDark)),
                      Text(
                        '${controller.calculatedInstallment.toInt()} ${'sar'.tr}',
                        style: AppTypography.titleLarge.copyWith(color: AppColors.primaryDark, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),
              const Divider(),
              const SizedBox(height: 16),

              // Tenant Identification Fields
              AppTextField(
                label: 'full_name'.tr,
                hint: 'أحمد الوكيدي',
                controller: controller.nameController,
                prefixIcon: Icons.person_outline,
                validator: (v) => (v == null || v.isEmpty) ? 'validation_required'.tr : null,
              ),
              const SizedBox(height: 16),

              AppTextField(
                label: 'phone_number'.tr,
                hint: '+966500000000',
                controller: controller.phoneController,
                prefixIcon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
                validator: (v) => (v == null || v.isEmpty) ? 'validation_required'.tr : null,
              ),
              const SizedBox(height: 16),

              AppTextField(
                label: 'tenant_id_iqama'.tr,
                hint: '1098765432',
                controller: controller.nationalIdController,
                prefixIcon: Icons.badge_outlined,
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'validation_required'.tr;
                  if (v.length < 10) return 'validation_required'.tr;
                  return null;
                },
              ),

              const SizedBox(height: 20),

              // Agreement Checkbox
              Obx(
                () => CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  value: controller.agreeTerms.value,
                  onChanged: (v) => controller.agreeTerms.value = v ?? false,
                  title: Text('agree_terms'.tr, style: AppTypography.bodySmall),
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ),

              const SizedBox(height: 24),

              Obx(
                () => AppButton(
                  text: 'submit_application'.tr,
                  isLoading: controller.isLoading.value,
                  onPressed: controller.submitApplication,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
