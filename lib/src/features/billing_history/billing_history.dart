import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenzone_medical/src/utils/extensions/extensions.dart';
import 'package:greenzone_medical/src/utils/extensions/widget_extensions.dart';

class BillingHistory extends StatefulWidget {
  static const routeName = '/billing-history';
  const BillingHistory({super.key});

  @override
  State<BillingHistory> createState() => _BillingHistoryState();
}

class _BillingHistoryState extends State<BillingHistory>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header
          Container(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 30),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF00C853), // Bright Green
                  Color(0xFF2E7D32), // Dark Green
                ],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => context.pop(),
                      child: const Icon(Icons.arrow_back_ios,
                          color: Colors.white, size: 20),
                    ),
                    const Icon(Icons.battery_full,
                        color: Colors.white54, size: 20), // Placeholder status
                  ],
                ),
                20.height,
                Text(
                  'Wallet Balance',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: Colors.white70,
                  ),
                ),
                10.height,
                Text(
                  'N12,000.00',
                  style: context.textTheme.displayMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                  ),
                ),
                30.height,
                Row(
                  children: [
                    Expanded(
                      child: _buildHeaderButton('Fund Wallet'),
                    ),
                    20.width,
                    Expanded(
                      child: _buildHeaderButton('Cash Out'),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Body
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Transaction in the last 30 days',
                        style: context.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.filter_list, size: 20),
                      ),
                    ],
                  ),
                ),
                TabBar(
                  controller: _tabController,
                  labelColor: const Color(0xFF2E7D32),
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: const Color(0xFF2E7D32),
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: const [
                    Tab(text: 'Income'),
                    Tab(text: 'Outflow'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      // Income Tab (Placeholder)
                      Center(child: Text('No income transactions')),
                      // Outflow Tab
                      ListView(
                        padding: const EdgeInsets.all(20),
                        children: [
                          _buildSectionHeader('RECENTS'),
                          10.height,
                          _buildTransactionItem(
                            title: 'Payment for consultatio.',
                            date: '11-02-2023 | 6:30 pm',
                            amount: '3,050',
                            icon: Icons.local_hospital_outlined,
                          ),
                          _buildTransactionItem(
                            title: 'Payment for Prescription from...',
                            date: '11-02-2023 | 6:30 pm',
                            amount: '50,000',
                            icon: Icons.medication_outlined,
                          ),
                          _buildTransactionItem(
                            title: 'Payment for food-dodogizard...',
                            date: '11-02-2023 | 6:30 pm',
                            amount: '50,000',
                            icon: Icons.restaurant_outlined,
                          ),
                          20.height,
                          _buildSectionHeader('LAST 30 DAYS'),
                          10.height,
                          _buildTransactionItem(
                            title: 'Transfer from Eucharia Odili',
                            date: '11-02-2023 | 6:30 pm',
                            amount: '50,000',
                            icon: Icons.north_east,
                          ),
                          _buildTransactionItem(
                            title: 'Transfer from Eucharia Odili',
                            date: '11-02-2023 | 6:30 pm',
                            amount: '50,000',
                            icon: Icons.north_east,
                          ),
                          _buildTransactionItem(
                            title: 'Transfer from Eucharia Odili',
                            date: '11-02-2023 | 6:30 pm',
                            amount: '50,000',
                            icon: Icons.north_east,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderButton(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(30),
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: context.textTheme.bodyMedium?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: context.textTheme.bodySmall?.copyWith(
        color: Colors.grey,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildTransactionItem({
    required String title,
    required String date,
    required String amount,
    required IconData icon,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.green.shade100),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.green, size: 20),
          ),
          15.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                5.height,
                Text(
                  date,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: Colors.grey,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
