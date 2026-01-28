import 'package:greenzone_medical/src/features/hmo/models/hmo_model.dart';
import 'package:greenzone_medical/src/features/hmo/presentation/provider/hmo_provider.dart';
import 'package:greenzone_medical/src/resources/colors/colors.dart';
import 'package:greenzone_medical/src/utils/extensions/extensions.dart';
import 'package:greenzone_medical/src/utils/extensions/primary_button.dart';
import 'package:greenzone_medical/src/utils/packages.dart';
import '../../../../provider/all_providers.dart';
import '../../../../model/user_model.dart';

class HMOScreen extends ConsumerStatefulWidget {
  const HMOScreen({super.key});

  @override
  ConsumerState<HMOScreen> createState() => _HMOScreenState();
}

class _HMOScreenState extends ConsumerState<HMOScreen> {
  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(userProvider);
    final hmoAsync = ref.watch(userHMOsProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "HMO/Health Finance",
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
      body: userAsync.when(
        data: (user) => hmoAsync.when(
            data: (hmo) {
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    20.height,
                    // Profile Section
                    _buildProfileHeader(user),
                    18.height,
                 
                    if (hmo.isEmpty) ...[
                      20.height,
                      Text(
                        'You are not yet connected to an HMO',
                        style: context.textTheme.titleMedium,
                      ),
                      8.height,
                      Text(
                        'Visit any ConnectHealth Pro hospital to register and link your HMO for seamless healthcare coverage',
                        style: context.textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                      28.height,
                      AppButton(
                        onPressed: () {
                          context.push(Routes.CAREGIVERSPAGE,
                              extra: 'Hospital');
                        },
                        textColor: Colors.white,
                        child: const Text('View Hospitals'),
                      ),
                    ],
                    if (hmo.isNotEmpty)
                      ...List.generate(
                          hmo.length, (index) => _buildHMOItem(hmo[index])),
                  ],
                ),
              );
            },
            error: (_, __) =>
                const Center(child: Text("Error loading user HMO")),
            loading: () => const Center(child: CircularProgressIndicator())),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) =>
            const Center(child: Text("Error loading user profile")),
      ),
    );
  }

  Widget _buildHMOItem(HmoModel hmo) {
    return Column(
      children: [
        // Plan Info
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: hmo.vendorName,
                style: const TextStyle(
                  color: AppColors.primary,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              // TextSpan(
              //   text: hmo.,
              //   style: TextStyle(
              //     color: Color(0xFF333333),
              //     fontSize: 14,
              //     fontWeight: FontWeight.w400,
              //   ),
              // ),
            ],
          ),
        ),
        // 8.height,
        // const Text(
        //   "N2,478,080.00  |  End Date: December 31, 2025",
        //   style: TextStyle(
        //     color: Color(0xFF8C8C8C),
        //     fontSize: 10,
        //     fontWeight: FontWeight.w400,
        //   ),
        // ),
        18.height,
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFDDFFAC),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.primary),
          ),
          child: const Text(
            "Account Active",
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        40.height,

        // Limits List
        _buildLimitItem("RC Number", hmo.rcNumber),
        _buildLimitItem("Phone Number", hmo.phoneNumber),
        _buildLimitItem("Contact Person", hmo.contactPerson),
        _buildLimitItem("Tax Identity Number", hmo.taxIdentityNumber),
        _buildLimitItem("Packages", hmo.packages.toString()),
        // _buildLimitItem("Pre-Existing / Chronic Conditions Service"),
        // _buildLimitItem("Dental", "N2,478,080.00"),
        // _buildLimitItem("Optical", "N2,478,080.00"),
        // _buildLimitItem(
        //     "Otolaryngological\n(Ear, Nose and Throat)", "N2,478,080.00"),
        // _buildLimitItem("Wellbeing", "N2,478,080.00", false),
        24.height,
      ],
    );
  }

  Widget _buildProfileHeader(UserData user) {
    final imageUrl = user.pictureUrl?.contains('https') == true
        ? user.pictureUrl!
        : user.pictureUrl?.contains('/UploadedFiles') == true
            ? '${AppConstants.noSlashImageURL}${user.pictureUrl!}'
            : '${AppConstants.noSlashImageURL}/${user.pictureUrl ?? ""}';
    final initials = '${user.firstName?[0] ?? ""}${user.lastName?[0] ?? ""}';

    return Column(
      children: [
        ClipOval(
          child: Image.network(
            imageUrl,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => CircleAvatar(
              radius: 40,
              backgroundColor: getAvatarColor(user.firstName! + user.lastName!),
              child: Text(initials,
                  style: const TextStyle(color: Colors.white, fontSize: 24)),
            ),
          ),
        ),
        12.height,
        Text(
          "${user.firstName} ${user.lastName}",
          style: const TextStyle(
            color: Color(0xFF333333),
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        4.height,
        Text(
          user.email ?? "",
          style: const TextStyle(
            color: Color(0xFFAAAAAA),
            fontSize: 10,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildLimitItem(String title,
      [String? value, bool showDivider = true]) {
    return InkWell(
      onTap: () {
        if (title == "Out-Patient Limit") {
          context.push(Routes.OUT_PATIENT_LIMIT);
        }
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFF616060),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                if (value != null) ...[
                  Text(
                    value,
                    style: const TextStyle(
                      color: Color(0xFFCCCCCC),
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  8.width,
                ],
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: Color(0xFF666666),
                ),
              ],
            ),
          ),
          if (showDivider) const Divider(height: 1, color: Color(0xFFEEEEEE)),
        ],
      ),
    );
  }
}
