class UserProfileModel {
  final String email;
  final String password;
  final String name;
  final String birthYear;
  final String birthDay;
  final String gender;

  UserProfileModel({
    required this.email,
    required this.password,
    required this.name,
    required this.birthYear,
    required this.birthDay,
    required this.gender,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      email: json['email'],
      password: json['password'],
      name: json['name'],
      birthYear: json['birthYear'],
      birthDay: json['birthDay'],
      gender: json['gender'],
    );
  }

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'name': name,
        'birthYear': birthYear,
        'birthDay': birthDay,
        'gender': gender,
      };
}
