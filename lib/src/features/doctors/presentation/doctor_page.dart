import 'package:speech_to_text/speech_to_text.dart';

import '../../../provider/all_providers.dart';
import '../../../utils/packages.dart';
import '../../article/presentation/widget/category_selector.dart';
import 'widget/doctor_card.dart';

class DoctorPage extends ConsumerStatefulWidget {
  const DoctorPage({super.key});

  @override
  ConsumerState<DoctorPage> createState() => _DoctorPageState();
}

class _DoctorPageState extends ConsumerState<DoctorPage> {
  int selectedIndex = 0;
  bool isSearch = false;
  TextEditingController searchController = TextEditingController();
  String searchQuery = "";
  bool isRecording = false;
  List<String> selectedCategories = [];
  SpeechToText speechToText = SpeechToText();

  @override
  Widget build(BuildContext context) {
    final doctorListAsync = ref.watch(doctorListProvider);
    final categoryState = ref.watch(categoryProvider);

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
                isVoice: true,
                onVoiceResult: (spokenText) {
                  final words = spokenText
                      .toLowerCase()
                      .split(' ')
                      .where((w) => w.isNotEmpty)
                      .toSet()
                      .toList();

                  setState(() {
                    selectedCategories = words;
                    searchQuery = words.join(' ');
                    searchController.text = searchQuery;
                  });
                },
              ),
              if (isSearch)
                Row(
                  children: [
                    const SizedBox(width: 10),
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
                                  hintText: "Search Doctor",
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
                  ],
                ),
              smallSpace(),
              if (selectedCategories.isNotEmpty)
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: selectedCategories.map((cat) {
                    return Chip(
                      label: Text(cat),
                      deleteIcon: const Icon(Icons.close,
                          size: 20, color: Color(0xff059909)),
                      onDeleted: () {
                        setState(() {
                          selectedCategories.remove(cat);
                          searchQuery = selectedCategories.join(' ');
                          searchController.text = searchQuery;
                        });
                      },
                      backgroundColor: const Color(0xffD9FEAA),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    );
                  }).toList(),
                ),
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
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: InkWell(
                          onTap: () {
                            context.push(Routes.ENGAGEPAGE,
                                extra: "Engaged Doctors");
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            decoration: BoxDecoration(
                              color: Color(0xffFAFAFA),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                  color: Color(0xffB0B0B0), width: 0.5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "View Engaged Doctors",
                                    style: const TextStyle(
                                      color: Color(0xff737373),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Image.asset('assets/icon/arrowright.png')
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      tinySpace(),
                      doctorListAsync.when(
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                        error: (err, stack) =>
                            const Center(child: Text('Error loading')),
                        data: (doctors) {
                          if (doctors.isEmpty) {
                            return const Center(
                                child: Text("No doctors available"));
                          }

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
                                (doctor.healthCareProvider!.name
                                        ?.toLowerCase()
                                        .contains(searchQuery) ??
                                    false) ||
                                (doctor.workGrade
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
                                (doctor.lastName
                                        ?.toLowerCase()
                                        .contains(searchQuery) ??
                                    false);

                            return matchesCategory && matchesSearch;
                          }).toList();

                          if (filteredDoctors.isEmpty) {
                            return const Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 20),
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
                                imageUrl: doctor.profilePicture.toString(),
                                name:
                                    '${doctor.title}. ${doctor.firstName ?? ''} ${doctor.lastName ?? ''}',
                                type: doctor.userRoles!.last.roleSpecialist!
                                        .specialistName ??
                                    'Private Practitional',
                                profession:
                                    doctor.userRoles!.last.role!.name ?? '',
                                hospital: doctor.healthCareProvider!.name ?? '',
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
