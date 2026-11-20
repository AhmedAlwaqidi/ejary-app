import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/contract_details_controller.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/widgets/app_button.dart';

/// ContractDetailsPage: Digital lease viewer and payment installment schedule
class ContractDetailsPage extends GetView<ContractDetailsController> {
  const ContractDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final langCode = Get.locale?.languageCode ?? 'ar';

    return Obx(() {
      final contract = controller.contract.value;
      if (contract == null) {
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      }

      return Scaffold(
        appBar: AppBar(title: Text('${'contract_number'.tr}: ${contract.contractNumber}')),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // Header summary
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.withAlpha(40)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        langCode == 'ar' ? contract.propertyTitleAr : contract.propertyTitleEn,
                        style: AppTypography.titleMedium,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.success.withAlpha(25),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'contract_status_${contract.status}'.tr,
                          style: AppTypography.labelSmall.copyWith(
                            color: AppColors.success,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('annual_price'.tr, style: AppTypography.bodySmall),
                      Text(
                        '${contract.annualRent.toInt()} ${'sar'.tr}',
                        style: AppTypography.labelLarge.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('payment_frequency'.tr, style: AppTypography.bodySmall),
                      Text('frequency_${contract.paymentFrequency}'.tr, style: AppTypography.bodySmall),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
            Text('installments_schedule'.tr, style: AppTypography.titleMedium),
            const SizedBox(height: 12),

            // Installments list
            ...contract.installments.map((installment) {
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: installment.isPaid
                              ? AppColors.success.withAlpha(20)
                              : AppColors.warning.withAlpha(20),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          installment.isPaid ? Icons.check_circle_rounded : Icons.schedule_rounded,
                          color: installment.isPaid ? AppColors.success : AppColors.warning,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${'installment'.tr} #${installment.installmentNumber}',
                              style: AppTypography.labelLarge,
                            ),
                            Text(
                              '${'due_date'.tr}: ${installment.dueDate.year}/${installment.dueDate.month}/${installment.dueDate.day}',
                              style: AppTypography.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${installment.amount.toInt()} ${'sar'.tr}',
                            style: AppTypography.labelLarge.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          if (installment.isPaid)
                            Text(
                              'paid'.tr,
                              style: AppTypography.labelSmall.copyWith(
                                color: AppColors.success,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          else
                            AppButton(
                              text: 'pay_now'.tr,
                              isLoading: controller.isPaying.value,
                              onPressed: () => controller.payInstallment(installment.id),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      );
    });
  }
}
