import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ejary_app/features/auth/domain/entities/user_entity.dart';
import 'package:ejary_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:ejary_app/app/routes/app_routes.dart';

/// AuthController coordinates authentication, guest access, and active user roles
class AuthController extends GetxController {
  final AuthRepository _authRepository = Get.find<AuthRepository>();

  final Rx<UserEntity?> _currentUser = Rx<UserEntity?>(null);
  UserEntity? get currentUser => _currentUser.value;
  bool get isLoggedIn => _currentUser.value != null;
  bool get isLandlord => _currentUser.value?.isLandlord ?? false;

  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadCurrentUser();
  }

  Future<void> _loadCurrentUser() async {
    _currentUser.value = await _authRepository.getCurrentUser();
  }

  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;
      final user = await _authRepository.login(email, password);
      _currentUser.value = user;
      Get.offAllNamed(AppRoutes.main);
      Get.snackbar(
        'success'.tr,
        'login_subtitle'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withAlpha(200),
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'error'.tr,
        'invalid_credentials'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withAlpha(200),
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String role,
  }) async {
    try {
      isLoading.value = true;
      final user = await _authRepository.register(
        name: name,
        email: email,
        phone: phone,
        password: password,
        role: role,
      );
      _currentUser.value = user;
      Get.offAllNamed(AppRoutes.main);
      Get.snackbar(
        'success'.tr,
        'login_subtitle'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withAlpha(200),
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'error'.tr,
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withAlpha(200),
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void continueAsGuest() {
    Get.offAllNamed(AppRoutes.main);
  }

  Future<void> switchRole() async {
    final newRole = isLandlord ? 'tenant' : 'landlord';
    await _authRepository.switchRole(newRole);
    if (_currentUser.value != null) {
      _currentUser.value = UserEntity(
        id: _currentUser.value!.id,
        name: _currentUser.value!.name,
        email: _currentUser.value!.email,
        phone: _currentUser.value!.phone,
        role: newRole,
        nationalId: _currentUser.value!.nationalId,
      );
    }
  }

  Future<void> logout() async {
    await _authRepository.logout();
    _currentUser.value = null;
    Get.offAllNamed(AppRoutes.login);
  }
}
