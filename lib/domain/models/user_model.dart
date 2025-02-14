class User {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? profilePicture;
  final String? email;

  User({this.id, this.firstName, this.lastName, this.profilePicture,this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      profilePicture: json['avatar'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'avatar': profilePicture,
      'email': email
    };
  }
}