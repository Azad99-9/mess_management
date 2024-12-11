class UserModel {
  late final String uid;
  late final String email;
  late String phoneNumber;
  late String gender;

  UserModel({
    required this.uid,
    required this.email,
    this.phoneNumber = '',
    this.gender = '',
  });

  // From JSON method
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] ?? '',
      gender: json['gender'] ?? '',
    );
  }

  // To JSON method
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'phoneNumber': phoneNumber,
      'gender': gender,
    };
  }
}
