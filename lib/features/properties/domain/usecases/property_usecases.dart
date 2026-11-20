import '../entities/property_entity.dart';
import '../entities/property_filter.dart';
import '../repositories/property_repository.dart';

class GetPropertiesUseCase {
  final PropertyRepository repository;
  const GetPropertiesUseCase(this.repository);

  Future<List<PropertyEntity>> execute({PropertyFilter? filter}) {
    return repository.getProperties(filter: filter);
  }
}

class GetFeaturedPropertiesUseCase {
  final PropertyRepository repository;
  const GetFeaturedPropertiesUseCase(this.repository);

  Future<List<PropertyEntity>> execute() {
    return repository.getFeaturedProperties();
  }
}

class AddPropertyUseCase {
  final PropertyRepository repository;
  const AddPropertyUseCase(this.repository);

  Future<PropertyEntity> execute(PropertyEntity property) {
    return repository.addProperty(property);
  }
}
