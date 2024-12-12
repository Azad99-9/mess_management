class UserModel {
  late final String uid;
  late final String email;
  late final String name;
  late String phoneNumber;
  late String gender;
  late String mess;
  late  String imageURL;

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    this.phoneNumber = '',
    this.gender = '',
    this.mess='',
    this.imageURL=''
  });

  // From JSON method
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] as String,
      email: json['email'] as String,
      name: json['name']as String,
      phoneNumber: json['phoneNumber'] ?? '',
      gender: json['gender'] ?? '',
      mess: json['mess'] ?? '',
      imageURL: json['imageURL'] ?? '',
    );
  }

  // To JSON method
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name':name,
      'phoneNumber': phoneNumber,
      'gender': gender,
      'mess':mess,
      'imageURL':imageURL,
    };
  }
}
