import '../../domain/entities/rental_application_entity.dart';

/// In-memory mock data source for rental applications and lease agreements
class RentalMockDataSource {
  final List<RentalApplicationEntity> _applications = [];
  final List<LeaseContractEntity> _contracts = [
    LeaseContractEntity(
      id: 'ctr_001',
      contractNumber: 'EJ-2026-98124',
      propertyId: 'prop_01',
      propertyTitleAr: 'شقة فاخرة بحي النرجس مع موقف خاص',
      propertyTitleEn: 'Luxury Apartment in An Narjis with Parking',
      propertyCity: 'الرياض',
      propertyDistrict: 'حي النرجس',
      tenantName: 'أحمد الوكيدي',
      landlordName: 'شركة إعمار نجد العقارية',
      startDate: DateTime(2026, 1, 1),
      endDate: DateTime(2026, 12, 31),
      annualRent: 58000,
      paymentFrequency: 'quarterly',
      status: 'active',
      installments: [
        PaymentInstallmentEntity(
          id: 'inst_1',
          installmentNumber: 1,
          amount: 14500,
          dueDate: DateTime(2026, 1, 1),
          isPaid: true,
          paidAt: DateTime(2026, 1, 1),
        ),
        PaymentInstallmentEntity(
          id: 'inst_2',
          installmentNumber: 2,
          amount: 14500,
          dueDate: DateTime(2026, 4, 1),
          isPaid: true,
          paidAt: DateTime(2026, 4, 1),
        ),
        PaymentInstallmentEntity(
          id: 'inst_3',
          installmentNumber: 3,
          amount: 14500,
          dueDate: DateTime(2026, 7, 1),
          isPaid: false,
        ),
        PaymentInstallmentEntity(
          id: 'inst_4',
          installmentNumber: 4,
          amount: 14500,
          dueDate: DateTime(2026, 10, 1),
          isPaid: false,
        ),
      ],
    ),
  ];

  List<RentalApplicationEntity> getApplications({String? tenantId}) {
    if (tenantId == null) return List.unmodifiable(_applications);
    return _applications.where((a) => a.tenantId == tenantId).toList();
  }

  void addApplication(RentalApplicationEntity app) {
    _applications.insert(0, app);

    // Automatically create a corresponding lease contract for full interactive workflow!
    final contract = LeaseContractEntity(
      id: 'ctr_${DateTime.now().millisecondsSinceEpoch}',
      contractNumber: 'EJ-${DateTime.now().year}-${10000 + _contracts.length}',
      propertyId: app.propertyId,
      propertyTitleAr: app.propertyTitleAr,
      propertyTitleEn: app.propertyTitleEn,
      propertyCity: app.propertyCity,
      propertyDistrict: app.propertyDistrict,
      tenantName: app.tenantName,
      landlordName: 'مكتب الوساطة العقاري المعتمد',
      startDate: app.startDate,
      endDate: app.startDate.add(Duration(days: app.durationMonths * 30)),
      annualRent: app.propertyAnnualPrice,
      paymentFrequency: app.paymentFrequency,
      status: 'active',
      installments: _generateInstallments(
        app.propertyAnnualPrice,
        app.paymentFrequency,
        app.startDate,
      ),
    );
    _contracts.insert(0, contract);
  }

  List<LeaseContractEntity> getContracts({String? tenantId}) {
    return List.unmodifiable(_contracts);
  }

  LeaseContractEntity? getContractById(String id) {
    try {
      return _contracts.firstWhere((c) => c.id == id);
    } catch (_) {
      return null;
    }
  }

  bool payInstallment(String contractId, String installmentId) {
    final cIdx = _contracts.indexWhere((c) => c.id == contractId);
    if (cIdx == -1) return false;

    final contract = _contracts[cIdx];
    final updatedInstallments = contract.installments.map((inst) {
      if (inst.id == installmentId) {
        return inst.copyWith(isPaid: true, paidAt: DateTime.now());
      }
      return inst;
    }).toList();

    _contracts[cIdx] = contract.copyWith(installments: updatedInstallments);
    return true;
  }

  List<PaymentInstallmentEntity> _generateInstallments(
    double totalAnnual,
    String frequency,
    DateTime start,
  ) {
    int count = 1;
    int intervalMonths = 12;
    if (frequency == 'monthly') {
      count = 12;
      intervalMonths = 1;
    } else if (frequency == 'quarterly') {
      count = 4;
      intervalMonths = 3;
    } else if (frequency == 'semi_annual') {
      count = 2;
      intervalMonths = 6;
    }

    final amountPerInstallment = totalAnnual / count;
    final List<PaymentInstallmentEntity> result = [];

    for (int i = 0; i < count; i++) {
      result.add(PaymentInstallmentEntity(
        id: 'inst_${DateTime.now().millisecondsSinceEpoch}_$i',
        installmentNumber: i + 1,
        amount: amountPerInstallment,
        dueDate: DateTime(start.year, start.month + (i * intervalMonths), start.day),
        isPaid: i == 0, // First installment paid at signing
        paidAt: i == 0 ? DateTime.now() : null,
      ));
    }

    return result;
  }
}
