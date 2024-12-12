class ComplaintModel {
  late final String title;
  late final String description;
  late final String category;
  late final String uploadUrl;
  late final String uid;

  // Constructor
  ComplaintModel({
    required this.title,
    required this.description,
    required this.category,
    required this.uploadUrl,
    required this.uid,
  });

  // From JSON method
  factory ComplaintModel.fromJson(Map<String, dynamic> json) {
    return ComplaintModel(
      title: json['title'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      uploadUrl: json['uploadUrl'] as String,
      uid: json['uid'] as String,
    );
  }

  // To JSON method
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'category': category,
      'uploadUrl': uploadUrl,
      'uid': uid,
    };
  }
}
