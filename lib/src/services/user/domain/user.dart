class User {
  final String id;
  final String email;
  final String fullName;
  final bool hasCompletedSetup;
  final String major;
  final int semester;
  final String? username;

  User({
    required this.id,
    required this.email,
    required this.fullName,
    required this.hasCompletedSetup,
    required this.major,
    required this.semester,
    required this.username,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      email: json["email"],
      fullName: json["full_name"],
      hasCompletedSetup: json["has_completed_setup"],
      major: json["major"],
      semester: json["semester"],
      username: json["username"] ?? "",
    );
  }
}
