import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:greenzone_medical/src/utils/extensions/extensions.dart';
import 'package:greenzone_medical/src/utils/extensions/widget_extensions.dart';

final suspendedProductsProvider = Provider<List<String>>((ref) {
  return [
    'Abacavir Sulfate/Lamivudine Dispersible Tablets 60mg/30mg Tablets',
    'Amaryl M Tablets',
    'Amaryl M SR Tablets',
    'Aprovasc 150mg/5mg tablets',
    'Artemether/Lumefantrine 40mg/240mg Tablets',
    'ASAQ(Artesunate amodiaquine Winthrop) 100mg/270mg Tablets',
    'ASAQ(Artesunate amodiaquine Winthrop) 25mg/67.5mg Tablets',
    'ASAQ(Artesunate amodiaquine Winthrop) 50mg/135mg Tablets',
    'Betopic Eye drop',
    'Coaprovel 300mg/25mg Tablets',
  ];
});

class SuspendedProducts extends ConsumerWidget {
  static const routeName = '/suspended-products';
  const SuspendedProducts({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final suspendedDrugs = ref.watch(suspendedProductsProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: InkWell(
          onTap: () => context.pop(),
          child: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        centerTitle: true,
        title: Text(
          'Suspended & Canceled\nProducts',
          textAlign: TextAlign.center,
          style: context.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 18,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.height,
              // Search Bar
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search meds or article here',
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  suffixIcon:
                      const Icon(Icons.camera_alt_outlined, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                ),
              ),
              20.height,
              // Info Box
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F8E9), // Light green background
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: const Color(0xFF4CAF50)),
                ),
                child: Text(
                  'This is to inform the General Public that the following products are approved for withdrawal, suspension and cancellation by NAFDAC. They are therefore no longer permitted for manufacture, importation, exportation, distribution, advertisement, sale and use within Nigeria.',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: Colors.grey.shade800,
                    height: 1.5,
                  ),
                ),
              ),
              20.height,
              // List Header
              Text(
                'List of Drugs',
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                ),
              ),
              10.height,
              const Divider(),
              // Drug List
              Expanded(
                child: ListView.separated(
                  itemCount: suspendedDrugs.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              suspendedDrugs[index],
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ),
                          const Icon(Icons.chevron_right, color: Colors.grey),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
