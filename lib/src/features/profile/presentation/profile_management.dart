import 'package:greenzone_medical/src/resources/colors/colors.dart';
import 'package:greenzone_medical/src/utils/extensions/extensions.dart';
import 'package:greenzone_medical/src/utils/packages.dart';

class ProfileManagement extends ConsumerWidget {
  static const routeName = '/profile-management';
  const ProfileManagement({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back, color: Colors.black),
      //     onPressed: () => Navigator.of(context).pop(),
      //   ),
      //   title: Text(
      //     'Profile Management',
      //     style: CustomTextStyle.labelXLBold.copyWith(fontSize: 18),
      //   ),
      //   centerTitle: false,
      // ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (context.padding.top + 16).height,
          InkWell(
            onTap: context.pop,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Icon(Icons.arrow_back),
            ),
          ),
          8.height,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'Profile Management',
              style: CustomTextStyle.labelXLBold.copyWith(fontSize: 18),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              children: [
                _buildProfileItem(
                  icon: Icons.badge_outlined,
                  title: 'Personal Information',
                  subtitle: 'Missing: Profile picture',
                  isComplete: true,
                ),
                _buildProfileItem(
                  icon: Icons.contact_page_outlined,
                  title: 'Contact',
                  subtitle: 'Complete',
                  isComplete: true,
                ),
                _buildProfileItem(
                  icon: Icons.perm_identity_outlined,
                  title: 'Identity',
                  subtitle: 'Missing: National ID (NIN)',
                  isComplete: false,
                ),
                _buildProfileItem(
                  icon: Icons.menu_book_outlined,
                  title: 'Demographics',
                  subtitle: 'Complete',
                  isComplete: true,
                ),
                _buildProfileItem(
                  icon: Icons.location_on_outlined,
                  title: 'Location',
                  subtitle: 'Missing: LGA, Place of Birth',
                  isComplete: true,
                ),
                _buildProfileItem(
                  icon: Icons.medical_services_outlined,
                  title: 'Medical/Misc',
                  subtitle: 'Missing: Weight',
                  isComplete: true,
                ),
                _buildProfileItem(
                  icon: Icons.vaccines_outlined,
                  title: 'Immunizations',
                  subtitle: 'Missing: Add at least on immunization record',
                  isComplete: false,
                  svgAsset: SvgAssets.immunization,
                ),
                _buildProfileItem(
                  icon: Icons.back_hand_outlined,
                  title: 'Allergies',
                  subtitle: 'Missing: Add at least on immunization record',
                  isComplete: false,
                  svgAsset: SvgAssets.homeAllergy,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryLight,
                  foregroundColor: AppColors.primary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Text(
                  'View my Profile',
                  style: CustomTextStyle.labelMedium.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isComplete,
    String? svgAsset,
  }) {
    final color = isComplete ? AppColors.primary : AppColors.greyTextColor;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.bordersLight,
            width: 1,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            child: svgAsset != null
                ? SvgPicture.asset(
                    svgAsset,
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                  )
                : Icon(
                    icon,
                    color: color,
                    size: 24,
                  ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: CustomTextStyle.labelMedium.copyWith(
                    color: color,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: CustomTextStyle.paragraphSmall.copyWith(
                    color: AppColors.greyTextColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          if (isComplete)
            const Icon(
              Icons.check_circle_outline,
              color: AppColors.primary,
              size: 24,
            )
          else
            const Icon(
              Icons.radio_button_unchecked,
              color: AppColors
                  .greyPrimary, // Keep the circle grey even if text is grey
              size: 24,
            ),
        ],
      ),
    );
  }
}
