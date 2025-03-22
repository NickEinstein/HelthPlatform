import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../routes/app_pages.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      context.pushReplacement(Routes.ONBOARDING);
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
            child: Image.asset('assets/images/splash.png'),
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
          )
        ],
      ),
    );
    // Widget build(BuildContext context) {
    //   return Scaffold(
    //     appBar: AppBar(title: const Text('My Page')),
    //     body: Column(
    //       children: [
    //         const Text('Splash screen'),
    //         ElevatedButton(onPressed: (){
    //           context.pushReplacement(Routes.SIGNIN);
    //         }, child:const Text("SignIn")),

    //         ElevatedButton(onPressed: (){
    //           context.goNamed(Routes.SIGNUP);
    //         }, child:const Text("SignUp")),
    //       ],
    //     ));
    // }
  }
}
