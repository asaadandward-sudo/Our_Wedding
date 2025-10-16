class AdminUser {
  final String uid;
  final String email;
  final String role; // 'groom' or 'bride'
  final DateTime createdAt;

  AdminUser({
    required this.uid,
    required this.email,
    required this.role,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() => {
    'uid': uid,
    'email': email,
    'role': role,
    'createdAt': createdAt.toIso8601String(),
  };

  factory AdminUser.fromMap(Map<String, dynamic> map) => AdminUser(
    uid: map['uid'] ?? '',
    email: map['email'] ?? '',
    role: map['role'] ?? '',
    createdAt: map['createdAt'] != null 
        ? DateTime.tryParse(map['createdAt']) ?? DateTime.now()
        : DateTime.now(),
  );
}
