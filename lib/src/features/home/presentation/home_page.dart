import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenzone_medical/src/constants/color_constant.dart';

import '../../../constants/dimens.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/custom_toast.dart';
import '../../article/presentation/article_section.dart';
import 'health_goal_section.dart';
import 'search_bar.dart';
import 'widget/action_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false, // Removes back button
        centerTitle: false, // Aligns title to the left
        title: RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: "Good morning! ",
                style: TextStyle(
                  color: Color(0xff0D0D0D),
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextSpan(
                text: "Jessica Williams",
                style: TextStyle(
                  color: Colors.black, // Change this to any color you want
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                    child:
                        CustomSearchBar()), // ✅ Expands to take available space
                const SizedBox(
                    width: 10), // ✅ Adds space between search and icons
                InkWell(
                  onTap: () {
                    CustomToast.show(context, "Coming soon...",
                        type: ToastType.error);
                  },
                  child: Image.asset(
                    'assets/images/notification.png',
                    height: 32,
                    width: 25,
                  ),
                ),
                const SizedBox(width: 10),
                InkWell(
                  onTap: () {
                    CustomToast.show(context, "Coming soon...",
                        type: ToastType.error);
                  },
                  child: Image.asset(
                    'assets/images/message.png',
                    height: 32,
                    width: 25,
                  ),
                ),
                // Shopping Cart Icon
              ],
            ),
            SizedBox(height: 20),
            // const HealthGoalsSection(),
            HealthGoalsPager(
              goals: [
                HealthGoalModel(
                  title: "Health Goals !!",
                  description: "Tell us more about your Health Goals",
                  backgroundColor: ColorConstant.primaryColor,
                  onTap: () {
                    context.push(Routes.HEALTHGOAL);
                  },
                  buttonText: "See Details",
                  imagePath: "assets/images/health_goals.png",
                ),
                HealthGoalModel(
                  title: "Community",
                  description: "Have you taken your medicine yet?",
                  backgroundColor: Color(0xff633717),
                  buttonText: "Join a community",
                  onTap: () {
                    // Your action
                    context.push(Routes.COMMUNITYPAGE);
                  },
                  imagePath: "assets/images/health_goals.png",
                ),
              ],
            ),

            mediumSpace(),

            const ActionButtonsRow(),
            const SizedBox(height: 20),
            const ArticlesSection(),
          ],
        ),
      ),
      // bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
