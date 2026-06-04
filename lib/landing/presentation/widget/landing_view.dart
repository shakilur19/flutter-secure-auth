import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '../../../auth/presentation/login_screen.dart';
import '../../../utils/loading_view/loading_view.dart';
import '../../bloc/landing/bloc.dart';
import '../../bloc/landing/state.dart';
import 'body_view.dart';

class LandingView extends StatelessWidget {
  const LandingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LandingBloc, LandingState>(
      builder: (context, state) {
        if (!state.status.isSuccess) {
          // context.read<LandingBloc>().add(GetLandingNavigationEvent());
          return const LoadingView();
        } else {
          if (state.isUserLoggedIn) {
            return BodyView();
          } else {
            return const LoginScreen();
          }
        }
      },
    );
  }
}