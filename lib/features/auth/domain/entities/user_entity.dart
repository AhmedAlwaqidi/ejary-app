/// User Entity
class UserEntity {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String role; // 'tenant' or 'landlord'
  final String? nationalId;

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    this.nationalId,
  });

  bool get isLandlord => role == 'landlord';
  bool get isTenant => role == 'tenant';
}
