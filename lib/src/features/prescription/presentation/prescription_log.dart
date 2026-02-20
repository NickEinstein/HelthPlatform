import 'dart:async';
import 'package:greenzone_medical/src/features/prescription/models/get_prescriptions_model.dart';
import 'package:greenzone_medical/src/features/prescription/presentation/prescription_details.dart';
import 'package:greenzone_medical/src/features/prescription/providers/prescription_provider.dart';
import 'package:greenzone_medical/src/utils/custom_header.dart';
import 'package:greenzone_medical/src/utils/extensions/extensions.dart';

import '../../../utils/packages.dart' hide CustomHeader;

class PrescriptionLogPage extends ConsumerStatefulWidget {
  const PrescriptionLogPage({super.key});

  @override
  ConsumerState<PrescriptionLogPage> createState() =>
      _PrescriptionLogPageState();
}

class _PrescriptionLogPageState extends ConsumerState<PrescriptionLogPage> {
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
    final prescriptionLog = ref.watch(prescriptionLogProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: prescriptionLog.when(
        data: (data) {
          final data = [Prescription(), Prescription()];
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  (context.padding.top + 18).height,
                  CustomHeader(
                    title: 'Prescription Log',
                    onPressed: () => Navigator.pop(context),
                  ),
                  smallSpace(),
                  if (data.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 40),
                      child: Text('No prescription log found.'),
                    )
                  else
                    ...data.map(
                      (prescription) {
                        final name = prescription.diagnosis ??
                            'Prescription for persistent headache';
                        final location = prescription.clinic ??
                            '9 Egbeyemi Street, Ilupeju, Lagos';
                        final doctor = prescription.doctor ?? ' Ember Wynn';
                        final time = prescription.appointDate ?? '2026-02-20';
                        final clinic =
                            prescription.clinic ?? 'MedPlus Pharmacies';

                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 0),
                          elevation: 0,
                          color: Colors.white,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PrescriptionDetailsPage(
                                          prescription: prescription,
                                        )),
                              );
                            },
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: const Color(0xFFAEAEAE),
                                      width: .5,
                                    ),
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 8),
                                    titleAlignment: ListTileTitleAlignment.top,
                                    trailing: const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8.0),
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 16,
                                        color: Color(0xFFB3B3B3),
                                      ),
                                    ),
                                    title: Text(
                                      name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff091F44),
                                      ),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        12.height,
                                        Text(
                                          'Prescription by: Dr $doctor',
                                          style: context.textTheme.bodyMedium
                                              ?.copyWith(
                                            color: const Color(0xFF9A9A9A),
                                          ),
                                        ),
                                        4.height,
                                        Text(
                                          time,
                                          style: context.textTheme.bodyMedium
                                              ?.copyWith(
                                            color: const Color(0xFF9A9A9A),
                                          ),
                                        ),
                                        12.height,
                                        Text(
                                          clinic,
                                          style: context.textTheme.titleMedium,
                                        ),
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
                                                size: 14, color: Colors.amber),
                                          ),
                                        ),
                                        12.height,
                                        // Row(
                                        //   mainAxisAlignment: MainAxisAlignment.end,
                                        //   children: [
                                        //     SizedBox(
                                        //       height: 28,
                                        //       width: 28,
                                        //       child: ClipRRect(
                                        //         borderRadius:
                                        //             BorderRadiusGeometry.circular(
                                        //                 40),
                                        //         child: CachedNetworkImage(
                                        //           imageUrl: imageUrl,
                                        //           fit: BoxFit.cover,
                                        //         ),
                                        //       ),
                                        //     )
                                        //   ],
                                        // )
                                      ],
                                    ),
                                  ),
                                ),
                                tinySpace(),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
          );
        },
        error: (_, __) => const SizedBox.shrink(),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
