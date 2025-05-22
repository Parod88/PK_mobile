enum UserRole {
  admin,
  user,
  superAdmin;

  factory UserRole.fromName(String name) {
    switch (name) {
      case 'admin':
        return UserRole.admin;
      case 'user':
        return UserRole.user;
      case 'superAdmin':
        return UserRole.superAdmin;
      default:
        throw Exception('$name is not proper value for UserRole');
    }
  }
}

extension UserRoleExtension on UserRole {
  String get name {
    switch (this) {
      case UserRole.admin:
        return 'admin';
      case UserRole.user:
        return 'user';
      case UserRole.superAdmin:
        return 'superAdmin';
    }
  }
}
