import 'package:logger/logger.dart';

import 'shared_preference.dart';

class Cache {
  final _logger = Logger();

  final preference = SharedPreference();
  Future<void> forever(String key, String value) async {
    try {
      await SharedPreference.setValue(key, value);
    } catch (e) {
      _logger.e("Cache Error - Unable to save key '$key': $e");
    }
  }

  Future<String?> get(String key) async {
    try {
      return await SharedPreference.getValue(key);
    } catch (e) {
      _logger.e("Cache Error - Unable to retrieve key '$key': $e");
      return null;
    }
  }

  Future<void> put(String key, String value, Duration duration) async {
    try {
      await forever(key, value);
      _startExpirationTimer(key, duration);
    } catch (e) {
      _logger.e("Cache Error - Unable to put key '$key': $e");
    }
  }

  Future<void> remove(String key) async {
    try {
      await SharedPreference.remove(key);
    } catch (e) {
      _logger.e("Cache Error - Unable to remove key '$key': $e");
    }
  }

  void _startExpirationTimer(String key, Duration duration) {
    Future.delayed(duration, () async {
      try {
        await remove(key);
        _logger.i("Cache Info - Key '$key' expired and removed.");
      } catch (e) {
        _logger.e("Cache Error - Unable to remove expired key '$key': $e");
      }
    });
  }
}
