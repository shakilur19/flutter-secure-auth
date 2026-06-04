
import '../../auth/data/authentication_repository.dart';

class LandingRepository {
  late AuthenticationRepository? authenticationRepository;

  LandingRepository(){
    authenticationRepository = AuthenticationRepository();
  }

  Future<bool> isUserLoggedIn() async{
    return Future.value(await authenticationRepository?.isUserLoggedIn());
  }

}