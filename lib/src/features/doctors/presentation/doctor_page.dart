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
                                type: doctor.workGrade ?? '',
                                profession: doctor.department ?? '',
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
