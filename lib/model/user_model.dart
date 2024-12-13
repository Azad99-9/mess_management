class UserModel {
  final String uid;
  final String email;
  final String? name;
  String? phoneNumber;
  String? gender;
  String? mess;
  String? imageURL;

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    this.phoneNumber,
    this.gender,
    this.mess,
    this.imageURL,
  });

  // From JSON method
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] as String,
      email: json['email'] as String,
      name: json['name'] ?? 'user',
      phoneNumber: json['phoneNumber'] ?? 'not provided',
      gender: json['gender'] ?? '',
      mess: json['mess'] ?? 'not assigned',
      imageURL: json['imageURL'] ?? '',
    );
  }

  // To JSON method
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'phoneNumber': phoneNumber,
      'gender': gender,
      'mess': mess,
      'imageURL': imageURL,
    };
  }

  @override
  String toString() {
    return 'UserModel(uid: $uid, email: $email, name: $name, phoneNumber: $phoneNumber, gender: $gender, mess: $mess, imageURL: $imageURL)';
  }

}
