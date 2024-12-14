
import 'package:mess_management/model/menu_model.dart';
import 'package:mess_management/services/db_service.dart';
import 'package:mess_management/services/hive_service.dart';
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

  static const String prevMatcher = 'prevMatcher';
  static const String cachedMenu = 'cachedMenu';

  bool isLoading = false;

  Future<void> fetchMenu() async {
    if (_menuData != null) return;
    isLoading = true;
    notifyListeners();


    _menuData = MenuModel.fromJson({
      "success": true,
      "data": {
        "Monday": {
          "breakFast": [
            {"itemName": "Milk", "quantityServed": "1 cup", "grams": "200", "calories": "150"},
            {"itemName": "Bread", "quantityServed": "2 slices", "grams": "50", "calories": "130"},
            {"itemName": "Butter", "quantityServed": "10g", "grams": "10", "calories": "70"},
            {"itemName": "Banana", "quantityServed": "1 piece", "grams": "120", "calories": "105"}
          ],
          "lunch": [
            {"itemName": "Rice", "quantityServed": "3 bowls", "grams": "200", "calories": "180"},
            {"itemName": "Dal", "quantityServed": "1 bowl", "grams": "150", "calories": "100"},
            {"itemName": "Vegetable Curry", "quantityServed": "1 bowl", "grams": "150", "calories": "120"},
            {"itemName": "Curd", "quantityServed": "1 bowl", "grams": "100", "calories": "60"}
          ],
          "snacks": [
            {"itemName": "Milk", "quantityServed": "1 cup", "grams": "200", "calories": "150"},
            {"itemName": "Biscuits", "quantityServed": "4 pieces", "grams": "50", "calories": "200"},
            {"itemName": "Fruits", "quantityServed": "1 bowl", "grams": "150", "calories": "90"},
            {"itemName": "Tea", "quantityServed": "1 cup", "grams": "150", "calories": "50"}
          ],
          "dinner": [
            {"itemName": "Rice", "quantityServed": "3 bowls", "grams": "200", "calories": "180"},
            {"itemName": "Sambar", "quantityServed": "2 bowls", "grams": "250", "calories": "100"},
            {"itemName": "Chapati", "quantityServed": "2 pieces", "grams": "100", "calories": "200"},
            {"itemName": "Paneer Curry", "quantityServed": "1 bowl", "grams": "150", "calories": "150"}
          ]
        },
        "Tuesday": {
          "breakFast": [
            {"itemName": "Oats", "quantityServed": "1 bowl", "grams": "200", "calories": "120"},
            {"itemName": "Apple", "quantityServed": "1 piece", "grams": "180", "calories": "95"},
            {"itemName": "Boiled Egg", "quantityServed": "2 pieces", "grams": "100", "calories": "140"},
            {"itemName": "Milk", "quantityServed": "1 cup", "grams": "200", "calories": "150"}
          ],
          "lunch": [
            {"itemName": "Rice", "quantityServed": "3 bowls", "grams": "200", "calories": "180"},
            {"itemName": "Chicken Curry", "quantityServed": "1 bowl", "grams": "200", "calories": "220"},
            {"itemName": "Green Salad", "quantityServed": "1 bowl", "grams": "150", "calories": "50"},
            {"itemName": "Curd", "quantityServed": "1 bowl", "grams": "100", "calories": "60"}
          ],
          "snacks": [
            {"itemName": "Tea", "quantityServed": "1 cup", "grams": "150", "calories": "50"},
            {"itemName": "Samosa", "quantityServed": "2 pieces", "grams": "120", "calories": "250"},
            {"itemName": "Banana", "quantityServed": "1 piece", "grams": "120", "calories": "105"},
            {"itemName": "Cookies", "quantityServed": "4 pieces", "grams": "80", "calories": "200"}
          ],
          "dinner": [
            {"itemName": "Rice", "quantityServed": "2 bowls", "grams": "200", "calories": "180"},
            {"itemName": "Roti", "quantityServed": "2 pieces", "grams": "100", "calories": "150"},
            {"itemName": "Mixed Veg Curry", "quantityServed": "1 bowl", "grams": "200", "calories": "150"},
            {"itemName": "Soup", "quantityServed": "1 bowl", "grams": "250", "calories": "80"}
          ]
        },
        "Wednesday": {
          "breakFast": [
            {"itemName": "Paratha", "quantityServed": "2 pieces", "grams": "150", "calories": "220"},
            {"itemName": "Yogurt", "quantityServed": "1 bowl", "grams": "150", "calories": "90"},
            {"itemName": "Orange", "quantityServed": "1 piece", "grams": "150", "calories": "60"},
            {"itemName": "Milk", "quantityServed": "1 cup", "grams": "200", "calories": "150"}
          ],
          "lunch": [
            {"itemName": "Pulao", "quantityServed": "1 bowl", "grams": "250", "calories": "210"},
            {"itemName": "Paneer Curry", "quantityServed": "1 bowl", "grams": "150", "calories": "150"},
            {"itemName": "Salad", "quantityServed": "1 bowl", "grams": "150", "calories": "50"},
            {"itemName": "Dal", "quantityServed": "1 bowl", "grams": "150", "calories": "100"}
          ],
          "snacks": [
            {"itemName": "Coffee", "quantityServed": "1 cup", "grams": "150", "calories": "50"},
            {"itemName": "Sandwich", "quantityServed": "1 piece", "grams": "150", "calories": "200"},
            {"itemName": "Fruits", "quantityServed": "1 bowl", "grams": "150", "calories": "90"},
            {"itemName": "Nuts", "quantityServed": "30g", "grams": "30", "calories": "200"}
          ],
          "dinner": [
            {"itemName": "Rice", "quantityServed": "3 bowls", "grams": "200", "calories": "180"},
            {"itemName": "Chicken Curry", "quantityServed": "1 bowl", "grams": "200", "calories": "220"},
            {"itemName": "Soup", "quantityServed": "1 bowl", "grams": "250", "calories": "80"},
            {"itemName": "Roti", "quantityServed": "2 pieces", "grams": "100", "calories": "150"}
          ]
        },
        "Thursday": {
          "breakFast": [
            {"itemName": "Idli", "quantityServed": "3 pieces", "grams": "150", "calories": "120"},
            {"itemName": "Sambar", "quantityServed": "1 bowl", "grams": "200", "calories": "100"},
            {"itemName": "Chutney", "quantityServed": "1 bowl", "grams": "50", "calories": "50"},
            {"itemName": "Milk", "quantityServed": "1 cup", "grams": "200", "calories": "150"}
          ],
          "lunch": [
            {"itemName": "Vegetable Biryani", "quantityServed": "1 bowl", "grams": "250", "calories": "200"},
            {"itemName": "Raita", "quantityServed": "1 bowl", "grams": "100", "calories": "50"},
            {"itemName": "Dal", "quantityServed": "1 bowl", "grams": "150", "calories": "100"},
            {"itemName": "Salad", "quantityServed": "1 bowl", "grams": "150", "calories": "50"}
          ],
          "snacks": [
            {"itemName": "Tea", "quantityServed": "1 cup", "grams": "150", "calories": "50"},
            {"itemName": "Cutlets", "quantityServed": "2 pieces", "grams": "120", "calories": "250"},
            {"itemName": "Banana", "quantityServed": "1 piece", "grams": "120", "calories": "105"},
            {"itemName": "Cookies", "quantityServed": "4 pieces", "grams": "80", "calories": "200"}
          ],
          "dinner": [
            {"itemName": "Rice", "quantityServed": "2 bowls", "grams": "200", "calories": "180"},
            {"itemName": "Fish Curry", "quantityServed": "1 bowl", "grams": "200", "calories": "220"},
            {"itemName": "Roti", "quantityServed": "2 pieces", "grams": "100", "calories": "150"},
            {"itemName": "Soup", "quantityServed": "1 bowl", "grams": "250", "calories": "80"}
          ]
        },
        "Friday": {
          "breakFast": [
            {"itemName": "Poha", "quantityServed": "1 bowl", "grams": "150", "calories": "150"},
            {"itemName": "Tea", "quantityServed": "1 cup", "grams": "150", "calories": "50"},
            {"itemName": "Boiled Egg", "quantityServed": "2 pieces", "grams": "100", "calories": "140"},
            {"itemName": "Apple", "quantityServed": "1 piece", "grams": "180", "calories": "95"}
          ],
          "lunch": [
            {"itemName": "Rice", "quantityServed": "3 bowls", "grams": "200", "calories": "180"},
            {"itemName": "Paneer Butter Masala", "quantityServed": "1 bowl", "grams": "200", "calories": "250"},
            {"itemName": "Dal", "quantityServed": "1 bowl", "grams": "150", "calories": "100"},
            {"itemName": "Curd", "quantityServed": "1 bowl", "grams": "100", "calories": "60"}
          ],
          "snacks": [
            {"itemName": "Coffee", "quantityServed": "1 cup", "grams": "150", "calories": "50"},
            {"itemName": "Veg Puff", "quantityServed": "1 piece", "grams": "150", "calories": "220"},
            {"itemName": "Fruits", "quantityServed": "1 bowl", "grams": "150", "calories": "90"},
            {"itemName": "Nuts", "quantityServed": "30g", "grams": "30", "calories": "200"}
          ],
          "dinner": [
            {"itemName": "Rice", "quantityServed": "3 bowls", "grams": "200", "calories": "180"},
            {"itemName": "Mutton Curry", "quantityServed": "1 bowl", "grams": "200", "calories": "280"},
            {"itemName": "Roti", "quantityServed": "2 pieces", "grams": "100", "calories": "150"},
            {"itemName": "Mixed Veg Curry", "quantityServed": "1 bowl", "grams": "200", "calories": "150"}
          ]
        },
        "Saturday": {
          "breakFast": [
            {"itemName": "Upma", "quantityServed": "1 bowl", "grams": "200", "calories": "180"},
            {"itemName": "Coconut Chutney", "quantityServed": "1 bowl", "grams": "50", "calories": "50"},
            {"itemName": "Orange Juice", "quantityServed": "1 glass", "grams": "250", "calories": "110"},
            {"itemName": "Milk", "quantityServed": "1 cup", "grams": "200", "calories": "150"}
          ],
          "lunch": [
            {"itemName": "Fried Rice", "quantityServed": "1 bowl", "grams": "250", "calories": "220"},
            {"itemName": "Chicken Curry", "quantityServed": "1 bowl", "grams": "200", "calories": "220"},
            {"itemName": "Salad", "quantityServed": "1 bowl", "grams": "150", "calories": "50"},
            {"itemName": "Dal", "quantityServed": "1 bowl", "grams": "150", "calories": "100"}
          ],
          "snacks": [
            {"itemName": "Tea", "quantityServed": "1 cup", "grams": "150", "calories": "50"},
            {"itemName": "Pakora", "quantityServed": "8 pieces", "grams": "150", "calories": "250"},
            {"itemName": "Banana", "quantityServed": "1 piece", "grams": "120", "calories": "105"},
            {"itemName": "Biscuits", "quantityServed": "4 pieces", "grams": "50", "calories": "200"}
          ],
          "dinner": [
            {"itemName": "Rice", "quantityServed": "2 bowls", "grams": "200", "calories": "180"},
            {"itemName": "Paneer Tikka Masala", "quantityServed": "1 bowl", "grams": "200", "calories": "250"},
            {"itemName": "Roti", "quantityServed": "2 pieces", "grams": "100", "calories": "150"},
            {"itemName": "Soup", "quantityServed": "1 bowl", "grams": "250", "calories": "80"}
          ]
        },
        "Sunday": {
          "breakFast": [
            {"itemName": "Dosa", "quantityServed": "2 pieces", "grams": "200", "calories": "180"},
            {"itemName": "Sambar", "quantityServed": "1 bowl", "grams": "200", "calories": "100"},
            {"itemName": "Coconut Chutney", "quantityServed": "1 bowl", "grams": "50", "calories": "50"},
            {"itemName": "Milk", "quantityServed": "1 cup", "grams": "200", "calories": "150"}
          ],
          "lunch": [
            {"itemName": "Biriyani", "quantityServed": "1 bowl", "grams": "250", "calories": "300"},
            {"itemName": "Raita", "quantityServed": "1 bowl", "grams": "100", "calories": "50"},
            {"itemName": "Chicken Curry", "quantityServed": "1 bowl", "grams": "200", "calories": "220"},
            {"itemName": "Salad", "quantityServed": "1 bowl", "grams": "150", "calories": "50"}
          ],
          "snacks": [
            {"itemName": "Coffee", "quantityServed": "1 cup", "grams": "150", "calories": "50"},
            {"itemName": "Veg Sandwich", "quantityServed": "1 piece", "grams": "150", "calories": "200"},
            {"itemName": "Fruits", "quantityServed": "1 bowl", "grams": "150", "calories": "90"},
            {"itemName": "Nuts", "quantityServed": "30g", "grams": "30", "calories": "200"}
          ],
          "dinner": [
            {"itemName": "Rice", "quantityServed": "2 bowls", "grams": "200", "calories": "180"},
            {"itemName": "Mutton Curry", "quantityServed": "1 bowl", "grams": "200", "calories": "280"},
            {"itemName": "Roti", "quantityServed": "2 pieces", "grams": "100", "calories": "150"},
            {"itemName": "Mixed Veg Curry", "quantityServed": "1 bowl", "grams": "200", "calories": "150"}
          ]
        }
      }
    });


    isLoading = false;
    notifyListeners();
  }

  // Determines the current meal type based on the time
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
