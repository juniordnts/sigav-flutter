class Session {
  final String token;
  final String name;
  final String type;
  final String userId;

  Session(
      {required this.token,
      required this.name,
      required this.type,
      required this.userId});

  Map<String, dynamic> toMap() {
    return {
      'token': token,
      'name': name,
      'type': type,
      'userId': userId,
    };
  }
}
