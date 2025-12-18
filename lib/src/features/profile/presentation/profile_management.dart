import 'package:greenzone_medical/src/features/profile/presentation/immunization_details.dart';
import 'package:greenzone_medical/src/features/profile/presentation/update_personal_info_screen.dart';
import 'package:greenzone_medical/src/provider/profile_provider.dart';
import 'package:greenzone_medical/src/resources/colors/colors.dart';
import 'package:greenzone_medical/src/utils/extensions/extensions.dart';
import 'package:greenzone_medical/src/utils/loading_widget.dart';
import 'package:greenzone_medical/src/utils/packages.dart';

class ProfileManagement extends ConsumerStatefulWidget {
  static const routeName = '/profile-management';
  const ProfileManagement({
    super.key,
  });

  @override
  ConsumerState<ProfileManagement> createState() => _ProfileManagementState();
}

class _ProfileManagementState extends ConsumerState<ProfileManagement> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(profileProvider.notifier).fetchAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profileProvider);
    final profile = state.patientProfile;
    final immunizations = state.immunizations;
    final allergies = state.userAllergies;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (context.padding.top + 16).height,
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
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
          12.height,
          if (state.isLoading && profile == null)
            const Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: ListLoader(
                  height: 80,
                ),
              ),
            )
          else
            Expanded(
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                children: [
                  Builder(builder: (context) {
                    bool isFirstCompleted =
                        ((profile?.data?.firstName?.isNotEmpty == true) &&
                                (profile?.data?.lastName?.isNotEmpty ==
                                    true)) ||
                            (profile?.data?.fullName?.isNotEmpty == true);
                    bool isSecondCompleted = profile?.data?.phoneNumber != null;
                    bool isThirdCompleted = profile?.data?.nin != null;
                    bool isFourthCompleted =
                        profile?.data?.dateOfBirth != null &&
                            profile?.data?.gender?.isNotEmpty == true &&
                            profile?.data?.nationality?.isNotEmpty == true;
                    List<String> fourthMissing = [
                      if (profile?.data?.dateOfBirth == null) 'Date of Birth',
                      if (profile?.data?.gender?.isNotEmpty != true) 'Gender',
                      if (profile?.data?.nationality?.isNotEmpty != true)
                        'Nationality',
                    ];
                    bool isFifthCompleted =
                        profile?.data?.stateOfOrigin?.isNotEmpty == true &&
                            profile?.data?.lga?.isNotEmpty == true &&
                            profile?.data?.placeOfBirth?.isNotEmpty == true;
                    List<String> fifthMissing = [
                      if (profile?.data?.stateOfOrigin?.isNotEmpty != true)
                        'State of Origin',
                      if (profile?.data?.lga?.isNotEmpty != true) 'LGA',
                      if (profile?.data?.placeOfBirth?.isNotEmpty != true)
                        'Place of Birth',
                    ];
                    bool isSixthCompleted = profile?.data?.weight != null &&
                        profile?.data?.patientRef?.isNotEmpty == true;

                    return Column(
                      children: [
                        _buildProfileItem(
                          icon: Icons.badge_outlined,
                          title: 'Personal Information',
                          subtitle: isFirstCompleted
                              ? 'Complete'
                              : 'Missing: First Name, Last Name',
                          isComplete: isFirstCompleted,
                        ),
                        _buildProfileItem(
                          icon: Icons.contact_page_outlined,
                          title: 'Contact',
                          subtitle: isSecondCompleted
                              ? 'Complete'
                              : 'Missing: Phone Number',
                          isComplete: isSecondCompleted,
                        ),
                        _buildProfileItem(
                          icon: Icons.perm_identity_outlined,
                          title: 'Identity',
                          subtitle: isThirdCompleted
                              ? 'Complete'
                              : 'Missing: National ID (NIN)',
                          isComplete: isThirdCompleted,
                        ),
                        _buildProfileItem(
                          icon: Icons.menu_book_outlined,
                          title: 'Demographics',
                          subtitle: isFourthCompleted
                              ? 'Complete'
                              : 'Missing: ${fourthMissing.join(", ")}',
                          isComplete: isFourthCompleted,
                        ),
                        _buildProfileItem(
                          icon: Icons.location_on_outlined,
                          title: 'Location',
                          subtitle: isFifthCompleted
                              ? 'Complete'
                              : 'Missing: ${fifthMissing.join(", ")}',
                          isComplete: isFifthCompleted,
                        ),
                        _buildProfileItem(
                          icon: Icons.medical_services_outlined,
                          title: 'Medical/Misc',
                          subtitle:
                              isSixthCompleted ? 'Complete' : 'Missing: Weight',
                          isComplete: isSixthCompleted,
                        ),
                      ],
                    );
                  }),
                  // Seventh - Immunization
                  _buildProfileItem(
                    route: ImmunizationDetailsScreen.routeName,
                    icon: Icons.vaccines_outlined,
                    title: 'Immunizations',
                    subtitle: (immunizations?.isNotEmpty == true)
                        ? 'Complete'
                        : 'Missing: Add at least one immunization record',
                    isComplete: immunizations?.isNotEmpty ?? false,
                    svgAsset: SvgAssets.immunization,
                  ),
                  // Eighth - Allergy
                  _buildProfileItem(
                    icon: Icons.vaccines_outlined,
                    title: 'Allergies',
                    subtitle: (allergies?.isNotEmpty == true)
                        ? 'Complete'
                        : 'Missing: Add at least one allergy record',
                    isComplete: allergies?.isNotEmpty ?? false,
                    svgAsset: SvgAssets.immunization,
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
    String? route,
    String? svgAsset,
  }) {
    final color = isComplete ? AppColors.primary : AppColors.greyTextColor;

    return InkWell(
      onTap: () {
        context.push(route ?? UpdatePersonalDetailsScreen.routeName);
      },
      child: Container(
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
      ),
    );
  }
}
