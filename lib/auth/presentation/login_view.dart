import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '../../utils/common_button.dart';
import '../../utils/common_font_style.dart';
import '../../utils/common_text_field.dart';
import '../../utils/const/app_route_const.dart';
import '../../utils/navigation/navigation_service.dart';
import '../bloc/login/login_bloc.dart';
import '../bloc/login/login_event.dart';
import '../bloc/login/login_state.dart';

class LoginView extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Authentication Failure')),
            );
        } else if (state.status.isSuccess) {
          NavigationService.navigateReplaced(AppRouteConst.landing);
        }
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 32),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CommonTextField(
                controller: _emailController,
                label: "Email",
                icon: const Icon(Icons.email),
                onChange: (text) {
                  context.read<LoginBloc>().add(
                      LoginEmailChanged(email: text));
                },
              ),
              const SizedBox(height: 24.0),
              CommonTextField(
                controller: _passwordController,
                label: "Password",
                icon: const Icon(Icons.lock),
                obscureText: true,
                onChange: (text) {
                  context.read<LoginBloc>().add(
                      LoginPasswordChanged(password: text));
                },
              ),
              const SizedBox(height: 24.0),
              CommonButton(
                buttonTitle: "Login",
                buttonAction: () {
                  context.read<LoginBloc>().add(const LoginSubmitted());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
