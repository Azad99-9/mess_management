import 'package:hive/hive.dart';

class HiveService {
  static const menuCache = 'menu_cache';

  static Box? menuCacheBox;

  /// Opens a Hive box with the given name.
  ///
  /// - Parameters:
  ///   - `boxName`: The name of the Hive box to open.
  /// - Returns: The opened Hive box.
  Future<Box<T>> openBox<T>(String boxName) async {
    try {
      // Check if the box is already open
      if (Hive.isBoxOpen(boxName)) {
        return Hive.box<T>(boxName); // Return the already opened box
      }

      // Open the box if not already opened
      return await Hive.openBox<T>(boxName);
    } catch (e) {
      print('Error opening Hive box "$boxName": $e');
      rethrow;
    }
  }

  /// Stores a key-value pair in the specified Hive box.
  ///
  /// - Parameters:
  ///   - `boxName`: The name of the Hive box.
  ///   - `key`: The key for the value to store.
  ///   - `value`: The value to store.
  /// - Returns: A boolean indicating success or failure.
  Future<bool> put<T>(Box? box, dynamic key, T value) async {
    try {
      await box!.put(key, value);
      return true;
    } catch (e) {
      print('Error storing value in box "${box!.name}": $e');
      return false;
    }
  }

  /// Retrieves a value from the specified Hive box by key.
  ///
  /// - Parameters:
  ///   - `boxName`: The name of the Hive box.
  ///   - `key`: The key for the value to retrieve.
  /// - Returns: The value associated with the key, or `null` if not found.
  Future<T?> get<T>(Box? box, dynamic key) async {
    try {
      return box!.get(key);
    } catch (e) {
      print('Error retrieving value from box "${box!.name}": $e');
      return null;
    }
  }

  /// Deletes a value from the specified Hive box by key.
  ///
  /// - Parameters:
  ///   - `boxName`: The name of the Hive box.
  ///   - `key`: The key for the value to delete.
  /// - Returns: A boolean indicating success or failure.
  Future<bool> delete(Box? box, dynamic key) async {
    try {
      await box!.delete(key);
      return true;
    } catch (e) {
      print('Error deleting value from box "${box!.name}": $e');
      return false;
    }
  }

  /// Closes a Hive box with the given name.
  ///
  /// - Parameters:
  ///   - `boxName`: The name of the Hive box to close.
  /// - Returns: A boolean indicating success or failure.
  Future<bool> closeBox(Box? box) async {
    try {
      await box!.close();
      return true;
    } catch (e) {
      print('Error closing Hive box "${box!.name}": $e');
      return false;
    }
  }

  /// Deletes a Hive box with the given name.
  ///
  /// - Parameters:
  ///   - `boxName`: The name of the Hive box to delete.
  /// - Returns: A boolean indicating success or failure.
  Future<bool> deleteBox(Box? box) async {
    try {
      await Hive.deleteBoxFromDisk(box!.name);
      return true;
    } catch (e) {
      print('Error deleting Hive box "${box!.name}" from disk: $e');
      return false;
    }
  }
}
