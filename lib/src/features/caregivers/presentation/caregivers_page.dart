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
  final List<Map<String, dynamic>> caregivers = [];

  bool isLoading = true;
  bool isFetchingMore = false;
  int currentPage = 1;
  final int pageSize = 8;
  bool hasMore = true;

  @override
  void initState() {
    super.initState();
    fetchCaregivers();
    _scrollController.addListener(_onScroll);
  }

  Future<void> fetchCaregivers() async {
    try {
      setState(() => isFetchingMore = true);
      final apiService = ApiService();
      final response = await apiService.get(ApiUrl.careGivers(currentPage, pageSize));

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
      debugPrint("❌ Error fetching caregivers: $e");
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

  Future<void> _refreshCaregivers() async {
    setState(() {
      currentPage = 1;
      caregivers.clear();
      hasMore = true;
      isLoading = true;
    });
    await fetchCaregivers();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _refreshCaregivers,
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
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.all(10),
                            child: const Icon(Icons.filter_list, size: 20),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      ...caregivers.map(
                        (caregiver) {
                          final name = caregiver['name']?.toString() ?? '';
                          final location = caregiver['location']?.toString() ?? 'No Location';

                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            elevation: 1,
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              leading: CircleAvatar(
                                backgroundColor: Colors.grey.shade300,
                                child: Text(
                                  name.isNotEmpty ? name[0].toUpperCase() : '?',
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ),
                              title: Text(
                                name,
                                style: const TextStyle(fontWeight: FontWeight.w600),
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
                        },
                      ),
                      if (isFetchingMore)
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
