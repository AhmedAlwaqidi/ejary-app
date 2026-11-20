/// Rental Application Entity
class RentalApplicationEntity {
  final String id;
  final String propertyId;
  final String propertyTitleAr;
  final String propertyTitleEn;
  final String propertyCity;
  final String propertyDistrict;
  final double propertyAnnualPrice;
  final String propertyImage;
  final String tenantId;
  final String tenantName;
  final String tenantPhone;
  final String tenantNationalId;
  final DateTime startDate;
  final int durationMonths;
  final String paymentFrequency; // 'monthly', 'quarterly', 'semi_annual', 'annual'
  final double installmentAmount;
  final String status; // 'pending', 'approved', 'rejected'
  final DateTime createdAt;

  const RentalApplicationEntity({
    required this.id,
    required this.propertyId,
    required this.propertyTitleAr,
    required this.propertyTitleEn,
    required this.propertyCity,
    required this.propertyDistrict,
    required this.propertyAnnualPrice,
    required this.propertyImage,
    required this.tenantId,
    required this.tenantName,
    required this.tenantPhone,
    required this.tenantNationalId,
    required this.startDate,
    required this.durationMonths,
    required this.paymentFrequency,
    required this.installmentAmount,
    required this.status,
    required this.createdAt,
  });
}

/// Lease Contract & Installment Entities
class PaymentInstallmentEntity {
  final String id;
  final int installmentNumber;
  final double amount;
  final DateTime dueDate;
  final bool isPaid;
  final DateTime? paidAt;

  const PaymentInstallmentEntity({
    required this.id,
    required this.installmentNumber,
    required this.amount,
    required this.dueDate,
    required this.isPaid,
    this.paidAt,
  });

  PaymentInstallmentEntity copyWith({
    bool? isPaid,
    DateTime? paidAt,
  }) {
    return PaymentInstallmentEntity(
      id: id,
      installmentNumber: installmentNumber,
      amount: amount,
      dueDate: dueDate,
      isPaid: isPaid ?? this.isPaid,
      paidAt: paidAt ?? this.paidAt,
    );
  }
}

class LeaseContractEntity {
  final String id;
  final String contractNumber;
  final String propertyId;
  final String propertyTitleAr;
  final String propertyTitleEn;
  final String propertyCity;
  final String propertyDistrict;
  final String tenantName;
  final String landlordName;
  final DateTime startDate;
  final DateTime endDate;
  final double annualRent;
  final String paymentFrequency;
  final String status; // 'active', 'pending', 'completed'
  final List<PaymentInstallmentEntity> installments;

  const LeaseContractEntity({
    required this.id,
    required this.contractNumber,
    required this.propertyId,
    required this.propertyTitleAr,
    required this.propertyTitleEn,
    required this.propertyCity,
    required this.propertyDistrict,
    required this.tenantName,
    required this.landlordName,
    required this.startDate,
    required this.endDate,
    required this.annualRent,
    required this.paymentFrequency,
    required this.status,
    required this.installments,
  });

  LeaseContractEntity copyWith({
    List<PaymentInstallmentEntity>? installments,
    String? status,
  }) {
    return LeaseContractEntity(
      id: id,
      contractNumber: contractNumber,
      propertyId: propertyId,
      propertyTitleAr: propertyTitleAr,
      propertyTitleEn: propertyTitleEn,
      propertyCity: propertyCity,
      propertyDistrict: propertyDistrict,
      tenantName: tenantName,
      landlordName: landlordName,
      startDate: startDate,
      endDate: endDate,
      annualRent: annualRent,
      paymentFrequency: paymentFrequency,
      status: status ?? this.status,
      installments: installments ?? this.installments,
    );
  }
}
