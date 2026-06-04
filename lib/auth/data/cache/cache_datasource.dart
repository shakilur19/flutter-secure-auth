import '../../../utils/common_model/token.dart';
import '../../../utils/common_model/user.dart';
import '../../../utils/core/result_future.dart';
import '../../../utils/core/resutl_void.dart';

abstract class CacheDatasource {
  Future<void> saveToken(Token token);
  Future<void> saveProfile(User user);
  ResultVoid savePinToken(Token token);
  Future<String?> getRefreshToken();
  Future<String> getAccessToken();
  ResultFuture<User> getUserProfile();
  void storeEmail(String email);
  ResultFuture<String> getLoggedInMobile();
}