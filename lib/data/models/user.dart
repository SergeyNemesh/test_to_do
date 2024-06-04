import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    this.email = '',
    this.password = '',
  });

  final String email;
  final String password;

  @override
  List<Object?> get props => [
        email,
        password,
      ];

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }
}
