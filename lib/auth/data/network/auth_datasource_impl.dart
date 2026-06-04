import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../utils/cache/cache.dart';
import '../../../utils/common_model/token.dart';
import '../../../utils/common_model/user.dart';
import '../../../utils/const/shared_preference_constant.dart';
import '../../../utils/core/result_future.dart';
import '../../../utils/core/resutl_void.dart';
import '../../../utils/network/api_failure.dart';
import '../cache/cache_datasource.dart';
import 'auth_datasource.dart';


class AuthCacheDataSourceImpl extends CacheDatasource implements AuthCacheDataSource {
  final Cache cache;
  AuthCacheDataSourceImpl(this.cache);

  @override
  Future<void> saveToken(Token token) async {
    await cache.forever(
      SharedPreferenceConstant.accessToken,
      token.accessToken!,
    );
    await cache.forever(
      SharedPreferenceConstant.refreshToken,
      token.refreshToken!,
    );
    debugPrint(
        "access ${await cache.get(SharedPreferenceConstant.accessToken)}");
    debugPrint(
        "refresh ${await cache.get(SharedPreferenceConstant.refreshToken)}");
  }

  @override
  Future<void> saveProfile(User user) async {
    await cache.forever(
      (SharedPreferenceConstant.userProfile),
      jsonEncode(user),
    );
  }

  @override
  ResultVoid savePinToken(Token token) async {
    try {
      await cache.put(
        SharedPreferenceConstant.accessToken,
        token.accessToken!,
        const Duration(seconds: 300),
      );
      await cache.put(
        SharedPreferenceConstant.refreshToken,
        token.refreshToken!,
        const Duration(seconds: 300),
      );
      return right(null);
    } on Exception catch (e) {
      return left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<String?> getRefreshToken() async {
    if (await cache.get(SharedPreferenceConstant.refreshToken) != null) {
      debugPrint("refresh token from cache ${await cache.get(SharedPreferenceConstant.refreshToken)}");
      return await cache.get(SharedPreferenceConstant.refreshToken);
    }
    return null;
  }

  @override
  Future<String> getAccessToken() async {
    if (await cache.get(SharedPreferenceConstant.accessToken) != null) {
      return await cache.get(SharedPreferenceConstant.accessToken) ?? "";
    }
    return "";
  }

  @override
  ResultFuture<User> getUserProfile() async {
    var userData = await cache.get(SharedPreferenceConstant.userProfile);
    if (userData == null || userData.isEmpty) {
      return const Left(CacheFailure(message: "Failure"));
    }
    return Right(User.fromJson(jsonDecode(userData)));
  }

  @override
  void storeEmail(String mobile) async {
    await cache.forever(SharedPreferenceConstant.loggedInMobile, mobile);
  }

  @override
  ResultFuture<String> getLoggedInMobile() async {
    if (await cache.get(SharedPreferenceConstant.loggedInMobile) != null) {
      return right(
          await cache.get(SharedPreferenceConstant.loggedInMobile) ?? "");
    }
    return left(const CacheFailure(message: "No Email found"));
  }
}