import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app/app.dart';
import 'core/services/storage_service.dart';
import 'app/bindings/initial_binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize GetStorage persistence
  await GetStorage.init();

  // Initialize and register StorageService as permanent GetxService
  final storageService = await StorageService().init();
  Get.put<StorageService>(storageService, permanent: true);

  // Initialize remaining global bindings
  InitialBinding().dependencies();

  runApp(const EjaryApp());
}
