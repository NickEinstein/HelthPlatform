import 'package:greenzone_medical/src/features/account/model/account_activity_model.dart';
import 'package:greenzone_medical/src/utils/extensions/date_extensions.dart';
import 'package:greenzone_medical/src/utils/extensions/extensions.dart';
import 'package:greenzone_medical/src/utils/loading_widget.dart';
import 'package:greenzone_medical/src/utils/packages.dart';
import 'package:greenzone_medical/src/resources/colors/colors.dart';

class AccountActivityPage extends ConsumerStatefulWidget {
  const AccountActivityPage({super.key});

  @override
  ConsumerState<AccountActivityPage> createState() =>
      _AccountActivityPageState();
}

class _AccountActivityPageState extends ConsumerState<AccountActivityPage> {
  bool isLoading = true;
  List<AccountActivityModel> accountActivityList = [];

  getAccountActivity() async {
    try {
      isLoading = true;
      final res = await ref.read(authServiceProvider).getAccountActivity();
      accountActivityList = res.reversed.toList();
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      if (mounted) {
        context.showFeedBackDialog(message: e.toString());
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getAccountActivity();
  }

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
      body: RefreshIndicator(
        onRefresh: () async {
          await getAccountActivity();
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 20.height,
              const Text(
                "Account Activity",
                style: TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              8.height,
              const Text(
                "View your account activity history",
                style: TextStyle(
                  color: Color(0xFF666666),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              24.height,

              // Statistics Cards
              IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        context,
                        value: accountActivityList.length.toString(),
                        label: "Total Activities",
                      ).shimmer(isLoading: isLoading),
                    ),
                    12.width,
                    Expanded(
                      child: _buildStatCard(
                        context,
                        value: accountActivityList.length.toString(),
                        label: "Auth Events",
                      ).shimmer(isLoading: isLoading),
                    ),
                    12.width,
                    Expanded(
                      child: _buildStatCard(
                        context,
                        value: "0",
                        label: "API Calls",
                      ).shimmer(isLoading: isLoading),
                    ),
                    12.width,
                    Expanded(
                      child: _buildStatCard(
                        context,
                        icon: Icons.calendar_today,
                        value: DateTime.tryParse(accountActivityList
                                        .firstOrNull?.timeCreated ??
                                    '')
                                ?.formatDateTimePretty??
                            "23 Nov 2025\n03:48:11",
                        label: "",
                        isDate: true,
                      ).shimmer(isLoading: isLoading),
                    ),
                  ],
                ),
              ),
              32.height,

              // Activity Log Header
              const Text(
                "Activity Log",
                style: TextStyle(
                  color: ColorConstant.primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              16.height,

              if (isLoading)
                const ListLoader(
                  height: 80,
                  itemCount: 4,
                ),
              // Activity List
              if (accountActivityList.isEmpty && !isLoading) ...[
                18.height,
                Center(
                  child: Text(
                    "No Activity Found",
                    style: context.textTheme.bodyLarge
                        ?.copyWith(color: AppColors.greyTextColor2),
                  ),
                )
              ],

              if (accountActivityList.isNotEmpty && !isLoading)
                Column(
                  children: _buildActivityList(accountActivityList),
                ),
              40.height,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    IconData? icon,
    required String value,
    required String label,
    bool isDate = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFEAFFEA),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.primary),
      ),
      // alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(icon, color: AppColors.primary, size: 24),
            8.height,
          ],
          Text(
            value,
            style: icon == null
                ? context.textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.w700)
                : TextStyle(
                    color: AppColors.primary,
                    fontSize: isDate ? 10 : 16,
                    fontWeight: FontWeight.w700,
                  ),
            textAlign: TextAlign.center,
          ),
          if (label.isNotEmpty) ...[
            4.height,
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFF666666),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }

  List<Widget> _buildActivityList(List<AccountActivityModel> accountActivityList) {
    final activities = List.generate(
      accountActivityList.length,
      (index) => _buildActivityItem(
        accountActivityList[index]
        // "Authentication",
        // "Patient logged into the system",
        // "23 Nov 2025, 20:48:11",
      ),
    );
    return activities;
  }

  Widget _buildActivityItem(AccountActivityModel accountActivity) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            accountActivity.module,
            style: const TextStyle(
              color: Color(0xFF333333),
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          8.height,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Activity: ",
                style: TextStyle(
                  color: ColorConstant.primaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Expanded(
                child: Text(
                  accountActivity.message,
                  style: const TextStyle(
                    color: Color(0xED646464),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          8.height,
          Row(
            children: [
              const Icon(Icons.access_time, size: 14, color: Color(0xFF999999)),
              4.width,
              Text(
                DateTime.tryParse(accountActivity.timeCreated)?.formatDateTimePretty?? '',
                style: const TextStyle(
                  color: Color(0xFF999999),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
