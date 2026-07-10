class User {
  final int id;
  final String email;
  final String? uid;
  final String username;
  final String avatarUrl;
  final String role;

  const User({
    required this.id,
    required this.username,
    this.uid,
    required this.email,
    required this.avatarUrl,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      username: json['username'] as String,
      uid: json['uid'] as String?,
      email: json['email'] as String,
      avatarUrl: (json['avatar_url'] as String?) ?? '',
      role: (json['role'] as String?) ?? 'user',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'uid': uid,
        'email': email,
        'avatar_url': avatarUrl,
        'role': role,
      };
}
