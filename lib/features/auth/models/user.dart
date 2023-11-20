import 'dart:convert';

class User {
  final String id;
  final String name;
  final String password;
  final String address;
  final String token;
  final String type;
  final String email;

  User(
      {required this.id,
      required this.name,
      required this.password,
      required this.address,
      required this.token,
      required this.type,
      required this.email});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'password': password,
      'address': address,
      'token': token,
      'type': type,
      'email': email,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] as String,
      name: map['name'] as String,
      password: map['password'] as String,
      address: map['address'] as String,
      token: map['token'] as String,
      type: map['type'] as String,
      email: map['email'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
