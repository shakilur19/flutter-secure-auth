import 'package:flutter/material.dart';

import 'common_button.dart';
import 'common_color.dart';

class SomethingWentWrongPage extends StatelessWidget {
  final VoidCallback onRetry;

  const SomethingWentWrongPage({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [ CommonColor.bottomNavIconColor(),CommonColor.appBarColor()],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            // begin: Alignment.topLeft,
            // end: Alignment.bottomLeft,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated Error Icon
                Container(
                  height: 120,
                  width: 120,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 15,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.error_outline,
                      color: Colors.redAccent,
                      size: 80,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Title
                const Text(
                  "Oops!",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                // Subtitle
                const SizedBox(height: 10),
                const Text(
                  "Something went wrong. Please try again later.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                  ),
                ),

                const SizedBox(height: 30),

                // Retry Button
                CommonButton(
                  buttonTitle: "Retry",
                  buttonAction: onRetry,
                ),
                // ElevatedButton(
                //   onPressed: onRetry,
                //   style: ElevatedButton.styleFrom(
                //     padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                //     backgroundColor: Colors.white,
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(30),
                //     ),
                //     elevation: 8,
                //   ),
                //   child: const Text(
                //     "Retry",
                //     style: TextStyle(
                //       fontSize: 18,
                //       fontWeight: FontWeight.bold,
                //       color: Colors.deepPurple,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
