import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_template/auth/bloc/signup/signup_bloc.dart';
import '../../auth/bloc/login/login_bloc.dart';
import '../../auth/data/authentication_repository.dart';
import '../../landing/bloc/bottom_nav/bottom_nav_bloc.dart';
import '../../landing/bloc/landing/bloc.dart';
import '../../landing/data/landing_repository.dart';
import '../../profile/bloc/profile_bloc.dart';
import '../../profile/data/repository/profile_repository.dart';
import '../../splash/bloc/splash_bloc.dart';
import '../../splash/domain/check_auth_usecase.dart';

class BlocProviders {
  static List<BlocProvider> getProviders() {
    return [
      BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(
          authenticationRepository: AuthenticationRepository(),
        ),
      ),
      BlocProvider<SignupBloc>(
        create: (context) => SignupBloc(
          authenticationRepository: AuthenticationRepository(),
        ),
      ),
      BlocProvider<BottomNavigationBloc>(
        create: (context) => BottomNavigationBloc(),
      ),
      BlocProvider<ProfileBloc>(
        create: (context) => ProfileBloc(
          repository: ProfileRepository(),
        ),
      ),
      BlocProvider<LandingBloc>(
        create: (context) => LandingBloc(
          repository: LandingRepository(),
        ),
      ),
      BlocProvider<SplashBloc>(create: (context) => SplashBloc(
          CheckAuthUseCase(AuthenticationRepository()))
      )
    ];
  }
}
