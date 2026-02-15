enum UserRole { admin, patient }

class User {
  final String username;
  final String password;
  final UserRole role;
  final String patientName;

  User({
    required this.username,
    required this.password,
    required this.role,
    this.patientName = "",
  });
}
