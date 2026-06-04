import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '../../bloc/signup/signup_bloc.dart';

class SignupButton extends StatelessWidget {
  const SignupButton({
    required this.state,
  });

  final SignupState state;

  @override
  Widget build(BuildContext context) {
    final isLoading = state.status.isInProgress;

    return SizedBox(
      height: 52,
      child: ElevatedButton(
        onPressed: isLoading
            ? null
            : () {
          context.read<SignupBloc>().add(
            const SignupSubmitted(),
          );
        },
        child: isLoading
            ? const SizedBox(
          height: 22,
          width: 22,
          child: CircularProgressIndicator(strokeWidth: 2),
        )
            : const Text('Sign Up'),
      ),
    );
  }
}