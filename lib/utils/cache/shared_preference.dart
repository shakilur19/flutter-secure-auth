import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';

class SharedPreference {
  static var errorSharedPref = "Error From SharedPreference => ";

  static Future<String?> getValue(String key) async {
    const storage = FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      ),
      iOptions: IOSOptions(
        accessibility: KeychainAccessibility.first_unlock_this_device, // Optional: Set according to your needs
      ),
    );
    String? value = '';
    try {
      value = await storage.read(key: key);
    } on PlatformException catch (e) {
      Logger().e('PlatformException: $e');
    } catch (e) {
      Logger().e(errorSharedPref + e.toString());
    }
    return value;
  }

  static Future<bool> setValue(String key, String value) async {
    const storage = FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      ),
      iOptions: IOSOptions(
        accessibility: KeychainAccessibility.first_unlock_this_device,
      ),
    );

    try {
      await storage.write(key: key, value: value);
      return true;
    } catch (e) {
      Logger().e(errorSharedPref + e.toString());
      return false;
    }
  }

  static Future<void> remove(String key) async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: key);
  }

  static Future<void> removeMultiple(RegExp pattern) async {
    const storage = FlutterSecureStorage();
    final all = await storage.readAll();

    for (var key in all.keys) {
      if (!pattern.hasMatch(key)) continue;
      await storage.delete(key: key);
    }
  }

  static Future<bool> setBool(String key, bool value) async {
    const storage = FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      ),
      iOptions: IOSOptions(
        accessibility: KeychainAccessibility.first_unlock_this_device,
      ),
    );

    try {
      await storage.write(key: key, value: value.toString());
      return true;
    } catch (e) {
      Logger().e(errorSharedPref + e.toString());
      return false;
    }
  }

  static Future<bool> getBool(String key) async {
    bool hasValue = false;
    try {
      final String? value = await SharedPreference.getValue(key);
      hasValue = value.toString().toLowerCase() == "true" ? true : false;
    } catch (e) {
      Logger().e(errorSharedPref + e.toString());
    }
    return Future<bool>.value(hasValue);
  }

  static Future<void> removeAll() async {
    const storage = FlutterSecureStorage();
    await storage.deleteAll();
  }
}