import '../../../utils/packages.dart';
import '../../../resources/colors/colors.dart';

class BillingAndRewardsPage extends StatefulWidget {
  const BillingAndRewardsPage({super.key});

  @override
  State<BillingAndRewardsPage> createState() => _BillingAndRewardsPageState();
}

class _BillingAndRewardsPageState extends State<BillingAndRewardsPage>
    with SingleTickerProviderStateMixin {
  bool _isDashboardExpanded = false;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Billing & Rewards'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          indicatorColor: AppColors.primary,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.greyTextColor,
          onTap: (index) {
            if (index == 1) {
              // Navigate to Rewards Page
              context.push(Routes.REWARDS_PAGE);
              // reset index to previous to avoid moving indicator
              _tabController.index = _tabController.previousIndex;
            } else {
              _tabController.animateTo(index);
            }
          },
          tabs: const [
            Tab(text: 'History'),
            Tab(text: 'Rewards'),
            Tab(text: 'Fund Wallet'),
            Tab(text: 'Withdraw'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        physics:
            const NeverScrollableScrollPhysics(), // Disable swipe to prevent accidental Rewards tab access
        children: [
          _buildHistoryTab(),
          const SizedBox.shrink(), // Rewards tab placeholder
          const Center(child: Text('Fund Wallet Coming Soon')),
          const Center(child: Text('Withdraw Coming Soon')),
        ],
      ),
    );
  }

  Widget _buildHistoryTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildWalletBalanceCard(),
          const SizedBox(height: 20),
          _buildTransactionsSection(title: 'Transaction in the last 30 days'),
        ],
      ),
    );
  }

  Widget _buildWalletBalanceCard() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFD9FEAA), // Light green background
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDashboardItem(
            icon: Icons.account_balance_wallet,
            value: 'N3,265.00',
            label: 'Wallet Balance',
            isHighlighted: _isDashboardExpanded,
          ),
          if (_isDashboardExpanded) ...[
            const SizedBox(height: 12),
            _buildDashboardItem(
              icon: Icons.account_balance_wallet,
              value: 'N204.00',
              label: 'Pending Balance',
            ),
            const SizedBox(height: 12),
            _buildDashboardItem(
              icon: Icons.monetization_on,
              value: '3,265',
              label: 'Earned Points',
              iconAsset:
                  'assets/icon/coin.png', // Assuming coin asset exists based on previous file exploration or fallback to icon
            ),
            const SizedBox(height: 12),
            _buildDashboardItem(
              icon: Icons.account_balance_wallet,
              value: 'N204.00',
              label: 'Earned Point Value',
            ),
            const SizedBox(height: 12),
            _buildWithdrawalAccountItem(),
          ],
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () {
              setState(() {
                _isDashboardExpanded = !_isDashboardExpanded;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  _isDashboardExpanded
                      ? 'Collapse Dashboard'
                      : 'View Dashboard',
                  style: TextStyle(
                    color: _isDashboardExpanded
                        ? const Color(0xFF1B4729)
                        : AppColors.primary,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Icon(
                  _isDashboardExpanded
                      ? Icons.arrow_drop_up
                      : Icons.arrow_drop_down,
                  color: _isDashboardExpanded
                      ? const Color(0xFF1B4729)
                      : AppColors.primary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardItem({
    required IconData icon,
    required String value,
    required String label,
    String? iconAsset,
    bool isHighlighted = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: isHighlighted ? Border.all(color: Colors.blue, width: 2) : null,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFEDF8ED),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(icon, color: AppColors.primary, size: 24),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWithdrawalAccountItem() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Color(0xFF17621A), // Dark green
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.account_balance,
                color: Colors.white, size: 24),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '8090345678',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF17621A),
                  ),
                ),
                Text(
                  'Withdrawal Account',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.copy, color: Color(0xFF17621A), size: 20),
        ],
      ),
    );
  }

  Widget _buildTransactionsSection(
      {required String title, bool showDescription = false}) {
    return Container(
      decoration: BoxDecoration(
        // border: Border.all(color: Colors.blue, width: 2), // Remove detailed border for now or make optional
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                        color: Color(0xFFF5F5F5), shape: BoxShape.circle),
                    child: const Icon(Icons.filter_list, size: 20))
              ],
            ),
          ),
          if (showDescription)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
              child: Text('Activity Description',
                  style: TextStyle(color: Colors.grey, fontSize: 13)),
            ),
          const Divider(height: 1),
          if (!showDescription) // Only show Income/Outflow tabs for History tab
            Padding(
              padding:const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [ const
                  Expanded(
                    child: Center(
                        child: Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child:
                          Text('Income', style: TextStyle(color: Colors.grey)),
                    )),
                  ),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(color: Colors.green, width: 2))),
                      child: const Center(
                          child: Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Text('Outflow',
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold)),
                      )),
                    ),
                  ),
                ],
              ),
            ),
          if (!showDescription) const Divider(height: 1),
          _buildTransactionList(),
        ],
      ),
    );
  }

  Widget _buildTransactionList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(12.0),
          child: Text('RECENTS',
              style: TextStyle(color: Colors.grey, fontSize: 12)),
        ),
        _buildTransactionItem(
            'Withdrawn amount fro. .', '11-02-2023 | 6:30 pm', '50,000', true),
        _buildTransactionItem('Earned point from referral sign-...',
            '11-02-2023 | 6:30 pm', '50.00', true),
        _buildTransactionItem('Payment for food-dodogizard...',
            '11-02-2023 | 6:30 pm', '50,000', true),
        const Padding(
          padding: EdgeInsets.all(12.0),
          child: Text('LAST 30 DAYS',
              style: TextStyle(color: Colors.grey, fontSize: 12)),
        ),
        _buildTransactionItem('Transfer from Eucharia Odili',
            '11-02-2023 | 6:30 pm', '50,000', false),
        _buildTransactionItem('Transfer from Eucharia Odili',
            '11-02-2023 | 6:30 pm', '50,000', false),
        _buildTransactionItem('Transfer from Eucharia Odili',
            '11-02-2023 | 6:30 pm', '50,000', false),
      ],
    );
  }

  Widget _buildTransactionItem(
      String title, String date, String amount, bool isOutflow) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.green),
            ),
            child: Icon(isOutflow ? Icons.north_east : Icons.south_west,
                color: Colors.green, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(date,
                    style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          Text(amount, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
