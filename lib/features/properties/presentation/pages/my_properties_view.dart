import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ejary_app/features/properties/domain/repositories/property_repository.dart';
import 'package:ejary_app/features/properties/domain/entities/property_entity.dart';
import 'package:ejary_app/features/properties/presentation/widgets/property_card.dart';
import 'package:ejary_app/core/constants/app_colors.dart';
import 'package:ejary_app/core/widgets/empty_state_view.dart';
import 'package:ejary_app/app/routes/app_routes.dart';

/// MyPropertiesView: Landlord listings and properties management
class MyPropertiesView extends StatefulWidget {
  const MyPropertiesView({super.key});

  @override
  State<MyPropertiesView> createState() => _MyPropertiesViewState();
}

class _MyPropertiesViewState extends State<MyPropertiesView> {
  final PropertyRepository _repository = Get.find<PropertyRepository>();
  List<PropertyEntity> _properties = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProperties();
  }

  Future<void> _loadProperties() async {
    setState(() => _isLoading = true);
    final list = await _repository.getProperties();
    setState(() {
      _properties = list;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('my_properties_title'.tr),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline_rounded, color: AppColors.primary),
            onPressed: () => Get.toNamed(AppRoutes.addProperty),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: Text('add_new_property'.tr),
        onPressed: () async {
          await Get.toNamed(AppRoutes.addProperty);
          _loadProperties();
        },
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _properties.isEmpty
              ? EmptyStateView(
                  title: 'no_properties_listed'.tr,
                  message: 'app_tagline'.tr,
                  icon: Icons.holiday_village_outlined,
                  actionLabel: 'add_new_property'.tr,
                  onAction: () => Get.toNamed(AppRoutes.addProperty),
                )
              : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
                  itemCount: _properties.length,
                  itemBuilder: (context, index) {
                    final prop = _properties[index];
                    return PropertyCard(property: prop);
                  },
                ),
    );
  }
}
