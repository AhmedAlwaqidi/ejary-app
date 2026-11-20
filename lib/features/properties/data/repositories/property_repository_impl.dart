import '../../domain/entities/property_entity.dart';
import '../../domain/entities/property_filter.dart';
import '../../domain/repositories/property_repository.dart';
import '../datasources/property_mock_datasource.dart';

/// PropertyRepository Implementation
class PropertyRepositoryImpl implements PropertyRepository {
  final PropertyMockDataSource dataSource;

  const PropertyRepositoryImpl({required this.dataSource});

  @override
  Future<List<PropertyEntity>> getProperties({PropertyFilter? filter}) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return dataSource.query(filter);
  }

  @override
  Future<PropertyEntity?> getPropertyById(String id) async {
    await Future.delayed(const Duration(milliseconds: 150));
    return dataSource.getById(id);
  }

  @override
  Future<List<PropertyEntity>> getFeaturedProperties() async {
    await Future.delayed(const Duration(milliseconds: 200));
    final all = dataSource.getAll();
    return all.where((p) => p.isVerified).take(4).toList();
  }

  @override
  Future<List<PropertyEntity>> getLandlordProperties(String landlordId) async {
    await Future.delayed(const Duration(milliseconds: 250));
    final all = dataSource.getAll();
    return all.where((p) => p.landlordId == landlordId).toList();
  }

  @override
  Future<PropertyEntity> addProperty(PropertyEntity property) async {
    await Future.delayed(const Duration(milliseconds: 400));
    dataSource.add(property);
    return property;
  }

  @override
  Future<bool> toggleAvailability(String propertyId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return dataSource.toggleAvailability(propertyId);
  }
}
