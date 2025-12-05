import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greenzone_medical/src/features/plan/widgets/start_plan_screen.dart';
import 'package:greenzone_medical/src/resources/colors/colors.dart';
import 'package:greenzone_medical/src/utils/packages.dart';

class MyGoalsScreen extends ConsumerWidget {
  static const routeName = '/my-goals';
  const MyGoalsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Good morning!',
                        style: CustomTextStyle.labelXLBold,
                      ),
                      Text(
                        'Jessica Williams',
                        style: CustomTextStyle.paragraphSmall
                            .copyWith(color: AppColors.greyTextColor),
                      ),
                    ],
                  ),
                  const Icon(Icons.menu),
                ],
              ),
              20.height,
              // Search Bar
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search for an app',
                  prefixIcon:
                      const Icon(Icons.search, color: AppColors.greyTextColor),
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.camera_alt_outlined,
                          color: AppColors.greyTextColor),
                      10.width,
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: AppColors.primaryLight,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.mic, color: AppColors.primary),
                      ),
                      8.width,
                    ],
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: AppColors.bordersLight),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: AppColors.bordersLight),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
              ),
              20.height,
              // Hair Care Section
              const Text(
                'Hair Care Self-Care App',
                style: CustomTextStyle.labelMedium,
              ),
              10.height,
              SizedBox(
                height: 225.h,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildGoalCard(context,
                        title: 'Hair Care', icon: Icons.face, rating: 4.5),
                    _buildGoalCard(context,
                        title: 'Skin Care', icon: Icons.spa, rating: 4.0),
                    _buildGoalCard(context,
                        title: 'Personal Hygiene',
                        icon: Icons.clean_hands,
                        rating: 4.8),
                  ],
                ),
              ),
              20.height,
              // Hospital List
              _buildHospitalItem(),
              _buildHospitalItem(),
              _buildHospitalItem(),
              20.height,
              // Ad Banner
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Stack(
                  children: [
                    // In a real app, use an Image.asset or Image.network here
                    Positioned.fill(
                        child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [Colors.grey[400]!, Colors.grey[300]!])),
                    )),
                    Positioned(
                      bottom: 20,
                      left: 20,
                      child: Text(
                        'This is\nAn Advert',
                        style: CustomTextStyle.labelXLBold
                            .copyWith(color: Colors.white, fontSize: 24),
                      ),
                    )
                  ],
                ),
              ),
              20.height,
              // Skin Care Section
              const Text(
                'Skin Care Self-Care App',
                style: CustomTextStyle.labelMedium,
              ),
              10.height,
              SizedBox(
                height: 225.h,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildGoalCard(context,
                        title: 'Hair Care', icon: Icons.face, rating: 4.5),
                    _buildGoalCard(context,
                        title: 'Skin Care', icon: Icons.spa, rating: 4.0),
                    _buildGoalCard(
                      context,
                      title: 'Personal Hygiene',
                      icon: Icons.clean_hands,
                      rating: 4.8,
                    ),
                  ],
                ),
              ),
              20.height,
              _buildHospitalItem(),
              _buildHospitalItem(),
              _buildHospitalItem(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGoalCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required double rating,
  }) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 15, bottom: 5),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.bordersLight),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: AppColors.primaryLight,
            child: Icon(icon, color: AppColors.primary, size: 30),
          ),
          10.height,
          Text(title,
              style: CustomTextStyle.labelSmall, textAlign: TextAlign.center),
          4.height,
          Text('Self-Care Plan',
              style: CustomTextStyle.paragraphTiny
                  .copyWith(color: AppColors.greyTextColor)),
          4.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
                5,
                (index) => Icon(
                      index < rating.floor() ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 14,
                    )),
          ),
          12.height,
          InkWell(
            onTap: () {
              context.push(StartPlanScreen.routeName);
            },
            // height: 32,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0xFF109615),
                ),
              ),
              alignment: Alignment.center,
              child: const Text(
                'Start Now',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHospitalItem() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.bordersLight),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: AppColors.primaryLight,
            child: const Icon(Icons.local_hospital, color: AppColors.primary),
          ),
          12.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('National Hospital Abuja',
                    style: CustomTextStyle.labelSmall),
                2.height,
                Text('Hospital',
                    style: CustomTextStyle.paragraphTiny
                        .copyWith(color: AppColors.greyTextColor)),
                2.height,
                Row(
                  children: List.generate(
                      5,
                      (index) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 12,
                          )),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              minimumSize: const Size(60, 30),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            ),
            child: const Text('Start', style: TextStyle(fontSize: 12)),
          )
        ],
      ),
    );
  }
}
