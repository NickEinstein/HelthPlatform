import '../../../utils/packages.dart';
import '../../../resources/colors/colors.dart';

class RewardsPage extends StatefulWidget {
  const RewardsPage({super.key});

  @override
  State<RewardsPage> createState() => _RewardsPageState();
}

class _RewardsPageState extends State<RewardsPage> {
  bool _isRewardsExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rewards'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: TextButton(
              onPressed: () {
                context.pop();
              },
              child: const Text('Return to Billing',
                  style: TextStyle(color: AppColors.greyTextColor)),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildRewardsDashboard(),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: _buildTransactionsSection(
                  title: 'All Transactions', showDescription: true),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRewardsDashboard() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(16),
      color: const Color(0xFFD9FEAA), // Light green background
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildRewardCard(
            icon: Icons.monetization_on_outlined, // Coin stack icon
            value: '3,265',
            label: 'Earned Points',
            backgroundColor: const Color(0xFF079808), // Dark Green
            textColor: Colors.white,
            iconColor: const Color(0xFF079808),
            iconBgColor: Colors.white,
          ),
          if (_isRewardsExpanded) ...[
            const SizedBox(height: 8),
            _buildRewardCard(
              icon: Icons.account_balance_wallet_outlined,
              value: 'N204.00',
              label: 'Earned Point Value',
              backgroundColor: const Color(0xFF079808), // Dark Green
              textColor: Colors.white,
              iconColor: const Color(0xFF079808),
              iconBgColor: Colors.white,
            ),
            const SizedBox(height: 8),
            _buildRewardCard(
              icon: Icons.monetization_on_outlined,
              value: '3,265',
              label: 'Rewarded Actions',
              backgroundColor: Colors.white,
              textColor: Colors.black,
              iconColor: const Color(0xFF079808),
              iconBgColor: const Color(0xFFEDF8ED),
            ),
            const SizedBox(height: 8),
            _buildRewardCard(
              icon: Icons.account_balance_wallet_outlined,
              value: '204',
              label: 'Rewardable Actions',
              backgroundColor: Colors.white,
              textColor: Colors.black,
              iconColor: const Color(0xFF079808),
              iconBgColor: const Color(0xFFEDF8ED),
            ),
            const SizedBox(height: 8),
            _buildReferralCard(),
          ],
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () {
              setState(() {
                _isRewardsExpanded = !_isRewardsExpanded;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _isRewardsExpanded
                      ? Icons.arrow_drop_up
                      : Icons.arrow_drop_down,
                  color: const Color(0xFF1B4729),
                ),
                Text(
                  _isRewardsExpanded ? 'Collapse Dashboard' : 'View Dashboard',
                  style: const TextStyle(
                    color: Color(0xFF1B4729),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRewardCard({
    required IconData icon,
    required String value,
    required String label,
    required Color backgroundColor,
    required Color textColor,
    Color? iconColor,
    Color? iconBgColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: textColor.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReferralCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Color(0xFF17621A),
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
                  'AN8090345678Z',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF17621A),
                  ),
                ),
                Text(
                  'Your Referral Code',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.copy, color: const Color(0xFF17621A), size: 20),
        ],
      ),
    );
  }

  Widget _buildTransactionsSection(
      {required String title, bool showDescription = false}) {
    return Container(
      decoration: BoxDecoration(
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
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  const Expanded(
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
