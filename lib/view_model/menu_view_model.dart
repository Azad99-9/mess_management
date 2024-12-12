import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mess_management/model/menu_model.dart';
import 'package:stacked/stacked.dart';

class MenuViewModel extends BaseViewModel {
  MenuModel? _menuData;
  MenuModel? get menuData => _menuData;

  Future<void> fetchMenu() async {
    if (menuData != null) return;
    setBusy(true);
    try {
      final response = await http.get(
        Uri.parse('https://us-central1-mess-management-250df.cloudfunctions.net/getAllMenu'),
      );
      print("hitted");
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        _menuData = MenuModel.fromJson(jsonData);

      } else {
        throw Exception('Failed to load menu. Status code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('An error occurred while fetching the menu: $error');
    } finally {
      setBusy(false);
      notifyListeners();
    }
  }
}
