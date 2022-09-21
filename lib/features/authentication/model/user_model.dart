import 'dart:convert';

class User {
  final String emailAddress;
  final String password;

  User(this.emailAddress, this.password);

  User copyWith({
    String? emailAddress,
    String? password,
  }) {
    return User(
      emailAddress ?? this.emailAddress,
      password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'emailAddress': emailAddress,
      'password': password,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      map['emailAddress'] ?? '',
      map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() => 'User(emailAddress: $emailAddress, password: $password)';
}
