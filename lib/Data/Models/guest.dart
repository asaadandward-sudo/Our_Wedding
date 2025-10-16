class Guest {
  final String name;
  final bool attending;
  final int attendeesCount;
  final String message;
  final String signature;
  final DateTime timestamp;

  Guest({
    required this.name,
    required this.attending,
    required this.attendeesCount,
    required this.message,
    required this.signature,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() => {
    'name': name,
    'attending': attending,
    'attendeesCount': attendeesCount,
    'message': message,
    'signature': signature,
    'timestamp': timestamp.toIso8601String(),
  };

  factory Guest.fromMap(Map<String, dynamic> map) => Guest(
    name: map['name'] ?? '',
    attending: map['attending'] ?? false,
    attendeesCount: map['attendeesCount'] ?? 1,
    message: map['message'] ?? '',
    signature: map['signature'] ?? '',
    timestamp: map['timestamp'] != null 
        ? DateTime.tryParse(map['timestamp']) ?? DateTime.now()
        : DateTime.now(),
  );
}
