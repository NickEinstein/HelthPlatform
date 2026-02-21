import 'package:greenzone_medical/src/utils/packages.dart';
import 'package:greenzone_medical/src/resources/colors/colors.dart';

class OutPatientLimitScreen extends StatelessWidget {
  const OutPatientLimitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Out-Patient Limit",
          style: TextStyle(
            color: Color(0xFF333333),
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: const BackButton(color: Color(0xFF333333)),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const Divider(color: Color(0xFFEEEEEE)),
            24.height,
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFEEEEEE)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "N1,000,000.00",
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  8.height,
                  const Text(
                    "Coverage Details",
                    style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  16.height,
                  _buildBulletPoint(
                      "Out Patient Care, General and Specialist Consultation"),
                  12.height,
                  _buildBulletPoint("X - Rays, Laboratory & Diagnostic Tests"),
                  12.height,
                  _buildBulletPoint(
                      "Primary Eye Care- Consultation , Examination, Simple or Primary infection or condition and Medications"),
                  12.height,
                  _buildBulletPoint("ENT Services"),
                  12.height,
                  _buildBulletPoint("Prescribed Medicines and Drugs"),
                  12.height,
                  _buildBulletPoint(
                      "Advanced & Complex Investigations (incl. CT Scan, MRI Scan)"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "•",
          style: TextStyle(
            color: Color(0xFF333333),
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        8.width,
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Color(0xFF333333),
              fontSize: 12,
              fontWeight: FontWeight.w400,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
