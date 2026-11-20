import '../../domain/entities/property_entity.dart';
import '../../domain/entities/property_filter.dart';

/// In-memory mock data source containing realistic Saudi property listings
class PropertyMockDataSource {
  final List<PropertyEntity> _properties = [
    const PropertyEntity(
      id: 'prop_01',
      titleAr: 'شقة فاخرة بحي النرجس مع موقف خاص',
      titleEn: 'Luxury Apartment in An Narjis with Parking',
      descriptionAr: 'شقة حديثة بتشطيب سوبر ديلوكس في حي النرجس شمال الرياض. تتكون من 3 غرف نوم وصالة واسعة، مكيفات سبليت راكبة ومطبخ مجهز بالكامل.',
      descriptionEn: 'Modern apartment with super deluxe finishing in An Narjis north of Riyadh. 3 bedrooms, spacious living room, fitted ACs, and fully equipped kitchen.',
      category: 'apartment',
      city: 'الرياض',
      district: 'حي النرجس',
      pricePerYear: 58000,
      areaM2: 165,
      bedrooms: 3,
      bathrooms: 3,
      floor: 2,
      isFurnished: true,
      isVerified: true,
      isAvailable: true,
      amenities: ['parking', 'elevator', 'ac', 'furnished', 'security'],
      images: [
        'https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=800',
        'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?w=800',
      ],
      landlordId: 'll_01',
      landlordName: 'شركة إعمار نجد العقارية',
      landlordPhone: '+966551122334',
    ),
    const PropertyEntity(
      id: 'prop_02',
      titleAr: 'فيلا مودرن مع مسبح بحي حطين',
      titleEn: 'Modern Villa with Pool in Hittin',
      descriptionAr: 'فيلا راقية مستقلة بحي حطين بتصميم معماري حديث، مسبح خاص وحديقة منزلية، غرفة سائق وغرفة خادمة، تشطيبات فندقية فاخرة.',
      descriptionEn: 'Prestigious standalone villa in Hittin with modern architecture, private swimming pool, garden, driver and maid rooms.',
      category: 'villa',
      city: 'الرياض',
      district: 'حي حطين',
      pricePerYear: 180000,
      areaM2: 420,
      bedrooms: 5,
      bathrooms: 6,
      floor: 1,
      isFurnished: false,
      isVerified: true,
      isAvailable: true,
      amenities: ['parking', 'elevator', 'ac', 'balcony', 'security', 'central_gas'],
      images: [
        'https://images.unsplash.com/photo-1613977257363-707ba9348227?w=800',
        'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=800',
      ],
      landlordId: 'll_02',
      landlordName: 'عبدالرحمن القحطاني',
      landlordPhone: '+966504455667',
    ),
    const PropertyEntity(
      id: 'prop_03',
      titleAr: 'استوديو أنيق مؤثث بحي الشاطئ بإطلالة بحرية',
      titleEn: 'Elegant Furnished Studio in Ash Shati with Sea View',
      descriptionAr: 'استوديو راقي متكامل التأثيث في برج سكني مميز على كورنيش جدة. إنترنت فائق السرعة، جيم وخدمات فندقية.',
      descriptionEn: 'Fully furnished high-end studio in a residential tower on Jeddah Corniche. High-speed WiFi, gym, and hospitality services.',
      category: 'studio',
      city: 'جدة',
      district: 'حي الشاطئ',
      pricePerYear: 36000,
      areaM2: 55,
      bedrooms: 1,
      bathrooms: 1,
      floor: 14,
      isFurnished: true,
      isVerified: true,
      isAvailable: true,
      amenities: ['parking', 'elevator', 'ac', 'furnished', 'security', 'balcony'],
      images: [
        'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=800',
      ],
      landlordId: 'll_03',
      landlordName: 'برج الشاطئ السكني',
      landlordPhone: '+966567788990',
    ),
    const PropertyEntity(
      id: 'prop_04',
      titleAr: 'مكتب تجاري مرخص ومجهز بطريق الملك فهد',
      titleEn: 'Licensed Commercial Office on King Fahd Road',
      descriptionAr: 'مكتب تجاري راقي بإطلالة بانورامية مناسب للشركات والمؤسسات، مواقف سيارات مظللة، نظام إطفاء وأمن متكامل.',
      descriptionEn: 'Prime commercial office with panoramic views suitable for corporate headquarters, covered parking, and advanced security.',
      category: 'commercial',
      city: 'الرياض',
      district: 'طريق الملك فهد',
      pricePerYear: 95000,
      areaM2: 120,
      bedrooms: 0,
      bathrooms: 2,
      floor: 8,
      isFurnished: false,
      isVerified: true,
      isAvailable: true,
      amenities: ['parking', 'elevator', 'ac', 'security', 'central_gas'],
      images: [
        'https://images.unsplash.com/photo-1497366216548-37526070297c?w=800',
      ],
      landlordId: 'll_01',
      landlordName: 'شركة إعمار نجد العقارية',
      landlordPhone: '+966551122334',
    ),
    const PropertyEntity(
      id: 'prop_05',
      titleAr: 'شاليه عائلي فاخر بحي الشراع (أبحر الجنوبية)',
      titleEn: 'Luxury Family Chalet in Obhur',
      descriptionAr: 'شاليه عائلي بمدخل خاص ومسطحات خضراء وجلسات خارجية ومسبح أطفال، موقع هادئ قريب من البحر.',
      descriptionEn: 'Family chalet with private entrance, lawn, outdoor seating, and kids pool in a quiet location near the sea.',
      category: 'chalet',
      city: 'جدة',
      district: 'أبحر الجنوبية',
      pricePerYear: 75000,
      areaM2: 300,
      bedrooms: 3,
      bathrooms: 4,
      floor: 1,
      isFurnished: true,
      isVerified: false,
      isAvailable: true,
      amenities: ['parking', 'ac', 'furnished', 'balcony'],
      images: [
        'https://images.unsplash.com/photo-1580587771525-78b9dba3b914?w=800',
      ],
      landlordId: 'll_04',
      landlordName: 'ملاك شاليهات البحر',
      landlordPhone: '+966533344455',
    ),
    const PropertyEntity(
      id: 'prop_06',
      titleAr: 'شقة عائلية واسعة بحي الشاطئ الشرقي',
      titleEn: 'Spacious Family Apartment in East Shati',
      descriptionAr: 'شقة 4 غرف وصالة ومجلس كبير، قريبة من مجمع الراشد والواجهة البحرية، تشطيب نظيف ومواقف متوفرة.',
      descriptionEn: '4-bedroom family apartment with large majlis near Al Rashid Mall and Corniche. Well maintained with parking.',
      category: 'apartment',
      city: 'الدمام',
      district: 'حي الشاطئ الشرقي',
      pricePerYear: 42000,
      areaM2: 190,
      bedrooms: 4,
      bathrooms: 3,
      floor: 3,
      isFurnished: false,
      isVerified: true,
      isAvailable: true,
      amenities: ['parking', 'elevator', 'ac'],
      images: [
        'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=800',
      ],
      landlordId: 'll_05',
      landlordName: 'مكتب الشرقية للعقارات',
      landlordPhone: '+966540011223',
    ),
  ];

  List<PropertyEntity> getAll() => List.unmodifiable(_properties);

  List<PropertyEntity> query(PropertyFilter? filter) {
    if (filter == null || filter.isEmpty) {
      return List.unmodifiable(_properties);
    }

    return _properties.where((prop) {
      // Category filter
      if (filter.category != null &&
          filter.category != 'all' &&
          filter.category!.isNotEmpty) {
        if (prop.category != filter.category) return false;
      }
      // City filter
      if (filter.city != null && filter.city!.isNotEmpty) {
        if (!prop.city.contains(filter.city!)) return false;
      }
      // Price range
      if (filter.minPrice != null && prop.pricePerYear < filter.minPrice!) {
        return false;
      }
      if (filter.maxPrice != null && prop.pricePerYear > filter.maxPrice!) {
        return false;
      }
      // Bedrooms
      if (filter.minBedrooms != null && prop.bedrooms < filter.minBedrooms!) {
        return false;
      }
      // Search query (keyword match in AR/EN titles and city/district)
      if (filter.searchQuery != null && filter.searchQuery!.trim().isNotEmpty) {
        final q = filter.searchQuery!.trim().toLowerCase();
        final matchTitle = prop.titleAr.toLowerCase().contains(q) ||
            prop.titleEn.toLowerCase().contains(q);
        final matchLocation = prop.city.toLowerCase().contains(q) ||
            prop.district.toLowerCase().contains(q);
        if (!matchTitle && !matchLocation) return false;
      }

      return true;
    }).toList();
  }

  PropertyEntity? getById(String id) {
    try {
      return _properties.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  void add(PropertyEntity prop) {
    _properties.insert(0, prop);
  }

  bool toggleAvailability(String id) {
    final idx = _properties.indexWhere((p) => p.id == id);
    if (idx != -1) {
      final current = _properties[idx];
      _properties[idx] = PropertyEntity(
        id: current.id,
        titleAr: current.titleAr,
        titleEn: current.titleEn,
        descriptionAr: current.descriptionAr,
        descriptionEn: current.descriptionEn,
        category: current.category,
        city: current.city,
        district: current.district,
        pricePerYear: current.pricePerYear,
        areaM2: current.areaM2,
        bedrooms: current.bedrooms,
        bathrooms: current.bathrooms,
        floor: current.floor,
        isFurnished: current.isFurnished,
        isVerified: current.isVerified,
        isAvailable: !current.isAvailable,
        amenities: current.amenities,
        images: current.images,
        landlordId: current.landlordId,
        landlordName: current.landlordName,
        landlordPhone: current.landlordPhone,
      );
      return true;
    }
    return false;
  }
}
