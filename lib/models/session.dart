class Session {
  final String token;
  final String name;
  final String type;

  Session({required this.token, required this.name, required this.type});

  Map<String, dynamic> toMap() {
    return {
      'token': token,
      'name': name,
      'type': type,
    };
  }
}
