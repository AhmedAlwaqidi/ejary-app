import '../entities/rental_application_entity.dart';
import '../repositories/rental_repository.dart';

class SubmitRentalApplicationUseCase {
  final RentalRepository repository;
  const SubmitRentalApplicationUseCase(this.repository);

  Future<RentalApplicationEntity> execute(RentalApplicationEntity application) {
    return repository.submitApplication(application);
  }
}

class GetMyContractsUseCase {
  final RentalRepository repository;
  const GetMyContractsUseCase(this.repository);

  Future<List<LeaseContractEntity>> execute({String? tenantId}) {
    return repository.getMyContracts(tenantId: tenantId);
  }
}

class PayInstallmentUseCase {
  final RentalRepository repository;
  const PayInstallmentUseCase(this.repository);

  Future<bool> execute(String contractId, String installmentId) {
    return repository.payInstallment(contractId, installmentId);
  }
}
