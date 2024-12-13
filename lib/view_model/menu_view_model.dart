import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:mess_management/model/menu_model.dart';
import 'package:mess_management/services/db_service.dart';
import 'package:stacked/stacked.dart';

class MenuViewModel extends BaseViewModel {
  MenuModel? _menuData;
  MenuModel? get menuData => _menuData;


  List<String> days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];


  bool isLoading = false;

  Future<void> fetchMenu() async {
    if (_menuData != null) return;
    isLoading = true;
    //
    final snapshot = await DBService.constants.get();
    final docs = snapshot.docs;

    // try {
    //   final response = await http.get(
    //     Uri.parse('https://us-central1-mess-management-250df.cloudfunctions.net/getAllMenu'),
    //   );
    //   print("hitted");
    //   if (response.statusCode == 200) {
    //     final jsonData = json.decode(response.body);
    //     _menuData = MenuModel.fromJson(jsonData);
    //     print(_menuData?.data);
    //
    //   } else {
    //     throw Exception('Failed to load menu. Status code: ${response.statusCode}');
    //   }
    // } catch (error) {
    //   throw Exception('An error occurred while fetching the menu: $error');
    // } finally {
    //   notifyListeners();
    // }
    isLoading = false;

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
}
