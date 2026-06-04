import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'splash/presentation/splash_screen.dart';
import 'utils/navigation/app_route.dart';
import 'utils/navigation/navigation_service.dart';
import 'utils/network/api_client_provider.dart';
import 'utils/providers/bloc_providers.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final apiClientProvider = ApiClientProvider();
    apiClientProvider.dioClient.setClient();
    return MultiBlocProvider(
      providers: BlocProviders.getProviders(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRoute.generateRoute,
        navigatorKey: NavigationService.navigatorKey,
        title: 'Flutter Login with BLoC',
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.white,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black, // Text and icon color
            elevation: 0, // Flat app bar
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: Colors.blue, // Button text color
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue, // Button color
              foregroundColor: Colors.white, // Text color
              minimumSize: const Size(double.infinity, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          textTheme: const TextTheme(
            bodyLarge: TextStyle(color: Colors.black),
            bodyMedium: TextStyle(color: Colors.black54),
          ),
        ),
        // home: const LandingScreen(),
        home: SplashScreen(),
      ),
    );
  }
}
