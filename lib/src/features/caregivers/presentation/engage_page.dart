import 'dart:async';
import 'package:greenzone_medical/src/features/lab/presentation/pages/lab_prescription_log.dart';

import '../../../provider/all_providers.dart';
import '../../../utils/packages.dart';
import 'caregivers_detail_page.dart';

class EngagePage extends ConsumerStatefulWidget {
  final String type;
  const EngagePage({super.key, required this.type});

  @override
  ConsumerState<EngagePage> createState() => _EngagePageState();
}

class _EngagePageState extends ConsumerState<EngagePage> {
  final TextEditingController _searchController = TextEditingController();
  String searchText = '';
  Timer? _debounce;
  bool isSearch = false;
  String searchQuery = '';
  List<String> selectedCategories = [];

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  // ignore: unused_element
  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      setState(() {
        searchQuery = value.toLowerCase();
        selectedCategories = searchQuery
            .split(' ')
            .where((e) => e.trim().isNotEmpty)
            .toSet()
            .toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final careGiverResponse = ref.watch(userAllHealthCareProvider);

    final caregivers = careGiverResponse.when(
      data: (data) {
        final lowerType = widget.type.toLowerCase();

        return data.where((caregiver) {
          final name = caregiver.name?.toLowerCase() ?? '';

          // Match based on voice/search chips
          if (selectedCategories.isNotEmpty) {
            final matchesCategory =
                selectedCategories.any((term) => name.contains(term));
            if (!matchesCategory) return false;
          }

          // Match based on type
          if (lowerType.contains('pharmacy')) {
            return name.contains('pharmacy');
          } else if (lowerType.contains('lab')) {
            return name.contains('lab');
          } else if (lowerType.contains('hospital')) {
            return name.contains('hospital') ||
                name.contains('diagnosis') ||
                name.contains('diagno');
          } else if (lowerType.contains('diagnosis') ||
              lowerType.contains('diag')) {
            return name.contains('diagnosis') || name.contains('diagno');
          } else {
            // For 'caregiver' or anything else, exclude institutions
            return !(name.contains('pharmacy') ||
                name.contains('lab') ||
                name.contains('hospital') ||
                name.contains('clinic') ||
                name.contains('diagnosis') ||
                name.contains('diagno'));
          }
        }).toList();
      },
      loading: () => null,
      error: (_, __) => null,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: careGiverResponse.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    const SizedBox(height: 60),
                    CustomHeader(
                      title: widget.type,
                      onPressed: () => Navigator.pop(context),
                    ),
                    smallSpace(),
                    if (caregivers == null)
                      const Center(child: CircularProgressIndicator())
                    else if (caregivers.isEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        child: Text('No ${widget.type} found.'),
                      )
                    else
                      ...caregivers.map((caregiver) {
                        final name = caregiver.name.toString();
                        final location = caregiver.location.toString();

                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 0),
                          elevation: 0,
                          color: Colors.white,
                          child: Column(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(color: Colors.green, width: 1),
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                child: Stack(
                                  children: [
                                    // Vertical Line that spans full height
                                    Positioned(
                                      left:
                                          62, // Width of CircleAvatar (40) + padding (8) + a bit extra
                                      top: 0,
                                      bottom: 0,
                                      child: Container(
                                        width: 1.5,
                                        color: Colors.green,
                                      ),
                                    ),
                                    ListTile(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 8),
                                      leading: SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: CircleAvatar(
                                          backgroundColor: Colors.grey.shade300,
                                          child: Text(
                                            name.isNotEmpty
                                                ? name[0].toUpperCase()
                                                : '?',
                                            style: const TextStyle(
                                                color: Colors.black),
                                          ),
                                        ),
                                      ),
                                      title: Text(
                                        name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff091F44),
                                        ),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            location,
                                            style: const TextStyle(
                                                color: Color(0xff091F44)),
                                          ),
                                          const SizedBox(height: 4),
                                          Row(
                                            children: List.generate(
                                              5,
                                              (index) => const Icon(Icons.star,
                                                  size: 14,
                                                  color: Colors.amber),
                                            ),
                                          ),
                                        ],
                                      ),
                                      onTap: () {
                                        if (widget.type
                                                .split(' ')
                                                .firstOrNull
                                                ?.toLowerCase() ==
                                            'lab') {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) =>
                                                  const LabPrescriptionLogPage(),
                                            ),
                                          );
                                          return;
                                        }
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) =>
                                                CaregiverDetailsPage(
                                                    caregiver: caregiver),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              tinySpace(),
                            ],
                          ),
                        );
                      }),
                  ],
                ),
              ),
            ),
    );
  }
}
