import '../../domain/entities/rental_application_entity.dart';
import '../../domain/repositories/rental_repository.dart';
import '../datasources/rental_mock_datasource.dart';

/// RentalRepository Implementation
class RentalRepositoryImpl implements RentalRepository {
  final RentalMockDataSource dataSource;

  const RentalRepositoryImpl({required this.dataSource});

  @override
  Future<List<RentalApplicationEntity>> getApplications({String? tenantId}) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return dataSource.getApplications(tenantId: tenantId);
  }

  @override
  Future<RentalApplicationEntity> submitApplication(RentalApplicationEntity application) async {
    await Future.delayed(const Duration(milliseconds: 500));
    dataSource.addApplication(application);
    return application;
  }

  @override
  Future<List<LeaseContractEntity>> getMyContracts({String? tenantId}) async {
    await Future.delayed(const Duration(milliseconds: 250));
    return dataSource.getContracts(tenantId: tenantId);
  }

  @override
  Future<LeaseContractEntity?> getContractById(String id) async {
    await Future.delayed(const Duration(milliseconds: 150));
    return dataSource.getContractById(id);
  }

  @override
  Future<bool> payInstallment(String contractId, String installmentId) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return dataSource.payInstallment(contractId, installmentId);
  }
}
