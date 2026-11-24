class UserModel {
  final int? id;
  final String username;
  final String email;
  final String password;
  final String displayName;
  final String bio;
  final String location;
  final String birthDate;

  const UserModel({
    this.id,
    required this.username,
    required this.email,
    required this.password,
    this.displayName = '',
    this.bio = '',
    this.location = '',
    this.birthDate = '',
  });
}
