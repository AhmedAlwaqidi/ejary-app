import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:ejary_app/core/services/storage_service.dart';
import 'package:ejary_app/features/auth/data/repositories/auth_repository_impl.dart';
import '../helpers/mock_storage_service.dart';

void main() {
  late MockStorageService mockStorage;
  late AuthRepositoryImpl authRepo;

  setUp(() {
    Get.reset();
    mockStorage = MockStorageService();
    Get.put<StorageService>(mockStorage);
    authRepo = AuthRepositoryImpl();
  });

  tearDown(() {
    Get.reset();
  });

  group('AuthRepository Unit Tests', () {
    test('initial state initializes with default demo user', () async {
      final user = await authRepo.getCurrentUser();
      expect(user, isNotNull);
      expect(user?.role, equals('tenant'));
      expect(user?.isTenant, isTrue);
    });

    test('login succeeds with credentials and updates current user', () async {
      final user = await authRepo.login(
        'ahmed@ejary.sa',
        'password123',
      );

      expect(user, isNotNull);
      expect(user.email, equals('ahmed@ejary.sa'));
      expect(user.isTenant, isTrue);

      final storedUser = await authRepo.getCurrentUser();
      expect(storedUser, isNotNull);
      expect(storedUser?.email, equals('ahmed@ejary.sa'));
    });

    test('register creates a new user and updates role', () async {
      final newUser = await authRepo.register(
        name: 'Sara Al-Otaibi',
        email: 'sara@ejary.sa',
        phone: '+966509876543',
        password: 'secretPassword',
        role: 'landlord',
      );

      expect(newUser.name, equals('Sara Al-Otaibi'));
      expect(newUser.role, equals('landlord'));
      expect(newUser.isLandlord, isTrue);

      final currentUser = await authRepo.getCurrentUser();
      expect(currentUser?.email, equals('sara@ejary.sa'));
      expect(currentUser?.role, equals('landlord'));
    });

    test('switchRole toggles between tenant and landlord and persists', () async {
      expect((await authRepo.getCurrentUser())?.isTenant, isTrue);

      await authRepo.switchRole('landlord');
      expect((await authRepo.getCurrentUser())?.isLandlord, isTrue);
      expect(mockStorage.getUserRole(), equals('landlord'));

      await authRepo.switchRole('tenant');
      expect((await authRepo.getCurrentUser())?.isTenant, isTrue);
      expect(mockStorage.getUserRole(), equals('tenant'));
    });

    test('logout clears the current user session', () async {
      expect(await authRepo.getCurrentUser(), isNotNull);

      await authRepo.logout();
      expect(await authRepo.getCurrentUser(), isNull);
    });
  });
}
