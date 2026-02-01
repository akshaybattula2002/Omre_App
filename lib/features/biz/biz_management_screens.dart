import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_assets.dart';
import '../../core/theme/palette.dart';
import 'controllers/biz_controller.dart';
import 'create_campaign_screen.dart';
import 'wallet_history_screen.dart';

class OrdersScreen extends GetView<BizController> {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFF9FAFB),
      appBar: AppBar(
        title: const Text('Orders', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor),
          onPressed: () => Get.back(),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: 10,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final isEven = index % 2 == 0;
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: isDark ? Colors.grey[800]! : Colors.grey[200]!),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isEven ? Colors.blue.withOpacity(0.1) : Colors.green.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isEven ? Icons.shopping_bag_outlined : Icons.check_circle_outline,
                    color: isEven ? Colors.blue : Colors.green,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order #ORD-10${index + 24}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        isEven ? 'Pending Delivery' : 'Delivered',
                        style: TextStyle(color: Colors.grey[500], fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      '\$124.00',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '2 hours ago',
                      style: TextStyle(color: Colors.grey[500], fontSize: 11),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class AdsManagerScreen extends StatelessWidget {
  const AdsManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFF9FAFB),
      appBar: AppBar(
        title: const Text('Ads Manager', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAdStatCard(isDark),
            const SizedBox(height: 24),
            const Text(
              'Active Campaigns',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildCampaignItem('Summer Sale 2024', 'Active', '12.4k reach', 0.65, isDark),
            const SizedBox(height: 12),
            _buildCampaignItem('New Arrivals', 'Paused', '5.2k reach', 0.23, isDark),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => Get.to(() => const CreateCampaignScreen()),
                icon: const Icon(Icons.add_chart),
                label: const Text('Create New Campaign'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppPalette.accentBlue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdStatCard(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Total Ad Spend', style: TextStyle(color: Colors.white70)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text('Last 30 Days', style: TextStyle(color: Colors.white, fontSize: 10)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text('\$1,452.80', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildMetric('Reach', '45.2k'),
              _buildMetric('Clicks', '2.8k'),
              _buildMetric('CTR', '3.2%'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetric(String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }

  Widget _buildCampaignItem(String title, String status, String reach, double progress, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isDark ? Colors.grey[800]! : Colors.grey[200]!),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(status, style: TextStyle(color: status == 'Active' ? Colors.green : Colors.grey, fontSize: 12, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(),
          const SizedBox(height: 12),
          Row(
            children: [
              Text(reach, style: TextStyle(color: Colors.grey[500], fontSize: 12)),
              const Spacer(),
              const Icon(Icons.insights, size: 14, color: Colors.blue),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[200],
            color: Colors.blue,
            minHeight: 4,
          ),
        ],
      ),
    );
  }
}

class WalletScreen extends GetView<BizController> {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFF9FAFB),
      appBar: AppBar(
        title: const Text('Wallet', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Obx(() => _buildBalanceCard(isDark, controller.balance.value)),
            const SizedBox(height: 24),
            Row(
              children: [
                _buildWalletAction(Icons.arrow_upward, 'Transfer', Colors.blue, isDark, onTap: () => _showTransferDialog(context)),
                const SizedBox(width: 12),
                _buildWalletAction(Icons.add, 'Add Funds', Colors.green, isDark, onTap: () => _showAddFundsDialog(context)),
                const SizedBox(width: 12),
                _buildWalletAction(Icons.history, 'History', Colors.orange, isDark, onTap: () => Get.to(() => const WalletHistoryScreen())),
              ],
            ),
            const SizedBox(height: 24),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Recent Transactions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 16),
            Obx(() => ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.transactions.length,
              itemBuilder: (context, index) {
                return _buildTransactionItem(controller.transactions[index], isDark);
              },
            )),
          ],
        ),
      ),
    );
  }

  void _showAddFundsDialog(BuildContext context) {
    final amountController = TextEditingController();
    Get.dialog(
      AlertDialog(
        title: const Text('Add Funds'),
        content: TextField(
          controller: amountController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(hintText: 'Enter amount', prefixText: '\$'),
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              final amount = double.tryParse(amountController.text) ?? 0;
              if (amount > 0) {
                controller.addFunds(amount);
                Get.back();
                Get.snackbar('Success', 'Added \$${amount.toStringAsFixed(2)} to wallet');
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showTransferDialog(BuildContext context) {
    final amountController = TextEditingController();
    final recipientController = TextEditingController();
    Get.dialog(
      AlertDialog(
        title: const Text('Transfer Funds'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: recipientController,
              decoration: const InputDecoration(hintText: 'Recipient name'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'Enter amount', prefixText: '\$'),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              final amount = double.tryParse(amountController.text) ?? 0;
              final recipient = recipientController.text;
              if (amount > 0 && recipient.isNotEmpty) {
                if (controller.balance.value >= amount) {
                  controller.transferFunds(amount, recipient);
                  Get.back();
                  Get.snackbar('Success', 'Transferred \$${amount.toStringAsFixed(2)} to $recipient');
                } else {
                  Get.snackbar('Error', 'Insufficient balance');
                }
              }
            },
            child: const Text('Transfer'),
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceCard(bool isDark, double balanceValue) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.black,
        borderRadius: BorderRadius.circular(24),
        image: const DecorationImage(
          image: AssetImage(AppAssets.thumbnail2),
          opacity: 0.1,
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Available Balance', style: TextStyle(color: Colors.white60, fontSize: 14)),
              Image.asset(AppAssets.walletIcon3d, width: 24, height: 24),
            ],
          ),
          const SizedBox(height: 8),
          Text('\$${balanceValue.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          Row(
            children: [
              const Text('**** 4290', style: TextStyle(color: Colors.white38, fontSize: 16, letterSpacing: 2)),
              const Spacer(),
              const Text('VISA', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18, fontStyle: FontStyle.italic)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWalletAction(IconData icon, String label, Color color, bool isDark, {VoidCallback? onTap}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: isDark ? Colors.grey[800]! : Colors.grey[200]!),
          ),
          child: Column(
            children: [
              Icon(icon, color: color),
              const SizedBox(height: 8),
              Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionItem(Map<String, dynamic> tx, bool isDark) {
    final isWithdrawal = tx['type'] == 'out';
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isDark ? Colors.grey[800]! : Colors.grey[200]!),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isWithdrawal ? Colors.red.withOpacity(0.1) : Colors.green.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isWithdrawal ? Icons.arrow_outward : Icons.arrow_downward,
                color: isWithdrawal ? Colors.red : Colors.green,
                size: 18,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tx['title'],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    tx['date'],
                    style: TextStyle(color: Colors.grey[500], fontSize: 12),
                  ),
                ],
              ),
            ),
            Text(
              '${isWithdrawal ? '-' : '+'}\$${(tx['amount'] as double).toStringAsFixed(2)}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isWithdrawal ? Colors.red : Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
