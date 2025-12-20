import 'package:greenzone_medical/src/features/pharmacy/presentation/drug_search_result.dart';
import 'package:greenzone_medical/src/utils/extensions/extensions.dart';
import 'package:greenzone_medical/src/utils/packages.dart';

class PharmacySearchScreen extends StatelessWidget {
  static const routeName = '/pharmacy-search';
  const PharmacySearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              height: 200,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF2E7D32), // Dark Green
                    Color(0xFF4CAF50), // Light Green
                  ],
                ),
              ),
              child: Stack(
                children: [
                  // Back Button
                  Positioned(
                    top: 20,
                    left: 20,
                    child: InkWell(
                      onTap: () => context.pop(),
                      child: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                  ),
                  // Text
                  Positioned(
                    top: 60,
                    left: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'C H P',
                          style: context.textTheme.labelSmall?.copyWith(
                            color: Colors.white,
                            letterSpacing: 2,
                          ),
                        ),
                        Text(
                          'PHARMACY',
                          style: context.textTheme.headlineMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // 3D Pills Image Placeholder
                  Positioned(
                    right: -20,
                    bottom: -20,
                    child: Opacity(
                      opacity: 0.8,
                      child: Icon(
                        Icons.medication,
                        size: 180,
                        color: Colors.white.withValues(alpha: 0.3),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    // Search Bar
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Search for any drugs',
                        hintStyle: const TextStyle(color: Colors.grey),
                        suffixIcon:
                            const Icon(Icons.search, color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                              color: Color(0xFF8BC34A)), // Light green border
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide:
                              const BorderSide(color: Color(0xFF8BC34A)),
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 15),
                      ),
                      onTap: () {
                        context.push(DrugSearchResult.routeName);
                      },
                    ),
                    20.height,

                    // Menu Options
                    _buildMenuOption(
                      context,
                      icon: Icons.upload_file,
                      title: 'Upload Prescription',
                      onTap: () => _showUploadPrescriptionBottomSheet(context),
                    ),
                    15.height,
                    _buildMenuOption(
                      context,
                      icon: Icons.medical_services_outlined,
                      title: 'Get a Prescription',
                      onTap: () {},
                    ),
                    15.height,
                    _buildMenuOption(
                      context,
                      icon: Icons.autorenew,
                      title: 'Subscribe to Refill Prescription',
                      onTap: () {},
                    ),
                    15.height,
                    _buildMenuOption(
                      context,
                      icon: Icons.person_add_alt_1_outlined,
                      title: 'Order for a family or friend',
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.grey.shade600, size: 20),
            ),
            15.width,
            Expanded(
              child: Text(
                title,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: Colors.grey.shade800,
                ),
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  void _showUploadPrescriptionBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Top Icon
              const Icon(Icons.track_changes,
                  size: 50, color: Color(0xFF4CAF50)),
              20.height,
              // Description
              Text(
                'Hey Jessica, upload your prescription so we can search for the closest pharmacy you can pick them up.',
                textAlign: TextAlign.center,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: Colors.grey.shade700,
                  height: 1.5,
                ),
              ),
              20.height,
              // Upload Area
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 30),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F8E9), // Light green background
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFF4CAF50)),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Color(0xFF109615),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.upload_file, color: Colors.white),
                    ),
                    10.height,
                    Text(
                      'Tap to upload prescription',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: const Color(0xFF4CAF50),
                      ),
                    ),
                  ],
                ),
              ),
              20.height,
              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle submission
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF109615),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: const Text(
                    'Submit Prescription',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              15.height,
              // Cancel Button
              TextButton(
                onPressed: () => context.pop(),
                child: Text(
                  'Cancel',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
                ),
              ),
              20.height,
            ],
          ),
        );
      },
    );
  }
}
