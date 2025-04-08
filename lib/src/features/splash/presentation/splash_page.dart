import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../di.dart';
import '../../../routes/app_pages.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    final authService =
        ref.read(authServiceProvider); // Get AuthService instance
    final isLoggedIn = await authService.isUserLoggedIn(); // Check login status

    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;

      if (isLoggedIn) {
        context.pushReplacement(Routes.SIGNIN);
      } else {
        context.pushReplacement(Routes.ONBOARDING);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(color: Color(0xff109815)),
            child: Image.asset(
              'assets/images/splash.png',
              fit: BoxFit.cover, // Ensures the image fills the screen
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logomed.png',
                      height: 111,
                      width: 179,
                    ),
                    const Padding(padding: EdgeInsets.only(top: 10.0)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
