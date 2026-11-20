import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:ejary_app/app/app.dart';
import 'package:ejary_app/core/services/storage_service.dart';
import 'package:ejary_app/app/bindings/initial_binding.dart';
import 'helpers/mock_storage_service.dart';
import 'helpers/mock_http_client.dart';

void main() {
  setUp(() async {
    HttpOverrides.global = MockHttpOverrides();
    Get.reset();
    final mockStorage = MockStorageService();
    Get.put<StorageService>(mockStorage, permanent: true);
    InitialBinding().dependencies();
  });

  tearDown(() {
    Get.reset();
  });

  testWidgets('EjaryApp launches and displays Splash branding', (WidgetTester tester) async {
    await tester.pumpWidget(const EjaryApp());

    // Verify app icon & name exists on splash screen
    expect(find.byIcon(Icons.home_work_rounded), findsOneWidget);
    expect(find.text('إيجاري'), findsOneWidget);

    // Pump timer and advance past splash screen
    await tester.pump(const Duration(milliseconds: 1500));
    await tester.pump(const Duration(milliseconds: 500));

    // Verify Main navigation shell loaded
    expect(find.byType(BottomNavigationBar), findsOneWidget);
  });
}
