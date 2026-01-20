import 'package:greenzone_medical/src/features/account/model/track_feedback_response.dart';
import 'package:greenzone_medical/src/utils/extensions/date_extensions.dart';
import 'package:greenzone_medical/src/utils/extensions/extensions.dart';
import 'package:greenzone_medical/src/utils/packages.dart';
import 'package:greenzone_medical/src/resources/colors/colors.dart';

class TrackFeedbackScreen extends StatelessWidget {
  final TrackFeedbackResponse trackFeedbackResponse;
  const TrackFeedbackScreen({super.key, required this.trackFeedbackResponse});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const BackButton(color: Color(0xFF333333)),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              "Track Feedback",
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  12.height,
                  const Text(
                    "Enter your tracking ID to check\nthe status of your feedback",
                    style: TextStyle(
                      color: Color(0xFF666666),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  14.height,
                  const Divider(color: Color(0xFFE3E3E3), thickness: 4),
                  14.height,
                  // Feedback Details Badge
                  _buildBadge(
                    "Feedback Details",
                    trackFeedbackResponse.data?.trackingId,
                    AppColors.primary,
                  ),
                  16.height,

                  // Type Badge
                  _buildBadge("Type", trackFeedbackResponse.data?.type,
                      AppColors.primary),
                  16.height,

                  // Status Badge
                  _buildBadge("Status", trackFeedbackResponse.data?.status,
                      AppColors.primary),
                  16.height,

                  // Location Badge
                  _buildBadge("Location", trackFeedbackResponse.data?.location,
                      AppColors.primary),
                  16.height,

                  // Contact Email Badge
                  _buildBadge(
                      "Contact Email",
                      trackFeedbackResponse.data?.contactEmail,
                      AppColors.primary),
                  16.height,

                  // Created At Badge
                  _buildBadge(
                    "Created At",
                    DateTime.tryParse(
                            trackFeedbackResponse.data?.createdAt ?? "")
                        ?.formatDateTimePretty,
                    AppColors.primary,
                  ),
                  16.height,

                  // Action Taken Badge
                  _buildBadge(
                    "Action Taken: Record Created",
                    null,
                    const Color(0xFF65D556),
                    isActionTaken: true,
                  ),
                  40.height,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(
    String label,
    String? value,
    Color color, {
    bool isActionTaken = false,
  }) {
    if (isActionTaken) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFEAFFEA),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: color,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      );
    }

    return Container(
      width: double.infinity,
      // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.only(bottom: 16),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFFE3E3E3)),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF29BA2E),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          if (value != null) ...[
            8.height,
            Text(
              value,
              style: const TextStyle(
                color: Color(0xFF444444),
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
