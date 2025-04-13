import 'dart:async';
import 'package:flutter/material.dart';
import 'package:greenzone_medical/src/constants/api_url.dart';
import 'package:greenzone_medical/src/features/caregivers/presentation/caregivers_detail_page.dart';
import 'package:greenzone_medical/src/services/api_service.dart';
import 'package:greenzone_medical/src/utils/custom_header.dart';

class CaregiversPage extends StatefulWidget {
  const CaregiversPage({super.key});

  @override
  State<CaregiversPage> createState() => _CaregiversPageState();
}

class _CaregiversPageState extends State<CaregiversPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, dynamic>> caregivers = [];

  bool isLoading = true;
  bool isFetchingMore = false;
  int currentPage = 1;
  final int pageSize = 8;
  bool hasMore = true;
  String searchText = '';
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    fetchCaregivers();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> fetchCaregivers() async {
    try {
      setState(() => isFetchingMore = true);

      final apiService = ApiService();
      final String url = searchText.isNotEmpty
          ? ApiUrl.careGiverSearch(currentPage, pageSize, searchText)
          : ApiUrl.careGivers(currentPage, pageSize);

      final response = await apiService.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['resultList'];

        setState(() {
          caregivers.addAll(data.cast<Map<String, dynamic>>());
          isLoading = false;
          isFetchingMore = false;
          hasMore = data.isNotEmpty;
        });
      } else {
        setState(() => isFetchingMore = false);
      }
    } catch (e) {
      debugPrint(" Error fetching caregivers: $e");
      setState(() => isFetchingMore = false);
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !isFetchingMore &&
        hasMore) {
      currentPage++;
      fetchCaregivers();
    }
  }

  Future<void> _refreshCaregivers({bool showLoading = true}) async {
    setState(() {
      currentPage = 1;
      caregivers.clear();
      hasMore = true;
      if (showLoading) isLoading = true;
    });
    await fetchCaregivers();
  }

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        searchText = value.trim();
        currentPage = 1;
        caregivers.clear();
        hasMore = true;
      });
      fetchCaregivers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () => _refreshCaregivers(),
              child: SingleChildScrollView(
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      const SizedBox(height: 60),
                      CustomHeader(
                        title: 'Caregivers',
                        onPressed: () => Navigator.pop(context),
                        onSearchPressed: () {},
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              onChanged: _onSearchChanged,
                              decoration: InputDecoration(
                                hintText: 'Search for caregivers',
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                filled: true,
                                fillColor: const Color(0xffF6F6F6),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFF2F8F3),
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.all(10),
                            child: const Icon(Icons.filter_list, size: 20),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      if (caregivers.isEmpty && !isFetchingMore)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 40),
                          child: Text('No caregivers found.'),
                        ),
                      ...caregivers.map((caregiver) {
                        final name = caregiver['name']?.toString() ?? '';
                        final location =
                            caregiver['location']?.toString() ?? 'No Location';

                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          elevation: 1,
                          child: ListTile(
                            tileColor: const Color(0xFFF2F8F3),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            leading: CircleAvatar(
                              backgroundColor: Colors.grey.shade300,
                              child: Text(
                                name.isNotEmpty ? name[0].toUpperCase() : '?',
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                            title: Text(
                              name,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(location),
                                const SizedBox(height: 4),
                                Row(
                                  children: List.generate(
                                    5,
                                    (index) => const Icon(
                                      Icons.star,
                                      size: 14,
                                      color: Colors.amber,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => CaregiverDetailsPage(
                                    caregiver: caregiver,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }),
                      if (isFetchingMore && caregivers.isNotEmpty)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: CircularProgressIndicator(),
                        ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
