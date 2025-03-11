class Admin {
  final String id;
  final String name;
  final String email;
  final String token;

  Admin({
    required this.id,
    required this.name,
    required this.email,
    required this.token,
  });

  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin(
      id: json['_id'] ?? '',
      name: json['name'] ?? 'Unknown',
      email: json['email'] ?? '',
      token: json['token'] ?? '',
    );
  }
}