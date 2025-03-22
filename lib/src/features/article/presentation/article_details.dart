import 'package:flutter/material.dart';
import 'package:greenzone_medical/src/app_pkg.dart';

import '../../../utils/custom_header.dart';

class ArticleDetails extends StatefulWidget {
  const ArticleDetails({super.key});

  @override
  State<ArticleDetails> createState() => _ArticleDetailsState();
}

class _ArticleDetailsState extends State<ArticleDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(context, 0.08),
              CustomHeader(
                title: 'Articles',
                onPressed: () {
                  // Handle back button press
                  Navigator.pop(context);
                },
              ),
              smallSpace(),
              Image.asset('assets/images/fitnessfull.png'),
              smallSpace(),
              Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Cardiology and workout?",
                        style: TextStyle(
                            color: Color(0xff3C3B3B),
                            fontSize: 16,
                            fontWeight: FontWeight.w700)),
                    tiny5Space(),
                    const Text(
                        "Everyone’s health journey is unique. Whether you’re looking to stay active, eat healthier, improve mental well-being, or build lasting habits, we’re here to support you. Let’s start by understanding your health goals!\nEveryone’s health journey is unique. Whether you’re looking to stay active, eat healthier, improve mental well-being, or build lasting habits, we’re here to support you. Let’s start by understanding your health goals!\nEveryone’s health journey is unique. Whether you’re looking to stay active, eat healthier, improve mental well-being, or build lasting habits, we’re here to support you. Let’s start by understanding your health goals!",
                        style: TextStyle(
                            height: 1.8,
                            color: Color(0xff595959),
                            fontSize: 12,
                            fontWeight: FontWeight.w400)),
                    mediumSpace(),
                  ])
            ],
          ),
        ),
      ),
    );
  }
}
