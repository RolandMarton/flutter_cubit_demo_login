class User {
  final String username;
  final String email;

  User({required this.username, required this.email});

  Map<String, dynamic> toMap() {
    return {'username': username, 'email': email};
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(username: map['username'], email: map['email']);
  }
}
