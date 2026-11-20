import 'package:flutter_test/flutter_test.dart';
import 'package:ejary_app/features/rentals/data/datasources/rental_mock_datasource.dart';
import 'package:ejary_app/features/rentals/data/repositories/rental_repository_impl.dart';
import 'package:ejary_app/features/rentals/domain/entities/rental_application_entity.dart';

void main() {
  late RentalMockDataSource dataSource;
  late RentalRepositoryImpl repository;

  setUp(() {
    dataSource = RentalMockDataSource();
    repository = RentalRepositoryImpl(dataSource: dataSource);
  });

  group('RentalRepository Unit Tests', () {
    test('getMyContracts returns default initial active lease contract', () async {
      final contracts = await repository.getMyContracts();
      expect(contracts, isNotEmpty);
      expect(contracts.first.contractNumber, 'EJ-2026-98124');
      expect(contracts.first.installments.length, 4);
    });

    test('submitApplication adds application and generates active contract', () async {
      final app = RentalApplicationEntity(
        id: 'app_test_1',
        propertyId: 'prop_01',
        propertyTitleAr: 'شقة تجريبية',
        propertyTitleEn: 'Test Apt',
        propertyCity: 'الرياض',
        propertyDistrict: 'النرجس',
        propertyAnnualPrice: 60000,
        propertyImage: '',
        tenantId: 'usr_test',
        tenantName: 'مستأجر تجريبي',
        tenantPhone: '+966500000000',
        tenantNationalId: '1098765432',
        startDate: DateTime(2026, 6, 1),
        durationMonths: 12,
        paymentFrequency: 'quarterly',
        installmentAmount: 15000,
        status: 'pending',
        createdAt: DateTime.now(),
      );

      final submitted = await repository.submitApplication(app);
      expect(submitted.id, 'app_test_1');

      final contracts = await repository.getMyContracts();
      expect(contracts.length, greaterThanOrEqualTo(2));
      expect(contracts.any((c) => c.annualRent == 60000), isTrue);
    });

    test('payInstallment sets installment isPaid to true', () async {
      final contracts = await repository.getMyContracts();
      final contract = contracts.first;
      final unpaid = contract.installments.firstWhere((i) => !i.isPaid);

      final success = await repository.payInstallment(contract.id, unpaid.id);
      expect(success, isTrue);

      final updatedContract = await repository.getContractById(contract.id);
      final nowPaid = updatedContract!.installments.firstWhere((i) => i.id == unpaid.id);
      expect(nowPaid.isPaid, isTrue);
      expect(nowPaid.paidAt, isNotNull);
    });
  });
}
