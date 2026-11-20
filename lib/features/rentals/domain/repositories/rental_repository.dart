import '../entities/rental_application_entity.dart';

/// Rental Repository Contract
abstract class RentalRepository {
  Future<List<RentalApplicationEntity>> getApplications({String? tenantId});
  Future<RentalApplicationEntity> submitApplication(RentalApplicationEntity application);
  Future<List<LeaseContractEntity>> getMyContracts({String? tenantId});
  Future<LeaseContractEntity?> getContractById(String id);
  Future<bool> payInstallment(String contractId, String installmentId);
}
