import 'package:greenzone_medical/src/features/plan/presentation/single_plan_dashboard.dart';
import 'package:greenzone_medical/src/resources/colors/colors.dart';
import 'package:greenzone_medical/src/utils/packages.dart';

class StartPlanScreen extends ConsumerWidget {
  static const routeName = '/start-plan';
  const StartPlanScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Back Button
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                    constraints: const BoxConstraints(),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  ),
                ),
              ),
              20.height,
              // Icon
              const CircleAvatar(
                radius: 40,
                backgroundColor: AppColors.primaryLight,
                child: Icon(Icons.face, color: AppColors.primary, size: 40),
              ),
              10.height,
              // Title
              const Text(
                'Hair Care',
                style: CustomTextStyle.labelXLBold,
              ),
              4.height,
              Text(
                'Self-Care Plan',
                style: CustomTextStyle.paragraphSmall.copyWith(
                  color: AppColors.greyTextColor,
                ),
              ),
              20.height,
              // Installs Badge
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.primary),
                ),
                child: Text(
                  '333,209 Installs',
                  style: CustomTextStyle.labelMedium.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              30.height,
              // Description
              const Text(
                'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English.',
                style: CustomTextStyle.paragraphSmall,
                textAlign: TextAlign.justify,
              ),
              20.height,
              // Benefits Header
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Benefits:',
                  style: CustomTextStyle.labelMedium,
                ),
              ),
              10.height,
              // Benefits List
              _buildBenefitItem(
                '1. Personalized Haircare:',
                ' Built around their unique hair needs and goals.',
              ),
              8.height,
              _buildBenefitItem(
                '2. Consistency:',
                ' Encourages regular care routines through reminders and motivation.',
              ),
              8.height,
              _buildBenefitItem(
                '3. Education:',
                ' Empowers users to understand their hair, debunk myths, and make informed choices.',
              ),
              8.height,
              _buildBenefitItem(
                '4. Support System:',
                ' Combines solo routines with community-driven encouragement.',
              ),
              8.height,
              _buildBenefitItem(
                '5. Accountability:',
                ' Keeps users on track through visual progress and diary reflections.',
              ),
              40.height,
              // Start Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    context.push(SinglePlanDashboard.routeName);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryLight,
                    foregroundColor: AppColors.primaryBlack,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(color: AppColors.primary),
                    ),
                  ),
                  child: Text(
                    'Start your hair care plan',
                    style: CustomTextStyle.labelMedium.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBenefitItem(String title, String description) {
    return RichText(
      text: TextSpan(
        style: CustomTextStyle.paragraphSmall.copyWith(
          color: AppColors.primaryBlack,
          height: 1.5,
        ),
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: description,
            style: const TextStyle(),
          ),
        ],
      ),
    );
  }
}
