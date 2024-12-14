class ResponseModel {
  late final String startDate;
  late final String endDate;
  late final double timeliness;
  late final double cleanliness;
  late final double quality;
  late final double taste;
  late final double snacks;
  late final double quantity;
  late final double courtesy;
  late final double attire;
  late final double serving;
  late final double washArea;
  late final String uid;
  late final String mess;

  // Constructor
  ResponseModel(
      {required this.startDate,
        required this.endDate,
        required this.timeliness,
        required this.cleanliness,
        required this.quality,
        required this.taste,
        required this.snacks,
        required this.quantity,
        required this.courtesy,
        required this.attire,
        required this.serving,
        required this.washArea,
        required this.mess,
        required this.uid});

  // From JSON method
  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
        startDate: json['startDate'] as String,
        endDate: json['endDate'] as String,
        timeliness: (json['timeliness'] as num).toDouble(),
        cleanliness: (json['cleanliness'] as num).toDouble(),
        quality: (json['quality'] as num).toDouble(),
        taste: (json['taste'] as num).toDouble(),
        snacks: (json['snacks'] as num).toDouble(),
        quantity: (json['quantity'] as num).toDouble(),
        courtesy: (json['courtesy'] as num).toDouble(),
        attire: (json['attire'] as num).toDouble(),
        serving: (json['serving'] as num).toDouble(),
        washArea: (json['washArea'] as num).toDouble(),
        mess: (json['mess'])as String,
        uid: json['uid'] as String);
  }

  // To JSON method
  Map<String, dynamic> toJson() {
    return {
      'startDate': startDate,
      'endDate': endDate,
      'timeliness': timeliness,
      'cleanliness': cleanliness,
      'quality': quality,
      'taste': taste,
      'snacks': snacks,
      'quantity': quantity,
      'courtesy': courtesy,
      'attire': attire,
      'serving': serving,
      'washArea': washArea,
      'mess':mess,
      'uid': uid,
    };
  }
}
