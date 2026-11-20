import '../entities/property_entity.dart';
import '../entities/property_filter.dart';

/// Property Repository Contract
abstract class PropertyRepository {
  Future<List<PropertyEntity>> getProperties({PropertyFilter? filter});
  Future<PropertyEntity?> getPropertyById(String id);
  Future<List<PropertyEntity>> getFeaturedProperties();
  Future<List<PropertyEntity>> getLandlordProperties(String landlordId);
  Future<PropertyEntity> addProperty(PropertyEntity property);
  Future<bool> toggleAvailability(String propertyId);
}
