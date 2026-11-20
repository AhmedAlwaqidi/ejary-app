import '../entities/user_entity.dart';

/// Auth Repository Contract
abstract class AuthRepository {
  Future<UserEntity?> getCurrentUser();
  Future<UserEntity> login(String email, String password);
  Future<UserEntity> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String role,
  });
  Future<void> logout();
  Future<void> switchRole(String newRole);
}
