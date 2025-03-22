import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenzone_medical/src/app_pkg.dart';
import 'package:greenzone_medical/src/routes/routes.dart';

import '../../../utils/custom_header.dart';
import '../../article/presentation/widget/category_selector.dart';
import 'widget/doctor_card.dart';

class DoctorPage extends StatefulWidget {
  const DoctorPage({super.key});

  @override
  State<DoctorPage> createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {
  int selectedIndex = 0; // Track selected category index

  final List<String> categories = [
    "All",
    "General",
    "Dentist",
    "Neurologist",
    "Cardiologist",
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
                title: 'Doctors',
                onPressed: () {
                  // Handle back button press
                  Navigator.pop(context);
                },
                onSearchPressed: () {
                  // context.push(Routes.SEARCHCOMMUNITY);
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
              smallSpace(),
              DoctorCard(
                imageUrl: 'assets/images/doctor1.png',
                name: 'Rodrigo Hartman',
                type: 'Dental Scaling & Polishing',
                profession: 'Dentist',
                hospital: 'National Hospital ABUJA',
                rating: 4.8,
                reviews: 10,
                isLiked: true,
                onPress: () {
                  context.push(Routes.DOCTORLISTING);
                },
              ),
              tinySpace(),
              DoctorCard(
                imageUrl: 'assets/images/doctor2.png',
                name: 'Ember Wynn',
                type: 'Pediatric Neurology',
                profession: 'Pediatrician',
                hospital: 'National Hospital ABUJA',
                rating: 5.0,
                reviews: 20,
                isLiked: false,
                onPress: () {
                  context.push(Routes.DOCTORLISTING);
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
