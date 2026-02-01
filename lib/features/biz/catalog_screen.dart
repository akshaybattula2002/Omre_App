import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_assets.dart';
import '../../core/theme/palette.dart';
import 'add_product_screen.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFF9FAFB),
      appBar: AppBar(
        title: const Text('Catalog', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: isDark ? Colors.white : Colors.black),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            color: isDark ? Colors.white : Colors.black,
            onPressed: () {
              Get.snackbar('Search', 'Search functionality coming soon');
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
             color: isDark ? Colors.white : Colors.black,
            onPressed: () {
              Get.snackbar('Menu', 'More options');
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSummaryCard(context),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Products (12)',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
              TextButton(onPressed: () {
                 Get.snackbar('See All', 'Showing all products');
              }, child: const Text('See All')),
            ],
          ),
          const SizedBox(height: 12),
          _buildProductItem(context, 'Wireless Headphones', '\$129.00', 'In Stock (45)', AppAssets.thumbnail1),
          _buildProductItem(context, 'Smart Watch Series 5', '\$299.00', 'In Stock (12)', AppAssets.thumbnail2),
          _buildProductItem(context, 'Vintage Camera Lens', '\$450.00', 'Low Stock (2)', AppAssets.thumbnail3),
          _buildProductItem(context, 'Designer Backpack', '\$89.00', 'Out of Stock', AppAssets.thumbnail1),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.to(() => const AddProductScreen());
        },
        backgroundColor: AppPalette.accentBlue,
        icon: const Icon(Icons.add),
        label: const Text('Add New Item'),
      ),
    );
  }

  Widget _buildSummaryCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppPalette.accentBlue,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppPalette.accentBlue.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Column(
            children: [
              Text('12', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
              Text('Products', style: TextStyle(color: Colors.white70)),
            ],
          ),
          Container(width: 1, height: 40, color: Colors.white24),
          const Column(
            children: [
              Text('5', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
              Text('Collections', style: TextStyle(color: Colors.white70)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProductItem(BuildContext context, String title, String price, String stock, String image) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isDark ? Colors.grey[800]! : Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
              image: const DecorationImage(
                image: AssetImage(AppAssets.thumbnail2), // Using a placeholder for dummy
                fit: BoxFit.cover,
              ),
            ),
             child: const Icon(Icons.image, color: Colors.grey),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black87)),
                const SizedBox(height: 4),
                Text(price, style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                stock,
                style: TextStyle(
                  color: stock.contains('Out') ? Colors.red : (stock.contains('Low') ? Colors.orange : Colors.green),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              const Icon(Icons.more_horiz, color: Colors.grey),
            ],
          ),
        ],
      ),
    );
  }
}
