import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../utils/cache/cache.dart';
import '../../utils/const/shared_preference_constant.dart';
import '../../utils/network/api_client.dart';
import '../../utils/network/api_client_provider.dart';
import '../../utils/network/api_failure.dart';
import '../../utils/network/app_urls.dart';
import '../model/login_response.dart';

class AuthenticationRepository {

  final ApiClient _apiClient = ApiClientProvider().apiClient;

  AuthenticationRepository();

  Future<Either<APIFailure, dynamic>> login(Map<String, String> data) async {
    String path = AppUrls.getLoginUrl();
    final result = await _apiClient.invokeApi(
      path,
      data: data,
      HTTPType.post,
      isAuth: false,
    );
    try{
      store(result);
    } catch (e) {
      debugPrint(e.toString());
    }
    return result;
  }

  Future<Either<APIFailure, dynamic>> signup(Map<String, String> data) async {
    String path = AppUrls.getSignupUrl();

    final result = await _apiClient.invokeApi(
      path,
      data: data,
      HTTPType.post,
      isAuth: false,
    );

    return result;
  }

  Future<void> store(Either<APIFailure, dynamic> result) async {
    Cache cache = Cache();
    result.fold((failure) {
        debugPrint("failure");
      }, (data) async {
      debugPrint("......storing.......");
        await cache.forever(SharedPreferenceConstant.accessToken, LoginResponse.fromJson(data).accessToken?? "");
        await cache.forever(SharedPreferenceConstant.refreshToken, LoginResponse.fromJson(data).refreshToken?? "");
        return Future.value();
        },
    );
  }

  Future<bool> isUserLoggedIn() async {
    Cache cache = Cache();
    String? token = await cache.get(SharedPreferenceConstant.accessToken);
    print("==========${token}");
    return Future.value(token?.isNotEmpty?? false);
  }

}