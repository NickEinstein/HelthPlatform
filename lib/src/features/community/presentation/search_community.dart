import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenzone_medical/src/app_pkg.dart';

import '../../../routes/app_pages.dart';
import '../../../utils/custom_header.dart';
import '../../article/presentation/widget/category_selector.dart';
import 'widget/search_card.dart';

class SearchCommunity extends StatefulWidget {
  const SearchCommunity({super.key});

  @override
  State<SearchCommunity> createState() => _SearchCommunityState();
}

class _SearchCommunityState extends State<SearchCommunity> {
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
              ),
              tinySpace(),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xffE6E6E6)),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/search.png',
                            height: 32,
                            width: 25,
                          ),
                          const SizedBox(width: 8),
                          const Expanded(
                            child: TextField(
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                hintText: "Search Group Name",
                                hintStyle: TextStyle(
                                    color: Color(0xff999999),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Image.asset(
                    'assets/icon/filter_icon.png',
                    height: 52,
                    width: 35,
                  ),
                ],
              ),
              smallSpace(),
              SearchCard(
                imageUrl:
                    'assets/images/fitness1.png', // Replace with actual image URL
                title: 'Fitness & Wellness',
                subtitle: '130+ new post',
                onButtonPressed: () {
                  context.push(Routes.COMMUNITYDETAILS);
                  // Handle button click
                },
              ),
              smallSpace(),
              SearchCard(
                imageUrl:
                    'assets/images/fitness1.png', // Replace with actual image URL
                title: 'Fitness & Wellness',
                subtitle: '130+ new post',
                onButtonPressed: () {
                  context.push(Routes.COMMUNITYDETAILS);
                  // Handle button click
                },
              ),
              smallSpace(),
              SearchCard(
                imageUrl:
                    'assets/images/fitness1.png', // Replace with actual image URL
                title: 'Fitness & Wellness',
                subtitle: '130+ new post',
                onButtonPressed: () {
                  context.push(Routes.COMMUNITYDETAILS);
                  // Handle button click
                },
              ),
              smallSpace(),
              SearchCard(
                imageUrl:
                    'assets/images/fitness1.png', // Replace with actual image URL
                title: 'Fitness & Wellness',
                subtitle: '130+ new post',
                onButtonPressed: () {
                  context.push(Routes.COMMUNITYDETAILS);
                  // Handle button click
                },
              ),
              const SizedBox(height: 16),
              smallSpace(),
            ],
          ),
        ),
      ),
    );
  }
}
