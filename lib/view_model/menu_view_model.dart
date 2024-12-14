// import 'dart:convert';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:http/http.dart' as http;
// import 'package:mess_management/model/menu_model.dart';
// import 'package:mess_management/services/db_service.dart';
// import 'package:stacked/stacked.dart';
//
// class MenuViewModel extends BaseViewModel {
//   MenuModel? _menuData;
//   MenuModel? get menuData =>_menuData;
//       // MenuModel? get menuData =>   MenuModel.fromJson({
//   //   "success": true,
//   //   "data": {
//   //     "Sunday": {
//   //       "breakFast": [
//   //         {
//   //           "itemName": "Milk",
//   //           "quantityServed": "1 cup",
//   //           "grams": "200",
//   //           "calories": "150"
//   //         }
//   //       ],
//   //       "lunch": [
//   //         {
//   //           "itemName": "Rice",
//   //           "quantityServed": "3 bowls",
//   //           "grams": "200",
//   //           "calories": "180"
//   //         }
//   //       ],
//   //       "snacks": [
//   //         {
//   //           "itemName": "Milk",
//   //           "quantityServed": "1 cup",
//   //           "grams": "200",
//   //           "calories": "150"
//   //         }
//   //       ],
//   //       "dinner": [
//   //         {
//   //           "itemName": "Rice",
//   //           "quantityServed": "3 bowls",
//   //           "grams": "200",
//   //           "calories": "180"
//   //         },
//   //         {
//   //           "itemName": "Sambar",
//   //           "quantityServed": "2 bowls",
//   //           "grams": "250",
//   //           "calories": "100"
//   //         }
//   //       ]
//   //     }
//   //   }
//   // });
//
//
//   List<String> days = [
//     'Monday',
//   ];
//
//
//   bool isLoading = false;
//
//   Future<void> fetchMenu() async {
//     if (_menuData != null) return;
//     isLoading = true;
//
//     final snapshot = await DBService.constants.get();
//     final docs = snapshot.docs;
//
//     try {
//       final response = await http.get(
//         Uri.parse('https://us-central1-mess-management-250df.cloudfunctions.net/getAllMenu'),
//       );
//       if (response.statusCode == 200) {
//         final jsonData = json.decode(response.body);
//         _menuData = MenuModel.fromJson(jsonData);
//       } else {
//         throw Exception('Failed to load menu. Status code: ${response.statusCode}');
//       }
//     } catch (error) {
//       throw Exception('An error occurred while fetching the menu: $error');
//     } finally {
//       notifyListeners();
//     }
//     isLoading = false;
//   //   notifyListeners();
//   //
//     notifyListeners();
//   }
// // Determines the current meal type based on the time
//   String getCurrentMealType(DateTime currentTime) {
//     final hour = currentTime.hour;
//
//     if (hour >= 4 && hour < 12) {
//       return 'Breakfast';
//     } else if (hour >= 12 && hour < 16) {
//       return 'Lunch';
//     } else if (hour >= 16 && hour < 19) {
//       return 'Snacks';
//     } else {
//       return 'Dinner';
//     }
//   }
// }
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:mess_management/model/menu_model.dart';
import 'package:mess_management/services/db_service.dart';
import 'package:stacked/stacked.dart';

class MenuViewModel extends BaseViewModel {
  MenuModel? _menuData;
  MenuModel? get menuData => _menuData;

  bool isLoading = false;

  Future<void> fetchMenu() async {
    if (_menuData != null) return;
    isLoading = true;
    notifyListeners();

    try {
      // final response = await http.get(
      //   Uri.parse(
      //       'https://us-central1-mess-management-250df.cloudfunctions.net/getAllMenu'),
      // );
      //
      // print("Response Status: ${response.statusCode}");
      // print("Response Body: ${response.body}");

      // if (response.statusCode == 200) {
      //   final jsonData = json.decode(response.body);
      //
      //   print("Fetched menu data: $_menuData");
      // } else {
      //   throw Exception(
      //       'Failed to load menu. Status code: ${response.statusCode}');
      // }
      _menuData=MenuModel.fromJson({
        "success": true,
        "data": {
          "Monday": {
            "breakFast": [
              {"itemName": "Milk", "quantityServed": "1 cup", "grams": "200", "calories": "150"}
            ],
            "lunch": [
              {"itemName": "Rice", "quantityServed": "3 bowls", "grams": "200", "calories": "180"}
            ],
            "snacks": [
              {"itemName": "Milk", "quantityServed": "1 cup", "grams": "200", "calories": "150"}
            ],
            "dinner": [
              {"itemName": "Rice", "quantityServed": "3 bowls", "grams": "200", "calories": "180"},
              {"itemName": "Sambar", "quantityServed": "2 bowls", "grams": "250", "calories": "100"}
            ]
          },
          "Tuesday": {
            "breakFast": [
              {"itemName": "Milk", "quantityServed": "1 cup", "grams": "200", "calories": "150"}
            ],
            "lunch": [
              {"itemName": "Rice", "quantityServed": "3 bowls", "grams": "200", "calories": "180"}
            ],
            "snacks": [
              {"itemName": "Milk", "quantityServed": "1 cup", "grams": "200", "calories": "150"}
            ],
            "dinner": [
              {"itemName": "Rice", "quantityServed": "3 bowls", "grams": "200", "calories": "180"},
              {"itemName": "Sambar", "quantityServed": "2 bowls", "grams": "250", "calories": "100"}
            ]
          },
          "Wednesday": {
            "breakFast": [
              {"itemName": "Milk", "quantityServed": "1 cup", "grams": "200", "calories": "150"}
            ],
            "lunch": [
              {"itemName": "Rice", "quantityServed": "3 bowls", "grams": "200", "calories": "180"}
            ],
            "snacks": [
              {"itemName": "Milk", "quantityServed": "1 cup", "grams": "200", "calories": "150"}
            ],
            "dinner": [
              {"itemName": "Rice", "quantityServed": "3 bowls", "grams": "200", "calories": "180"},
              {"itemName": "Sambar", "quantityServed": "2 bowls", "grams": "250", "calories": "100"}
            ]
          },
          "Thursday": {
            "breakFast": [
              {"itemName": "Milk", "quantityServed": "1 cup", "grams": "200", "calories": "150"}
            ],
            "lunch": [
              {"itemName": "Rice", "quantityServed": "3 bowls", "grams": "200", "calories": "180"}
            ],
            "snacks": [
              {"itemName": "Milk", "quantityServed": "1 cup", "grams": "200", "calories": "150"}
            ],
            "dinner": [
              {"itemName": "Rice", "quantityServed": "3 bowls", "grams": "200", "calories": "180"},
              {"itemName": "Sambar", "quantityServed": "2 bowls", "grams": "250", "calories": "100"}
            ]
          },
          "Friday": {
            "breakFast": [
              {"itemName": "Milk", "quantityServed": "1 cup", "grams": "200", "calories": "150"}
            ],
            "lunch": [
              {"itemName": "Rice", "quantityServed": "3 bowls", "grams": "200", "calories": "180"}
            ],
            "snacks": [
              {"itemName": "Milk", "quantityServed": "1 cup", "grams": "200", "calories": "150"}
            ],
            "dinner": [
              {"itemName": "Rice", "quantityServed": "3 bowls", "grams": "200", "calories": "180"},
              {"itemName": "Sambar", "quantityServed": "2 bowls", "grams": "250", "calories": "100"}
            ]
          },
          "Saturday": {
            "breakFast": [
              {"itemName": "Milk", "quantityServed": "1 cup", "grams": "200", "calories": "150"}
            ],
            "lunch": [
              {"itemName": "Rice", "quantityServed": "3 bowls", "grams": "200", "calories": "180"}
            ],
            "snacks": [
              {"itemName": "Milk", "quantityServed": "1 cup", "grams": "200", "calories": "150"}
            ],
            "dinner": [
              {"itemName": "Rice", "quantityServed": "3 bowls", "grams": "200", "calories": "180"},
              {"itemName": "Sambar", "quantityServed": "2 bowls", "grams": "250", "calories": "100"}
            ]
          },
          "Sunday": {
            "breakFast": [
              {"itemName": "Milk", "quantityServed": "1 cup", "grams": "200", "calories": "150"}
            ],
            "lunch": [
              {"itemName": "Rice", "quantityServed": "3 bowls", "grams": "200", "calories": "180"}
            ],
            "snacks": [
              {"itemName": "Milk", "quantityServed": "1 cup", "grams": "200", "calories": "150"}
            ],
            "dinner": [
              {"itemName": "Rice", "quantityServed": "3 bowls", "grams": "200", "calories": "180"},
              {"itemName": "Sambar", "quantityServed": "2 bowls", "grams": "250", "calories": "100"}
            ]
          },
        },
      });

    } catch (error) {
      print("Error occurred: $error");
      throw Exception('An error occurred while fetching the menu: $error');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Determines the current meal type based on the time
  String getCurrentMealType(DateTime currentTime) {
    final hour = currentTime.hour;

    if (hour >= 4 && hour < 12) {
      return 'Breakfast';
    } else if (hour >= 12 && hour < 16) {
      return 'Lunch';
    } else if (hour >= 16 && hour < 19) {
      return 'Snacks';
    } else {
      return 'Dinner';
    }
  }
  String getDayOfWeek(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return '';
    }
  }
}
