import 'package:formz/formz.dart';

class LandingState {

  final bool isUserLoggedIn;
  final FormzSubmissionStatus status;
  LandingState({
    this.status = FormzSubmissionStatus.initial,
    this.isUserLoggedIn = false,
  });

  LandingState clone({
    bool? isUserLoggedIn,
    FormzSubmissionStatus? status,
  }) {
    return LandingState(
      isUserLoggedIn: isUserLoggedIn?? this.isUserLoggedIn,
      status: status?? this.status,
    );
  }
}
