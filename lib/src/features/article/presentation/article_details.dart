import 'package:flutter/material.dart';
import 'package:greenzone_medical/src/app_pkg.dart';

import '../../../utils/custom_header.dart';

class ArticleDetails extends StatefulWidget {
  final String title;
  final String description;
  final String imageUrl;

  const ArticleDetails({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(context, 0.08),
              CustomHeader(
                title: 'Articles',
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              smallSpace(),
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(16), // Adjust radius as needed
                child: SizedBox(
                  width: double.infinity,
                  height: 250,
                  child: Image.asset(
                    widget.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              smallSpace(),
              Text(
                widget.title, // Use dynamic title
                style: const TextStyle(
                  color: Color(0xff3C3B3B),
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              tiny5Space(),
              Text(
                widget.description, // Use dynamic description
                style: const TextStyle(
                  height: 1.8,
                  color: Color(0xff595959),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              mediumSpace(),
            ],
          ),
        ),
      ),
    );
  }
}
