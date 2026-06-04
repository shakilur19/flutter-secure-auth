import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../auth/presentation/login_screen.dart';
import '../../landing/presentation/landing_screen.dart';
import '../bloc/splash_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _animate = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) {
        setState(() {
          _animate = true;
        });
      }
    });

    context.read<SplashBloc>().add(CheckAuthStatus());
  }

  void _navigateTo(Widget screen) {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 600),
        pageBuilder: (_, animation, __) => screen,
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashAuthenticated) {
            _navigateTo(const LandingScreen());
          } else if (state is SplashUnauthenticated) {
            _navigateTo(const LoginScreen());
          }
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 900),
            opacity: _animate ? 1 : 0,
            curve: Curves.easeOut,
            child: AnimatedScale(
              duration: const Duration(milliseconds: 1200),
              scale: _animate ? 1.0 : 0.88,
              curve: Curves.easeOutBack,
              child: Image.asset(
                'assets/images/splash.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}