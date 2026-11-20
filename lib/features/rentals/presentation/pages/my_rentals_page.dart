import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/my_rentals_controller.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/widgets/empty_state_view.dart';
import '../../../../core/widgets/error_state_view.dart';
import '../../../../app/routes/app_routes.dart';

/// MyRentalsPage: List of tenant lease agreements and active contracts
class MyRentalsPage extends GetView<MyRentalsController> {
  const MyRentalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final langCode = Get.locale?.languageCode ?? 'ar';

    return Scaffold(
      appBar: AppBar(
        title: Text('my_rentals_title'.tr),
      ),
      body: RefreshIndicator(
        onRefresh: controller.loadRentals,
        child: controller.obx(
          (contracts) => ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: contracts?.length ?? 0,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final contract = contracts![index];
              final totalInstallments = contract.installments.length;
              final paidInstallments = contract.installments.where((i) => i.isPaid).length;

              return Card(
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: () => Get.toNamed(AppRoutes.contractDetails, arguments: contract),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.primaryLight,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                contract.contractNumber,
                                style: AppTypography.labelSmall.copyWith(
                                  color: AppColors.primaryDark,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: contract.status == 'active'
                                    ? AppColors.success.withAlpha(25)
                                    : AppColors.warning.withAlpha(25),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'contract_status_${contract.status}'.tr,
                                style: AppTypography.labelSmall.copyWith(
                                  color: contract.status == 'active'
                                      ? AppColors.success
                                      : AppColors.warning,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          langCode == 'ar' ? contract.propertyTitleAr : contract.propertyTitleEn,
                          style: AppTypography.titleMedium,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${contract.propertyCity} • ${contract.propertyDistrict}',
                          style: AppTypography.bodySmall,
                        ),
                        const SizedBox(height: 12),
                        const Divider(height: 1),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${contract.annualRent.toInt()} ${'sar'.tr} ${'per_year'.tr}',
                              style: AppTypography.labelLarge.copyWith(color: AppColors.primary),
                            ),
                            Text(
                              '$paidInstallments / $totalInstallments ${'paid'.tr}',
                              style: AppTypography.bodySmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          onLoading: const Center(child: CircularProgressIndicator()),
          onEmpty: EmptyStateView(
            title: 'no_rentals_yet'.tr,
            message: 'app_tagline'.tr,
            icon: Icons.assignment_outlined,
          ),
          onError: (e) => ErrorStateView(
            message: e ?? 'error'.tr,
            onRetry: controller.loadRentals,
          ),
        ),
      ),
    );
  }
}
