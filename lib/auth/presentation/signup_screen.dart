import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:login_template/utils/const/app_route_const.dart';
import 'package:login_template/utils/navigation/navigation_service.dart';
import '../bloc/signup/signup_bloc.dart';
import 'login_screen.dart';
import 'widgets/gender_dropdown.dart';
import 'widgets/signup_button.dart';
import 'widgets/signup_text_field.dart';


class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupBloc, SignupState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) async {
        if (state.status.isSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(
                  state.message.isNotEmpty
                      ? state.message
                      : 'Account created successfully',
                ),
                duration: const Duration(milliseconds: 1200),
              ),
            );

          await Future.delayed(const Duration(milliseconds: 1500));

          if (!context.mounted) return;

          NavigationService.navigateReplaced(AppRouteConst.login);
          return;
        }

        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(
                  state.message.isNotEmpty ? state.message : 'Signup failed',
                ),
              ),
            );
        }
      },
      child: const Scaffold(
        body: SafeArea(
          child: _SignupBody(),
        ),
      ),
    );
  }
}

class _SignupBody extends StatelessWidget {
  const _SignupBody();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: BlocBuilder<SignupBloc, SignupState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 32),
              const Text(
                'Create Account',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Sign up to continue',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 32),
              SignupTextField(
                label: 'First Name',
                textInputAction: TextInputAction.next,
                onChanged: (value) {
                  context.read<SignupBloc>().add(
                    SignupFirstNameChanged(value),
                  );
                },
              ),
              const SizedBox(height: 14),
              SignupTextField(
                label: 'Last Name',
                textInputAction: TextInputAction.next,
                onChanged: (value) {
                  context.read<SignupBloc>().add(
                    SignupLastNameChanged(value),
                  );
                },
              ),
              const SizedBox(height: 14),
              GenderDropdown(value: state.form.gender),
              const SizedBox(height: 14),
              SignupTextField(
                label: 'Email',
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                errorText: state.form.email.displayError != null
                    ? 'Enter a valid email'
                    : null,
                onChanged: (value) {
                  context.read<SignupBloc>().add(
                    SignupEmailChanged(value),
                  );
                },
              ),
              const SizedBox(height: 14),
              SignupTextField(
                label: 'Password',
                obscureText: true,
                textInputAction: TextInputAction.done,
                errorText: state.form.password.displayError != null
                    ? 'Password must contain uppercase, lowercase, number, special character and 8 characters'
                    : null,
                onChanged: (value) {
                  context.read<SignupBloc>().add(
                    SignupPasswordChanged(value),
                  );
                },
              ),
              const SizedBox(height: 24),
              SignupButton(state: state),
              const SizedBox(height: 16),
              _LoginButton(),
            ],
          );
        },
      ),
    );
  }
}


class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        NavigationService.navigateReplaced(AppRouteConst.login);
      },
      child: const Text('Already have an account? Login'),
    );
  }
}