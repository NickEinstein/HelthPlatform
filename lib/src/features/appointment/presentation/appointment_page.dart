import 'package:flutter/material.dart';
import 'package:greenzone_medical/src/constants/dimens.dart';

class AppointmentPage extends StatelessWidget {
  const AppointmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            verticalSpace(context, 0.5),
            const Center(child: Text('Coming soon...'))
          ],
        ),
      ),
    );
  }
}
