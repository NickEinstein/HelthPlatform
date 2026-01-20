import '../../../../model/all_alergy_response.dart';
import '../../../../provider/all_providers.dart';
import '../../../../utils/packages.dart';
import '../../model/health_record_model.dart';
import 'medical/immunization_medical.dart';

class TabStateNotifier extends StateNotifier<String> {
  TabStateNotifier() : super('Medical History');
  void updateTab(String tab) => state = tab;
}

final tabProvider = StateNotifierProvider<TabStateNotifier, String>(
  (ref) => TabStateNotifier(),
);

class MainHealthRecord extends ConsumerStatefulWidget {
  const MainHealthRecord({super.key});
  @override
  ConsumerState<MainHealthRecord> createState() => _MainHealthRecordState();
}

class _MainHealthRecordState extends ConsumerState<MainHealthRecord> {
  @override
  Widget build(BuildContext context) {
    final selectedTab = ref.watch(tabProvider);
    final userAsync = ref.watch(userProvider);
    final medicalRecordResponse = ref.watch(userFetchMedicalRecordProvider);
    final allergiesRecordResponse = ref.watch(userAllegiesListProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar:
          const CustomAppBar(title: 'Health Record', allowBackButton: false),
      drawer: const HomeDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 27),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(context, 0.15),
              userAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (_, __) =>
                    const Center(child: Text('Error loading health record')),
                data: (user) => buildRecordTile(
                  title: '${user.firstName ?? ''} ${user.lastName ?? ''}',
                  subtitle: 'Records',
                  icon: SvgAssets.medx,
                  isSvg: true,
                  isCircle: true,
                  isForwardIcon: false,
                  onTap: () {},
                ),
              ),
              mediumSpace(),
              _buildTabs(selectedTab),
              const Divider(thickness: 0.2, color: Colors.black),
              const SizedBox(height: 10),
              _buildTabContent(
                  selectedTab, medicalRecordResponse, allergiesRecordResponse),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabs(String selectedTab) {
    final tabs = ['Medical History', 'Allergies', 'Immunization'];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final tab in tabs) ...[
            smallHorSpace(),
            GestureDetector(
              onTap: () => ref.read(tabProvider.notifier).updateTab(tab),
              child: Text(
                tab,
                style: CustomTextStyle.textsmall15.copyWith(
                  fontWeight: FontWeight.w600,
                  color: selectedTab == tab
                      ? ColorConstant.primaryColor
                      : const Color(0xff667085),
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }

  Widget _buildTabContent(
    String selectedTab,
    AsyncValue<List<MedicalRecordResponse>> medicalRecordResponse,
    AsyncValue<List<UserAllegiesResponse>> allergiesRecordResponse,
  ) {
    switch (selectedTab) {
      case 'Medical History':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildRecordTile(
              title: 'Medical History',
              icon: SvgAssets.medx,
              isSvg: false,
              isSubtitle: false,
              isCircle: true,
              dropDown: true,
              onTap: () {},
            ),
            smallSpace(),
            _buildMedicalHistory(medicalRecordResponse),
          ],
        );

      case 'Allergies':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildRecordTile(
              title: 'Allergies',
              icon: SvgAssets.medx,
              isSvg: false,
              isSubtitle: false,
              isCircle: true,
              dropDown: true,
              onTap: () {},
            ),
            smallSpace(),
            _buildAllergies(allergiesRecordResponse),
          ],
        );

      case 'Immunization':
        return const ImmunizationMedical();

      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildMedicalHistory(AsyncValue<List<MedicalRecordResponse>> record) {
    return record.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => const Center(
          child: Text('Failed to load treatments',
              style: TextStyle(color: Colors.red))),
      data: (records) {
        if (records.isEmpty) {
          return const Center(
              child: Text('No Medical records available.',
                  style: TextStyle(color: Colors.grey)));
        }
        return ListView.separated(
          itemCount: records.length,
          separatorBuilder: (_, __) => smallSpace(),
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (_, i) => buildGrayRecordTile(
            title: records[i].diagnosis.isEmpty ? 'Unknown Diagnosis' : records[i].diagnosis,
            subtitle: formatNewDate(records[i].dateOfVisit.toIso8601String()),
            icon: 'assets/images/bocx.png',
            isSvg: true,
            isCircle: true,
            isColor: true,
            dropDown: true,
            onTap: () => context.push(Routes.NOTESPAGE, extra: records[i]),
          ),
        );
      },
    );
  }

  Widget _buildAllergies(AsyncValue<List<UserAllegiesResponse>> record) {
    return record.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => const Center(
          child: Text('Failed to load allergies.',
              style: TextStyle(color: Colors.red))),
      data: (records) {
        if (records.isEmpty) {
          return const Center(
              child: Text('No Allergies records available.',
                  style: TextStyle(color: Colors.grey)));
        }
        return ListView.separated(
          itemCount: records.length,
          separatorBuilder: (_, __) => smallSpace(),
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (_, i) => buildGrayRecordTile(
            title: records[i].allergicTo ?? 'Unknown Allergen',
            subtitle: 'Created At: ${formatNewDate(records[i].createdAt!)}',
            icon: 'assets/images/bocx.png',
            isSvg: true,
            isCircle: true,
            isColor: true,
            dropDown: false,
            onTap: () {},
          ),
        );
      },
    );
  }
}
