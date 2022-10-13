import 'dart:convert';

class User {
  final String name;
  final String password;
  final String email;
  final String address;
  final String id;
  final String type;
  final String token;

  User({
    required this.email,
    required this.id,
    required this.address,
    required this.name,
    required this.password,
    required this.type,
    required this.token,
  });

  Map<String, String> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'address': address,
      'id': id,
      'type': type,
      'token': token,
    };
  }

  String toJson() {
    return json.encode(toMap());
  }
}
