class MenuModel {
  final bool success;
  final Map<String, DayData> data;

  MenuModel({required this.success, required this.data});

  factory MenuModel.fromJson(Map<String, dynamic> json) {
    return MenuModel(
      success: json['success'],
      data: (json['data'] as Map<String, dynamic>).map(
            (key, value) => MapEntry(key, DayData.fromJson(value)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data.map((key, value) => MapEntry(key, value.toJson())),
    };
  }
}

class DayData {
  final List<MealItem> breakFast;
  final List<MealItem> lunch;
  final List<MealItem> snacks;
  final List<MealItem> dinner;

  DayData({
    required this.breakFast,
    required this.lunch,
    required this.snacks,
    required this.dinner,
  });

  factory DayData.fromJson(Map<String, dynamic> json) {
    return DayData(
      breakFast: (json['breakFast'] as List)
          .map((item) => MealItem.fromJson(item))
          .toList(),
      lunch: (json['lunch'] as List)
          .map((item) => MealItem.fromJson(item))
          .toList(),
      snacks: (json['snacks'] as List)
          .map((item) => MealItem.fromJson(item))
          .toList(),
      dinner: (json['dinner'] as List)
          .map((item) => MealItem.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'breakFast': breakFast.map((item) => item.toJson()).toList(),
      'lunch': lunch.map((item) => item.toJson()).toList(),
      'snacks': snacks.map((item) => item.toJson()).toList(),
      'dinner': dinner.map((item) => item.toJson()).toList(),
    };
  }
}

class MealItem {
  final String itemName;
  final String quantityServed;
  final int grams;
  final int calories;

  MealItem({
    required this.itemName,
    required this.quantityServed,
    required this.grams,
    required this.calories,
  });

  factory MealItem.fromJson(Map<String, dynamic> json) {
    return MealItem(
      itemName: json['itemName'],
      quantityServed: json['quantityServed'],
      grams: json['grams'],
      calories: json['calories'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'itemName': itemName,
      'quantityServed': quantityServed,
      'grams': grams,
      'calories': calories,
    };
  }
}
