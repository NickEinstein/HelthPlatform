import 'dart:async';
import '../../../provider/all_providers.dart';
import '../../../utils/packages.dart';
import 'caregivers_detail_page.dart';

class CaregiversPage extends ConsumerStatefulWidget {
  final String type;
  const CaregiversPage({super.key, required this.type});

  @override
  ConsumerState<CaregiversPage> createState() => _CaregiversPageState();
}

class _CaregiversPageState extends ConsumerState<CaregiversPage> {
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
                          _searchController.text = searchQuery;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    _tab(),
                    smallSpace(),
                    Row(children: [
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          onChanged: _onSearchChanged,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.search,
                                size: 25, color: Color(0xff999999)),
                            hintText: 'Search for ${widget.type}',
                            hintStyle:
                                const TextStyle(color: Color(0xff999999)),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 16),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Color(0xffE6E6E6)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Color(0xffE6E6E6)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(0xffE6E6E6), width: 2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      // if (widget.type.toLowerCase() != 'pharmacy' &&
                      //     widget.type.toLowerCase() != 'lab') ...[
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: _showFilterDialog,
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFF2F8F3),
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.all(10),
                          child: const Icon(Icons.filter_list, size: 20),
                        ),
                      ),
                    ]
                        // ],
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
                                _searchController.text = searchQuery;
                              });
                            },
                            backgroundColor: const Color(0xffD9FEAA),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          );
                        }).toList(),
                      ),
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
                              const Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: Color(0xFFE0E0E0)),
                              ListTile(
                                tileColor: Colors.white,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                leading: CircleAvatar(
                                  backgroundColor: Colors.grey.shade300,
                                  child: Text(
                                    name.isNotEmpty
                                        ? name[0].toUpperCase()
                                        : '?',
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ),
                                title: Text(name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff091F44))),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(location,
                                        style: const TextStyle(
                                            color: Color(0xff091F44))),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: List.generate(
                                        5,
                                        (index) => const Icon(Icons.star,
                                            size: 14, color: Colors.amber),
                                      ),
                                    ),
                                  ],
                                ),
                                trailing: const Icon(Icons.chevron_right,
                                    color: Color(0xff6C63FF)),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => CaregiverDetailsPage(
                                          caregiver: caregiver),
                                    ),
                                  );
                                },
                              ),
                              const Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: Color(0xFFE0E0E0)),
                            ],
                          ),
                        );
                      }),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
    );
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Filter by',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              ListTile(
                title: const Text('Fitness'),
                onTap: () {
                  Navigator.pop(context);
                  _applyFilter('fitness');
                },
              ),
              ListTile(
                title: const Text('Care'),
                onTap: () {
                  Navigator.pop(context);
                  _applyFilter('care');
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _applyFilter(String selectedType) {
    setState(() {
      selectedCategories = [selectedType.toLowerCase()];
      searchQuery = selectedType;
      _searchController.text = searchQuery;
    });
  }

  Widget _tab() {
    return Container(
      width: width(context),
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: const Color.fromRGBO(249, 249, 249, 1),
        border: Border.all(
          color: const Color.fromRGBO(175, 175, 175, 1),
          width: 0.5,
        ),
      ),
      child: Row(
        children: [
          // Left tab (selected or highlighted)
          if (widget.type == 'Pharmacy')
            InkWell(
              onTap: () {
                context.push(Routes.ENGAGEPAGE,
                    extra: "Engaged ${widget.type}");
              },
              child: Container(
                width: 177,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 255, 255, 1),
                  border: Border.all(
                    color: const Color.fromRGBO(175, 175, 175, 1),
                    width: 0.75,
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Engaged ${widget.type}',
                  style: const TextStyle(
                    color: Color.fromRGBO(114, 114, 114, 1),
                    fontFamily: 'Inter',
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    height: 1,
                  ),
                ),
              ),
            )
          else
            InkWell(
              onTap: () {
                context.push(Routes.ENGAGEPAGE,
                    extra: "Engaged ${widget.type}");
              },
              child: Container(
                width: 177,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 255, 255, 1),
                  border: Border.all(
                    color: const Color.fromRGBO(175, 175, 175, 1),
                    width: 0.75,
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Engaged ${widget.type}',
                  style: const TextStyle(
                    color: Color.fromRGBO(114, 114, 114, 1),
                    fontFamily: 'Inter',
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    height: 1,
                  ),
                ),
              ),
            ),

          // Right tab (unselected or normal)
          if (widget.type == 'Lab')
            Expanded(
              child: InkWell(
                onTap: () {
                  context.push(Routes.ENGAGEPAGE,
                      extra: "${widget.type} Request Log");
                },
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    '${widget.type} Request Log',
                    style: const TextStyle(
                      color: Color.fromRGBO(114, 114, 114, 1),
                      fontFamily: 'Inter',
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      height: 1,
                    ),
                  ),
                ),
              ),
            )
          else
            Expanded(
              child: InkWell(
                onTap: () {
                  if (widget.type == "Pharmacy") {
                    context.push(Routes.PRESCRIPTIONLOGPAGE);
                  } else {
                    context.push(Routes.ENGAGEPAGE,
                        extra: "${widget.type} Request Log");
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  child: const Text(
                    'Prescription Log',
                    style: TextStyle(
                      color: Color.fromRGBO(114, 114, 114, 1),
                      fontFamily: 'Inter',
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      height: 1,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
