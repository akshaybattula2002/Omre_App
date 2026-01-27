import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../../core/constants/app_assets.dart';

class BizController extends GetxController {
  final _picker = ImagePicker();
  final selectedProductImage = Rxn<File>();

  // Wallet State
  final balance = 8420.50.obs;
  final transactions = <Map<String, dynamic>>[
    {'type': 'out', 'title': 'Withdrawal to Bank', 'date': '24 Jan, 2024', 'amount': 200.00},
    {'type': 'in', 'title': 'Sale - Classic Denim', 'date': '24 Jan, 2024', 'amount': 45.00},
    {'type': 'in', 'title': 'Sale - Cotton Tee', 'date': '23 Jan, 2024', 'amount': 32.00},
    {'type': 'out', 'title': 'Ads Content Boost', 'date': '22 Jan, 2024', 'amount': 15.00},
  ].obs;

  void addFunds(double amount) {
    balance.value += amount;
    transactions.insert(0, {
      'type': 'in',
      'title': 'Deposit Funds',
      'date': 'Just now',
      'amount': amount,
    });
  }

  void transferFunds(double amount, String recipient) {
    if (balance.value >= amount) {
      balance.value -= amount;
      transactions.insert(0, {
        'type': 'out',
        'title': 'Transfer to $recipient',
        'date': 'Just now',
        'amount': amount,
      });
    }
  }

  Future<void> pickProductImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedProductImage.value = File(image.path);
    }
  }

  // Mock Data
  final stats = [
    {'title': 'Total Revenue', 'value': '\$12,458', 'growth': '+12.5%', 'isPositive': true, 'icon': 'dollar'},
    {'title': 'Total Orders', 'value': '1,234', 'growth': '+8.2%', 'isPositive': true, 'icon': 'cart'},
    {'title': 'Customers', 'value': '856', 'growth': '+5.4%', 'isPositive': true, 'icon': 'users'},
    {'title': 'Products', 'value': '42', 'growth': '-2.1%', 'isPositive': false, 'icon': 'box'},
  ];

  final recentOrders = [
    {'id': 'ORD-001', 'customer': 'John Doe', 'status': 'completed', 'price': '\$125.00', 'time': '2 hours ago'},
    {'id': 'ORD-002', 'customer': 'Jane Smith', 'status': 'processing', 'price': '\$89.50', 'time': '5 hours ago'},
    {'id': 'ORD-003', 'customer': 'Mike Johnson', 'status': 'completed', 'price': '\$210.00', 'time': '1 day ago'},
    {'id': 'ORD-004', 'customer': 'Sarah Williams', 'status': 'pending', 'price': '\$156.75', 'time': '1 day ago'},
  ];

  // Products
  final topProducts = <Map<String, dynamic>>[
    {'rank': 1, 'name': 'Premium Widget', 'sales': '145 sales', 'price': '\$29.99', 'progress': 0.9, 'status': 'Active', 'stock': '150 in stock', 'category': 'Widgets', 'image': AppAssets.thumbnail1},
    {'rank': 2, 'name': 'Budget Widget', 'sales': '98 sales', 'price': '\$9.99', 'progress': 0.7, 'status': 'Active', 'stock': '500 in stock', 'category': 'Widgets', 'image': AppAssets.thumbnail2},
    {'rank': 3, 'name': 'Widget Pro Max', 'sales': '76 sales', 'price': '\$99.99', 'progress': 0.5, 'status': 'Draft', 'stock': '25 in stock', 'category': 'Pro', 'image': AppAssets.thumbnail3},
    {'rank': 4, 'name': 'USB-C Cable', 'sales': '234 sales', 'price': '\$11.70', 'progress': 0.8, 'status': 'Active', 'stock': '1000 in stock', 'category': 'Accessories', 'image': AppAssets.thumbnail1},
  ].obs;

  final filteredProducts = <Map<String, dynamic>>[].obs;
  
  // Filters
  final searchQuery = ''.obs;
  final selectedCategory = Rxn<String>();
  final selectedStatus = Rxn<String>();

  @override
  void onInit() {
    super.onInit();
    filteredProducts.assignAll(topProducts);
    
    // Auto-update filter when any dependency changes
    everAll([searchQuery, selectedCategory, selectedStatus, topProducts], (_) => applyFilters());
  }

  void applyFilters() {
    var result = topProducts.toList();

    // 1. Search Query
    if (searchQuery.value.isNotEmpty) {
      result = result.where((p) => 
        p['name'].toString().toLowerCase().contains(searchQuery.value.toLowerCase()) ||
        p['category'].toString().toLowerCase().contains(searchQuery.value.toLowerCase())
      ).toList();
    }

    // 2. Category
    if (selectedCategory.value != null && selectedCategory.value != 'All') {
      result = result.where((p) => p['category'] == selectedCategory.value).toList();
    }

    // 3. Status
    if (selectedStatus.value != null && selectedStatus.value != 'All') {
      result = result.where((p) => p['status'] == selectedStatus.value).toList();
    }

    filteredProducts.assignAll(result);
  }

  void clearFilters() {
    searchQuery.value = '';
    selectedCategory.value = null;
    selectedStatus.value = null;
    // applyFilters() called automatically via everAll
  }
}
