import 'package:flutter/material.dart';
import '../../utils/const/app_route_const.dart';
import '../../utils/navigation/navigation_service.dart';
import 'login_view.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        actions: [
          TextButton(
            onPressed: () {
              NavigationService.navigateReplaced(AppRouteConst.signup);
            },
            child: const Text("Sign Up"),
          ),
        ],
      ),
      body: LoginView(),
    );
  }
}