import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greenzone_medical/src/utils/extensions/widget_extensions.dart';

class PlanTabDashboard extends ConsumerStatefulWidget {
  const PlanTabDashboard({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PlanTabDashboardState();
}

class _PlanTabDashboardState extends ConsumerState<PlanTabDashboard> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Top Green Progress Card
          _buildProgressCard(),
          20.height,
          // Statistics Grid
          _buildStatisticsGrid(),
        ],
      ),
    );
  }

  Widget _buildProgressCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF00A651), Color(0xFF00C853)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Top Row: Days completed and Earned Coins
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTopStat(
                icon: Icons.check_circle_outline,
                value: '18',
                label: 'Days completed',
              ),
              _buildTopStat(
                icon: Icons.monetization_on_outlined,
                value: '3118',
                label: 'Earned Coins',
              ),
            ],
          ),
          30.height,
          // Large Percentage Display
          const Text(
            '36%',
            style: TextStyle(
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
          ),
          16.height,
          // Progress Bar
          Stack(
            children: [
              Container(
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              FractionallySizedBox(
                widthFactor: 0.36,
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
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.white, size: 16),
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
        4.height,
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: Colors.white.withOpacity(0.9),
          ),
        ),
      ],
    );
  }

  Widget _buildStatisticsGrid() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                icon: Icons.check_circle,
                value: '18',
                label: 'Days Completed',
                iconColor: const Color(0xFF00A651),
              ),
            ),
            12.width,
            Expanded(
              child: _buildStatCard(
                icon: Icons.calendar_today,
                value: '15',
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
                icon: Icons.inventory_2_outlined,
                value: '5',
                label: 'Products Reviewed',
                iconColor: const Color(0xFF00A651),
              ),
            ),
            12.width,
            Expanded(
              child: _buildStatCard(
                icon: Icons.person_outline,
                value: '8',
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
                icon: Icons.groups_outlined,
                value: '18',
                label: 'Joined Communities',
                iconColor: const Color(0xFF00A651),
                backgroundColor: const Color(0xFFE8F5E9),
              ),
            ),
            12.width,
            Expanded(
              child: _buildStatCard(
                icon: Icons.stars_outlined,
                value: '3118',
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
                icon: Icons.favorite_outline,
                value: '3',
                label: 'Cheerleader/Friends',
                iconColor: const Color(0xFF00A651),
                backgroundColor: const Color(0xFFE8F5E9),
              ),
            ),
            12.width,
            Expanded(
              child: _buildStatCard(
                icon: Icons.attach_money,
                value: '3118',
                label: 'Acquired Points',
                iconColor: const Color(0xFF00A651),
                backgroundColor: const Color(0xFFE8F5E9),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
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
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
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
