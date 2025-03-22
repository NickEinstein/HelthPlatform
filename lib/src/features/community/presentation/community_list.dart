import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenzone_medical/src/app_pkg.dart';
import 'package:greenzone_medical/src/routes/app_pages.dart';

import '../../../utils/custom_header.dart';
import '../../article/presentation/widget/category_selector.dart';
import 'widget/group_card.dart';

class CommunityList extends StatefulWidget {
  const CommunityList({super.key});

  @override
  State<CommunityList> createState() => _CommunityListState();
}

class _CommunityListState extends State<CommunityList> {
  int selectedIndex = 0; // Track selected category index

  final List<String> categories = [
    "All",
    "Fitness",
    "Wellness",
    "Nutrition",
    "Mental Health",
    "Men’s Health",
    "Women’s Health"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              verticalSpace(context, 0.08),
              CustomHeader(
                title: 'Community',
                onPressed: () {
                  // Handle back button press
                  Navigator.pop(context);
                },
                onSearchPressed: () {
                  context.push(Routes.SEARCHCOMMUNITY);
                  // Handle search button press
                },
              ),
              smallSpace(),
              CategorySelector(
                categories: categories,
                selectedIndex: selectedIndex,
                onCategorySelected: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
              ),
              const SizedBox(height: 16),
              GroupCard(
                imageUrl:
                    'assets/images/fitness1.png', // Replace with actual image URL
                title: 'Fitness & Wellness',
                subtitle: 'Public. 560 members. 6 posts a year',
                buttonText: 'Join',
                onButtonPressed: () {
                  print('I was press');
                  context.push(Routes.COMMUNITYDETAILS);
                  // Handle button click
                },
              ),
              smallSpace(),
              GroupCard(
                imageUrl:
                    'assets/images/fitness2.png', // Replace with actual image URL
                title: 'HealTogether',
                subtitle: 'Public. 560 members. 6 posts a year',
                buttonText: 'Join',
                onButtonPressed: () {
                  // Handle button click
                },
              ),
              smallSpace(),
              GroupCard(
                imageUrl:
                    'assets/images/fitness3.png', // Replace with actual image URL
                title: 'CuraNet',
                subtitle: 'Public. 560 members. 6 posts a year',
                buttonText: 'Join',
                onButtonPressed: () {
                  // Handle button click
                },
              ),
              smallSpace(),
            ],
          ),
        ),
      ),
    );
  }
}
