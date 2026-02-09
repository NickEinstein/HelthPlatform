import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:greenzone_medical/src/features/ekiosk/data/model/drug_model.dart';
import 'package:greenzone_medical/src/features/ekiosk/presentation/pages/single_drug_detail.dart';
import 'package:greenzone_medical/src/features/ekiosk/presentation/provider/ekiosk_provider.dart';
import 'package:greenzone_medical/src/utils/extensions/extensions.dart';
import 'package:greenzone_medical/src/utils/extensions/string_extensions.dart';
import 'package:greenzone_medical/src/utils/extensions/widget_extensions.dart';

class DrugSearchResult extends ConsumerStatefulWidget {
  static const routeName = '/drug-search-result';
  const DrugSearchResult({super.key});

  @override
  ConsumerState<DrugSearchResult> createState() => _DrugSearchResultState();
}

class _DrugSearchResultState extends ConsumerState<DrugSearchResult> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ekioskState = ref.watch(ekioskStateProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () => context.pop(),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFB9F6CA), // Light green
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.arrow_back_ios_new,
                                size: 18, color: Colors.white),
                          ),
                        ),
                        Text(
                          'Drug Search Results',
                          style: context.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        26.width
                        // Stack(
                        //   clipBehavior: Clip.none,
                        //   children: [
                        //     Container(
                        //       padding: const EdgeInsets.all(8),
                        //       decoration: BoxDecoration(
                        //         color: const Color(0xFF109615), // Green
                        //         borderRadius: BorderRadius.circular(10),
                        //       ),
                        //       child: const Icon(Icons.shopping_cart_outlined,
                        //           size: 18, color: Colors.white),
                        //     ),
                        //     Positioned(
                        //       top: -5,
                        //       right: -5,
                        //       child: Container(
                        //         padding: const EdgeInsets.all(4),
                        //         decoration: const BoxDecoration(
                        //           color: Color(0xFFB9F6CA), // Light green badge
                        //           shape: BoxShape.circle,
                        //         ),
                        //         child: Text(
                        //           '3',
                        //           style: context.textTheme.labelSmall?.copyWith(
                        //             fontSize: 10,
                        //             fontWeight: FontWeight.bold,
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                    20.height,

                    // Search & Filter
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: 'Search for drugs',
                              hintStyle: const TextStyle(color: Colors.grey),
                              prefixIcon: InkWell(
                                  onTap: () {
                                    final searchText =
                                        _searchController.text.trim();
                                    if (searchText.isEmpty) return;
                                    ref
                                        .read(ekioskStateProvider.notifier)
                                        .search(searchText);
                                  },
                                  child: const Icon(Icons.search,
                                      color: Colors.grey)),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade300),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade300),
                              ),
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                            ),
                            onSubmitted: (value) {
                              final searchText = value.trim();
                              if (searchText.isEmpty) return;
                              ref
                                  .read(ekioskStateProvider.notifier)
                                  .search(searchText);
                            },
                          ),
                        ),
                        10.width,
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.filter_list,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    // 15.height,
                    // Row(
                    //   children: [
                    //     _buildFilterChip('Distance'),
                    //     10.width,
                    //     _buildFilterChip('Price'),
                    //   ],
                    // ),
                    20.height,
                    if (!ekioskState.isLoading &&
                        ekioskState.drugs.values.firstOrNull?.isEmpty == true &&
                        ekioskState.errorMessage == null)
                      const Center(
                        child: Text('No Results Found'),
                      ),
                    if (ekioskState.drugs.isNotEmpty && !ekioskState.isLoading)
                      ...List.generate(
                        ekioskState.drugs.entries
                            .where((e) => e.value.isNotEmpty)
                            .length,
                        (index) {
                          final value = ekioskState.drugs.entries
                              .where((e) => e.value.isNotEmpty)
                              .elementAt(index);
                          final length = value.value
                              .where((e) => e.name.isNotEmpty)
                              .length;
                          if (length == 0) return const SizedBox.shrink();
                          return _buildResultSection(
                            drugName: value.key.toTitleCase(),
                            resultCount: '$length Results',
                            cards: value.value
                                .where((e) => e.name.isNotEmpty)
                                .map(
                                  (drug) => _buildDrugCard(
                                    drug: drug,
                                    isSelected: false,
                                  ),
                                )
                                .toList(),
                          );
                        },
                      ),
                    if (ekioskState.errorMessage != null &&
                        !ekioskState.isLoading)
                      Center(
                        child: Text(
                          ekioskState.errorMessage!,
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    if (ekioskState.isLoading)
                      _buildResultSection(
                        drugName: '',
                        resultCount: '',
                        cards: List.generate(
                          3,
                          (_) => Container(
                            height: 100,
                            width: 400,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey.shade200,
                            ),
                          ),
                        ),
                      ).shimmer(),
                    // Result Section 1
                    // _buildResultSection(
                    //   drugName: 'Tetracycline Capsule',
                    //   resultCount: '1 of 10 Results',
                    //   cards: [
                    //     _buildPharmacyCard(
                    //       price: 'N1,150.00',
                    //       isSelected: true,
                    //       pharmacyName: 'MedPlus Pharmacies',
                    //       address: '9 Egbeyemi Street, Ilupeju, Lagos',
                    //       distance: '12km',
                    //       rating: 4.8,
                    //       reviews: 10,
                    //       deliveryAvailable: true,
                    //     ),
                    //     _buildPharmacyCard(
                    //       price: 'N1,200.00',
                    //       isSelected: false,
                    //       pharmacyName: 'MedPlus Pharmacies',
                    //       address: '9 Egbeyemi Street, Ilupeju, Lagos',
                    //       distance: '12km',
                    //       rating: 4.8,
                    //       reviews: 10,
                    //       deliveryAvailable: false,
                    //     ),
                    //   ],
                    // ),
                    // 20.height,

                    // // Result Section 2
                    // _buildResultSection(
                    //   drugName: 'Emzor Paracetamol 500mg',
                    //   resultCount: '1 of 25 Results',
                    //   cards: [
                    //     _buildPharmacyCard(
                    //       price: 'N750.00',
                    //       isSelected: true,
                    //       pharmacyName: 'MedPlus Pharmacies',
                    //       address: '9 Egbeyemi Street, Ilupeju, Lagos',
                    //       distance: '12km',
                    //       rating: 4.8,
                    //       reviews: 10,
                    //       deliveryAvailable: true,
                    //     ),
                    //     _buildPharmacyCard(
                    //       price: 'N915.00',
                    //       isSelected: false,
                    //       pharmacyName: 'MedPlus Pharmacies',
                    //       address: '9 Egbeyemi Street, Ilupeju, Lagos',
                    //       distance: '12km',
                    //       rating: 4.8,
                    //       reviews: 10,
                    //       deliveryAvailable: false,
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),

            // Bottom Actions
            // Container(
            //   padding: const EdgeInsets.all(20),
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     boxShadow: [
            //       BoxShadow(
            //         color: Colors.grey.withValues(alpha: 0.1),
            //         spreadRadius: 1,
            //         blurRadius: 10,
            //         offset: const Offset(0, -1),
            //       ),
            //     ],
            //   ),
            //   child: Column(
            //     children: [
            //       Row(
            //         children: [
            //           Checkbox(
            //             value: _subscribeForRefill,
            //             onChanged: (value) {
            //               setState(() {
            //                 _subscribeForRefill = value ?? false;
            //               });
            //             },
            //             activeColor: const Color(0xFF109615),
            //             shape: RoundedRectangleBorder(
            //               borderRadius: BorderRadius.circular(4),
            //             ),
            //           ),
            //           Text(
            //             'Subscribe for Refill',
            //             style: context.textTheme.bodyMedium?.copyWith(
            //               color: Colors.grey.shade700,
            //             ),
            //           ),
            //         ],
            //       ),
            //       10.height,
            //       SizedBox(
            //         width: double.infinity,
            //         child: ElevatedButton(
            //           onPressed: () {},
            //           style: ElevatedButton.styleFrom(
            //             backgroundColor: const Color(0xFF109615),
            //             padding: const EdgeInsets.symmetric(vertical: 15),
            //             shape: RoundedRectangleBorder(
            //               borderRadius: BorderRadius.circular(5),
            //             ),
            //           ),
            //           child: const Text(
            //             'Continue',
            //             style: TextStyle(
            //               color: Colors.white,
            //               fontWeight: FontWeight.bold,
            //             ),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  // Widget _buildFilterChip(String label) {
  //   return Container(
  //     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
  //     decoration: BoxDecoration(
  //       color: const Color(0xFFB9F6CA), // Light green
  //       borderRadius: BorderRadius.circular(20),
  //       border: Border.all(color: const Color(0xFF109615)),
  //     ),
  //     child: Row(
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         Text(
  //           label,
  //           style: context.textTheme.bodySmall?.copyWith(
  //             color: Colors.black,
  //             fontSize: 12,
  //           ),
  //         ),
  //         5.width,
  //         const Icon(Icons.close, size: 14, color: Colors.black),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildResultSection({
    required String drugName,
    required String resultCount,
    required List<Widget> cards,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF109615)),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                drugName,
                style: context.textTheme.bodySmall?.copyWith(
                  color: Colors.grey.shade700,
                  fontSize: 12,
                ),
              ),
            ),
            Text(
              resultCount,
              style: context.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        15.height,
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: cards
                .map((card) => Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: card,
                    ))
                .toList(),
          ),
        ),
        16.height,
      ],
    );
  }

  Widget _buildDrugCard({
    required bool isSelected,
    required DrugModel drug,
  }) {
    if (drug.name.isEmpty) return const SizedBox.shrink();
    return InkWell(
      onTap: () {
        context.push(SingleDrugDetail.routeName, extra: drug);
      },
      child: Container(
        width: 280,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.05),
              spreadRadius: 1,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (drug.name.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '₦ ${drug.cost}',
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFFB9F6CA)
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(15),
                      border: isSelected
                          ? Border.all(color: const Color(0xFF109615))
                          : null,
                    ),
                    child: Row(
                      children: [
                        Text(
                          isSelected ? 'Selected' : 'Select',
                          style: context.textTheme.bodySmall?.copyWith(
                            fontSize: 10,
                            color: isSelected
                                ? Colors.black
                                : Colors.grey.shade700,
                          ),
                        ),
                        if (isSelected) ...[
                          5.width,
                          const Icon(Icons.close,
                              size: 12, color: Colors.black),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            10.height,
            Text(
              drug.name.isEmpty ? drug.clinicName : drug.name,
              style: context.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            5.height,
            Row(
              children: [
                Expanded(
                  child: Text(
                    drug.clinicLocation,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade600,
                      fontSize: 11,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            5.height,
            Row(
              children: [
                ...List.generate(
                  drug.rating,
                  (index) => const Icon(
                    Icons.star,
                    size: 12,
                    color: Colors.amber,
                  ),
                ),
                ...List.generate(
                  5 - drug.rating,
                  (index) => const Icon(
                    Icons.star,
                    size: 12,
                    color: Colors.grey,
                  ),
                ),
                // 5.width,
                // Text(
                //   '${drug.}',
                //   style: context.textTheme.bodySmall?.copyWith(
                //     color: Colors.grey.shade600,
                //     fontSize: 10,
                //   ),
                // ),
              ],
            ),
            // if (drug.name.isNotEmpty) ...[
            //   18.height,
            //   Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Row(
            //         children: [
            //           _buildActionIcon(Icons.shopping_cart, filled: true),
            //           10.width,
            //           _buildActionIcon(Icons.chat_bubble_outline),
            //           10.width,
            //           _buildActionIcon(Icons.phone_outlined),
            //         ],
            //       ),
            //       // Placeholder for Logo
            //       const Icon(Icons.local_pharmacy,
            //           size: 30, color: Colors.pinkAccent),
            //     ],
            //   ),
            // ],
            15.height,
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text(
            //       deliveryAvailable
            //           ? 'Delivery available'
            //           : 'Delivery not available',
            //       style: context.textTheme.bodySmall?.copyWith(
            //         color: Colors.grey.shade500,
            //         fontSize: 10,
            //       ),
            //     ),
            //     if (deliveryAvailable)
            //       Text(
            //         'View Details',
            //         style: context.textTheme.bodySmall?.copyWith(
            //           color: Colors.grey.shade500,
            //           fontSize: 10,
            //         ),
            //       ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }

  // Widget _buildActionIcon(IconData icon, {bool filled = false}) {
  //   return Container(
  //     padding: const EdgeInsets.all(6),
  //     decoration: BoxDecoration(
  //       color: filled ? const Color(0xFF109615) : Colors.transparent,
  //       borderRadius: BorderRadius.circular(5),
  //       border: Border.all(
  //         color: const Color(0xFF109615),
  //       ),
  //     ),
  //     child: Icon(
  //       icon,
  //       size: 16,
  //       color: filled ? Colors.white : const Color(0xFF109615),
  //     ),
  //   );
  // }
}
