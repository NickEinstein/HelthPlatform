import 'package:greenzone_medical/src/features/plan/presentation/single_plan_dashboard.dart';
import 'package:greenzone_medical/src/model/regular_app_model.dart';
import 'package:greenzone_medical/src/provider/my_goal_provider.dart';
import 'package:greenzone_medical/src/resources/colors/colors.dart';
import 'package:greenzone_medical/src/utils/extensions/extensions.dart';
import 'package:greenzone_medical/src/utils/packages.dart';

class StartPlanScreen extends ConsumerStatefulWidget {
  static const routeName = '/start-plan';
  final RegularAppModel app;
  const StartPlanScreen({super.key, required this.app});

  @override
  ConsumerState<StartPlanScreen> createState() => _StartPlanScreenState();
}

class _StartPlanScreenState extends ConsumerState<StartPlanScreen> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getPlanExists();
  }

  getPlanExists() async {
    final myAppPlans = await ref.read(myGoalServiceProvider).getMyApps();
    final isMyApp = myAppPlans
        .where((element) => element.appId == widget.app.id)
        .isNotEmpty;
    if (isMyApp && mounted) {
      context.pushReplacement(
        SinglePlanDashboard.routeName,
        extra: widget.app,
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: isLoading
              ? Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: IconButton(
                          icon:
                              const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () => Navigator.of(context).pop(),
                          constraints: const BoxConstraints(),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                        ),
                      ),
                    ),
                    (context.screenHeight * .4).height,
                    const Center(child: CircularProgressIndicator()),
                  ],
                )
              : Column(
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
                          icon:
                              const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () => Navigator.of(context).pop(),
                          constraints: const BoxConstraints(),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                        ),
                      ),
                    ),
                    20.height,
                    // Icon
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF109615)),
                        shape: BoxShape.circle,
                      ),
                      child: const CircleAvatar(
                        radius: 40,
                        backgroundColor: AppColors.primaryLight,
                        child: Icon(Icons.more,
                            color: Color(0xFF109615), size: 40),
                      ),
                    ),
                    10.height,
                    // Title
                    Text(
                      widget.app.title,
                      style: CustomTextStyle.labelXLBold,
                    ),
                    4.height,
                    Text(
                      widget.app.category,
                      style: CustomTextStyle.paragraphSmall.copyWith(
                        color: AppColors.greyTextColor,
                      ),
                    ),
                    20.height,
                    // Installs Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFF109615)),
                      ),
                      child: Text(
                        '${widget.app.installs?.isNotEmpty == true ? widget.app.installs : 0} Installs',
                        style: CustomTextStyle.labelMedium.copyWith(
                          color: const Color(0xFF109615),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    30.height,
                    // Description
                    Text(
                      widget.app.description,
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
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.app.benefits,
                        style: CustomTextStyle.paragraphSmall.copyWith(
                          color: AppColors.primaryBlack,
                          height: 1.5,
                        ),
                      ),
                    ),
                    40.height,
                    // Start Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          context.push(
                            SinglePlanDashboard.routeName,
                            extra: widget.app,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryLight,
                          foregroundColor: AppColors.primaryBlack,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: const BorderSide(color: Color(0xFF109615)),
                          ),
                        ),
                        child: Text(
                          'Start ${widget.app.title}',
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
}
