import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:greenzone_medical/src/model/my_app_model.dart';
import 'package:greenzone_medical/src/provider/my_goal_provider.dart';
import 'package:greenzone_medical/src/utils/extensions/extensions.dart';
import 'package:greenzone_medical/src/utils/extensions/string_extensions.dart';
import 'package:greenzone_medical/src/utils/extensions/widget_extensions.dart';

class PlanTabDashboard extends ConsumerStatefulWidget {
  final int appId;
  const PlanTabDashboard({super.key, required this.appId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PlanTabDashboardState();
}

class _PlanTabDashboardState extends ConsumerState<PlanTabDashboard> {
  @override
  Widget build(BuildContext context) {
    final myApps = ref.watch(
      goalNotifierProvider.select((s) => s.myApps),
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: myApps?.when(
        data: (data) {
          final app = data
              .where((element) => element.appId == widget.appId)
              .firstOrNull;

          return Column(
            children: [
              // Top Green Progress Card
              _buildProgressCard(app),
              20.height,
              // Statistics Grid
              _buildStatisticsGrid(app),
            ],
          );
        },
        loading: () => Container(
          height: 400,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), color: Colors.white),
        ).shimmer(),
        error: (error, stackTrace) => Center(child: Text(error.toString())),
      ),
    );
  }

  Widget _buildProgressCard(MyAppModel? app) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        // gradient: const LinearGradient(
        //   colors: [Color(0xFF00A651), Color(0xFF00C853)],
        //   begin: Alignment.topLeft,
        //   end: Alignment.bottomRight,
        // ),
        color: const Color(0xFF059909),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    30.height,
                    Align(
                      alignment: Alignment.centerRight,
                      child: SvgPicture.asset('stars'.toSvg),
                    ),
                    50.height,
                    Text(
                      app?.planDashboard?.percentageOfGoalAchieved
                              .toInt()
                              .toString() ??
                          '0%',
                      style: const TextStyle(
                        fontSize: 64,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1,
                      ),
                    ),
                    8.height,
                    const Text(
                      'Percentage of Goal Achieved',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              4.width,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 16,
                children: [
                  _buildTopStat(
                    svg: 'check_circle',
                    value: app?.planDashboard?.daysToGo.toString() ?? '0',
                    label: 'Days to go',
                  ),
                  _buildTopStat(
                    svg: 'earned_coins',
                    value:
                        app?.planDashboard?.chpPointsAcquired.toString() ?? '0',
                    label: 'Earned Coins',
                  ),
                ],
              ),
            ],
          ),
          16.height,
          Stack(
            children: [
              Container(
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              FractionallySizedBox(
                widthFactor: app?.planDashboard?.percentageOfGoalAchieved ?? 0,
                child: Container(
                  height: 8,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF00A651), Color(0xFFFFB300)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTopStat({
    IconData? icon,
    String? svg,
    required String value,
    required String label,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (svg != null)
              SvgPicture.asset(
                svg.toSvg,
                // colorFilter:
                //     const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                width: 20,
                height: 20,
              ),
            if (icon != null) Icon(icon, color: Colors.white, size: 16),
            6.width,
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        // 4.height,
        Text(
          label,
          style: context.textTheme.bodySmall?.copyWith(
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildStatisticsGrid(MyAppModel? app) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                svg: 'completed',
                value: app?.planDashboard?.daysCompleted.toString() ?? '0',
                label: 'Days Completed',
                iconColor: const Color(0xFF00A651),
              ),
            ),
            12.width,
            Expanded(
              child: _buildStatCard(
                svg: 'calendar',
                value: app?.planDashboard?.daysToGo.toString() ?? '0',
                label: 'Days to Go',
                iconColor: const Color(0xFF00A651),
              ),
            ),
          ],
        ),
        12.height,
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                svg: 'products',
                value: app?.planDashboard?.productsReviewed.toString() ?? '0',
                label: 'Products Reviewed',
                iconColor: const Color(0xFF00A651),
              ),
            ),
            12.width,
            Expanded(
              child: _buildStatCard(
                svg: 'expert',
                value: app?.planDashboard?.expertsEngaged.toString() ?? '0',
                label: 'Experts Engaged',
                iconColor: const Color(0xFF00A651),
              ),
            ),
          ],
        ),
        12.height,
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                svg: 'joined_communities',
                value: app?.planDashboard?.joinedCommunities.toString() ?? '0',
                label: 'Joined Communities',
                iconColor: const Color(0xFF00A651),
                backgroundColor: const Color(0xFFE8F5E9),
              ),
            ),
            12.width,
            Expanded(
              child: _buildStatCard(
                svg: 'acquired_points',
                value: app?.planDashboard?.chpPointsAcquired.toString() ?? '0',
                label: 'Earned Points',
                iconColor: const Color(0xFF00A651),
                backgroundColor: const Color(0xFFE8F5E9),
              ),
            ),
          ],
        ),
        12.height,
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                svg: 'cheerleader',
                value: app?.planDashboard?.cheerleadersAndFriends.toString() ??
                    '0',
                label: 'Cheerleader/Friends',
                iconColor: const Color(0xFF00A651),
                backgroundColor: const Color(0xFFE8F5E9),
              ),
            ),
            12.width,
            const Expanded(
              child: SizedBox(),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard({
    String? svg,
    IconData? icon,
    required String value,
    required String label,
    required Color iconColor,
    Color? backgroundColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        border: Border.all(
          color: const Color(0xFFE0E0E0),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          if (svg != null)
            SvgPicture.asset(
              svg.toSvg,
              width: 34,
              height: 34,
            ),
          if (icon != null)
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 20,
              ),
            ),
          12.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF212121),
                  ),
                ),
                2.height,
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF757575),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
