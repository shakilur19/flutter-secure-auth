import 'package:dartz/dartz.dart';

import '../../../utils/network/api_client.dart';
import '../../../utils/network/api_client_provider.dart';
import '../../../utils/network/api_failure.dart';
import '../../../utils/network/app_urls.dart';
import '../cache/profile_cache_datasource.dart';
import '../model/profile_response.dart';

class ProfileRepository {
  ProfileRepository({
    ApiClient? apiClient,
    ProfileCacheDataSource? profileCacheDataSource,
  })  : apiClient = apiClient ?? ApiClientProvider().apiClient,
        profileCacheDataSource =
            profileCacheDataSource ?? ProfileCacheDataSource();

  final ApiClient apiClient;
  final ProfileCacheDataSource profileCacheDataSource;

  Future<Either<APIFailure, ProfileResponse>> getProfile() async {
    final cachedProfile = await profileCacheDataSource.getProfile();

    if (cachedProfile != null) {
      _refreshProfileCache();
      return Right(cachedProfile);
    }

    return fetchProfile();
  }

  Future<Either<APIFailure, ProfileResponse>> fetchProfile() async {
    final result = await apiClient.invokeApi(
      AppUrls.getProfile(),
      HTTPType.get,
      isAuth: true,
    );

    return result.fold(
          (failure) => Left(failure),
          (data) async {
        final profile = ProfileResponse.fromJson(data);
        await profileCacheDataSource.saveProfile(profile);
        return Right(profile);
      },
    );
  }

  Future<void> _refreshProfileCache() async {
    await fetchProfile();
  }

  Future<Either<APIFailure, dynamic>> updateProfile(
      Map<String, String> data,
      ) async {
    final result = await apiClient.invokeApi(
      AppUrls.updateProfile(),
      HTTPType.put,
      data: data,
      isAuth: true,
    );

    return result.fold(
          (failure) => Left(failure),
          (data) async {
        final profile = ProfileResponse.fromJson(data);
        await profileCacheDataSource.saveProfile(profile);
        return Right(data);
      },
    );
  }

  Future<Either<APIFailure, dynamic>> deleteProfile() async {
    final result = await apiClient.invokeApi(
      AppUrls.deleteProfile(),
      HTTPType.delete,
      isAuth: true,
    );

    return result.fold(
          (failure) => Left(failure),
          (data) async {
        await profileCacheDataSource.clearProfile();
        return Right(data);
      },
    );
  }
}