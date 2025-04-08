import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenzone_medical/src/app_pkg.dart';
import 'package:greenzone_medical/src/routes/routes.dart';

import '../../../provider/all_providers.dart';
import '../../../utils/custom_header.dart';
import '../../article/presentation/widget/category_selector.dart';
import 'widget/doctor_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DoctorPage extends ConsumerStatefulWidget {
  const DoctorPage({super.key});

  @override
  ConsumerState<DoctorPage> createState() => _DoctorPageState();
}

class _DoctorPageState extends ConsumerState<DoctorPage> {
  int selectedIndex = 0; // Track selected category index
  bool isSearch = false;
  TextEditingController searchController = TextEditingController();
  String searchQuery = "";
  @override
  Widget build(BuildContext context) {
    final doctorListAsync =
        ref.watch(doctorListProvider); // ✅ Watch doctor list
    final categoryState = ref.watch(categoryProvider); // ✅ Watch categories

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
                  Navigator.pop(context);
                },
                onSearchPressed: () {
                  setState(() {
                    isSearch = !isSearch;
                  });
                },
              ),
              if (isSearch)
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
                            Expanded(
                              child: TextField(
                                controller: searchController,
                                onChanged: (value) {
                                  setState(() {
                                    searchQuery = value.toLowerCase().trim();
                                  });
                                },
                                style: const TextStyle(color: Colors.black),
                                decoration: const InputDecoration(
                                  hintText: "Search Article",
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

              // ✅ Load and Display Categories
              categoryState.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => const Center(
                  child: Text("Failed to load categories"),
                ),
                data: (categoriesList) {
                  final List<String> categories = ["All"] +
                      ['Surgery'] +
                      categoriesList.map((e) => e.name).toList();

                  return Column(
                    children: [
                      // ✅ Category Selector
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

                      // ✅ Filter Doctors based on Selected Category
                      doctorListAsync.when(
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                        error: (err, stack) =>
                            Center(child: Text('Error: $err')),
                        data: (doctors) {
                          if (doctors.isEmpty) {
                            return const Center(
                                child: Text("No doctors available"));
                          }

                          // ✅ Filter Doctors Based on Selected Category
                          final filteredDoctors = doctors.where((doctor) {
                            final matchesCategory = selectedIndex == 0 ||
                                (doctor.department != null &&
                                    doctor.department!.trim().toLowerCase() ==
                                        categories[selectedIndex]
                                            .trim()
                                            .toLowerCase());

                            final matchesSearch = searchQuery.isEmpty ||
                                (doctor.department
                                        ?.toLowerCase()
                                        .contains(searchQuery) ??
                                    false) ||
                                (doctor.clinic
                                        ?.toLowerCase()
                                        .contains(searchQuery) ??
                                    false) ||
                                (doctor.designation
                                        ?.toLowerCase()
                                        .contains(searchQuery) ??
                                    false) ||
                                (doctor.email
                                        ?.toLowerCase()
                                        .contains(searchQuery) ??
                                    false) ||
                                (doctor.firstName
                                        ?.toLowerCase()
                                        .contains(searchQuery) ??
                                    false) ||
                                (doctor.role
                                        ?.toLowerCase()
                                        .contains(searchQuery) ??
                                    false) ||
                                (doctor.lastName
                                        ?.toLowerCase()
                                        .contains(searchQuery) ??
                                    false);

                            return matchesCategory && matchesSearch;
                          }).toList();

                          // ✅ Show message if no doctor found in the selected category
                          if (filteredDoctors.isEmpty) {
                            return Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: Text(
                                  "No doctors found for this category",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            );
                          }

                          return Column(
                            children: filteredDoctors.map((doctor) {
                              return DoctorCard(
                                imageUrl: (doctor.profilePicture != null &&
                                        doctor.profilePicture!
                                            .startsWith('http'))
                                    ? doctor
                                        .profilePicture! // ✅ Valid Network URL
                                    : 'assets/images/doctor1.png', // ✅ Default Asset if null/invalid
                                name:
                                    '${doctor.firstName ?? ''} ${doctor.lastName ?? ''}',
                                type: doctor.designation ?? '',
                                profession: doctor.department ?? '',
                                hospital: doctor.clinic ?? '',
                                rating: double.tryParse(
                                        doctor.rating?.toString() ?? '0.0') ??
                                    0.0,
                                reviews: doctor.reviews ?? 0,
                                isLiked: false,
                                isShowLove: false,
                                onPress: () {
                                  context.push(Routes.DOCTORLISTING,
                                      extra: doctor);
                                },
                              );
                            }).toList(),
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
