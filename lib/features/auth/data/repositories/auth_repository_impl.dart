import 'package:get/get.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../../../core/services/storage_service.dart';

/// Implementation of AuthRepository with local persistence
class AuthRepositoryImpl implements AuthRepository {
  final StorageService _storageService = Get.find<StorageService>();

  UserEntity? _currentUser;

  AuthRepositoryImpl() {
    _initUser();
  }

  void _initUser() {
    final role = _storageService.getUserRole();
    _currentUser = UserEntity(
      id: 'usr_001',
      name: 'أحمد الوكيدي',
      email: 'ahmed@ejary.com',
      phone: '+966501234567',
      role: role,
      nationalId: '1098765432',
    );
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    return _currentUser;
  }

  @override
  Future<UserEntity> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 600)); // Simulate network
    final role = _storageService.getUserRole();
    _currentUser = UserEntity(
      id: 'usr_001',
      name: email.split('@').first,
      email: email,
      phone: '+966501234567',
      role: role,
      nationalId: '1098765432',
    );
    return _currentUser!;
  }

  @override
  Future<UserEntity> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String role,
  }) async {
    await Future.delayed(const Duration(milliseconds: 600));
    _currentUser = UserEntity(
      id: 'usr_${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      email: email,
      phone: phone,
      role: role,
    );
    await _storageService.saveUserRole(role);
    return _currentUser!;
  }

  @override
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _currentUser = null;
  }

  @override
  Future<void> switchRole(String newRole) async {
    await _storageService.saveUserRole(newRole);
    if (_currentUser != null) {
      _currentUser = UserEntity(
        id: _currentUser!.id,
        name: _currentUser!.name,
        email: _currentUser!.email,
        phone: _currentUser!.phone,
        role: newRole,
        nationalId: _currentUser!.nationalId,
      );
    }
  }
}
