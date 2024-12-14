class UserModel {
  final String uid;
  final String email;
  final String? name;
  String? phoneNumber;
  String? gender;
  String? mess;
  String? imageURL;
  List<String>?upvotes;
  List<String>?downvotes;
  final String FCS_TOKEN ;

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    this.phoneNumber,
    this.gender,
    this.mess,
    this.imageURL,
    this.upvotes,
    this.downvotes,
    required this.FCS_TOKEN,
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
      upvotes:List<String>.from(json['upvotes'] ?? []),
        downvotes:List<String>.from(json['downvotes'] ?? []),
      FCS_TOKEN: json['FCS_TOKEN'] as String,
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
      'upvotes':upvotes,
      'downvotes':downvotes,
      'FCS_TOKEN':FCS_TOKEN
    };
  }

  @override
  String toString() {
    return 'UserModel(uid: $uid, email: $email, name: $name, phoneNumber: $phoneNumber, gender: $gender, mess: $mess, imageURL: $imageURL,upvotes:$upvotes,downvotes:$downvotes,FCS_TOKEN:$FCS_TOKEN)';
  }
}
