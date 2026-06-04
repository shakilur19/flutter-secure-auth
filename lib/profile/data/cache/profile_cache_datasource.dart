import 'dart:convert';

import '../model/profile_response.dart';
import '../../../utils/cache/shared_preference.dart';

class ProfileCacheDataSource {
  static const String _profileKey = 'profile_cache';

  Future<void> saveProfile(ProfileResponse profile) async {
    await SharedPreference.setValue(
      _profileKey,
      jsonEncode(profile.toJson()),
    );
  }

  Future<ProfileResponse?> getProfile() async {
    final value = await SharedPreference.getValue(_profileKey);

    if (value == null || value.isEmpty) return null;

    try {
      final json = jsonDecode(value);

      if (json is! Map<String, dynamic>) return null;

      return ProfileResponse.fromJson(json);
    } catch (_) {
      await clearProfile();
      return null;
    }
  }

  Future<void> clearProfile() async {
    await SharedPreference.remove(_profileKey);
  }
}