import 'package:mongo_dart/mongo_dart.dart';

class User {
  final ObjectId id;
  final String name;
  final String username;
  final String email;
  final String password;

  const User(
      {required this.id,
      required this.name,
      required this.username,
      required this.email,
      required this.password});

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'username': username,
      'email': email,
      'password': password
    };
  }

  User.fromMap(Map<String, dynamic> map)
      : name = map['name'],
        id = map['_id'],
        username = map['username'],
        email = map['email'],
        password = map['password'];
}
