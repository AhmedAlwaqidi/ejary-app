import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authController = Get.find<AuthController>();

  String _selectedRole = 'tenant';

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onRegister() {
    if (_formKey.currentState?.validate() ?? false) {
      _authController.register(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        phone: _phoneController.text.trim(),
        password: _passwordController.text.trim(),
        role: _selectedRole,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('register_button'.tr)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'select_role'.tr,
                  style: AppTypography.labelLarge,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: ChoiceChip(
                        label: Center(child: Text('role_tenant'.tr)),
                        selected: _selectedRole == 'tenant',
                        selectedColor: AppColors.primaryLight,
                        onSelected: (val) {
                          if (val) setState(() => _selectedRole = 'tenant');
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ChoiceChip(
                        label: Center(child: Text('role_landlord'.tr)),
                        selected: _selectedRole == 'landlord',
                        selectedColor: AppColors.primaryLight,
                        onSelected: (val) {
                          if (val) setState(() => _selectedRole = 'landlord');
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                AppTextField(
                  label: 'full_name'.tr,
                  hint: 'أحمد الوكيدي',
                  controller: _nameController,
                  prefixIcon: Icons.person_outline,
                  validator: (v) => (v == null || v.isEmpty) ? 'validation_required'.tr : null,
                ),
                const SizedBox(height: 16),
                AppTextField(
                  label: 'email'.tr,
                  hint: 'ahmed@example.com',
                  controller: _emailController,
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'validation_required'.tr;
                    if (!v.contains('@')) return 'validation_email'.tr;
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                AppTextField(
                  label: 'phone_number'.tr,
                  hint: '+966500000000',
                  controller: _phoneController,
                  prefixIcon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                  validator: (v) => (v == null || v.isEmpty) ? 'validation_required'.tr : null,
                ),
                const SizedBox(height: 16),
                AppTextField(
                  label: 'password'.tr,
                  hint: '••••••••',
                  controller: _passwordController,
                  prefixIcon: Icons.lock_outline,
                  obscureText: true,
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'validation_required'.tr;
                    if (v.length < 6) return 'validation_password_length'.tr;
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                Obx(
                  () => AppButton(
                    text: 'register_button'.tr,
                    isLoading: _authController.isLoading.value,
                    onPressed: _onRegister,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
