import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_assets.dart';

class ExclusiveDealModel {
  final String title;
  final String description;
  final String category;
  final String promoCode;
  final String image;
  final Color categoryColor;
  final IconData categoryIcon;

  ExclusiveDealModel({
    required this.title,
    required this.description,
    required this.category,
    required this.promoCode,
    required this.image,
    required this.categoryColor,
    required this.categoryIcon,
  });
}

class ExclusiveDealsController extends GetxController {
  final deals = <ExclusiveDealModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadMockDeals();
  }

  void _loadMockDeals() {
    deals.value = [
      ExclusiveDealModel(
        title: '50% Off on Home Cleaning',
        description: 'Get half price on your first deep cleaning service.',
        category: 'HOME SERVICES',
        promoCode: 'CLEAN50',
        image: AppAssets.post1,
        categoryColor: Colors.cyan,
        categoryIcon: Icons.cleaning_services_outlined,
      ),
      ExclusiveDealModel(
        title: 'Bulk Discount: Office Furniture',
        description: 'Buy 10+ chairs and get 20% off.',
        category: 'FURNITURE',
        promoCode: 'OFFICE20',
        image: AppAssets.post2,
        categoryColor: Colors.teal,
        categoryIcon: Icons.chair_outlined,
      ),
      ExclusiveDealModel(
        title: '30% Off on AC Service',
        description: 'Pre-summer maintenance discount for all residential units.',
        category: 'REPAIR',
        promoCode: 'COOL30',
        image: AppAssets.post3,
        categoryColor: Colors.blue,
        categoryIcon: Icons.build_outlined,
      ),
      ExclusiveDealModel(
        title: 'Free Health Checkup',
        description: 'Get a complimentary basic health screening at select clinics.',
        category: 'HEALTH',
        promoCode: 'HEALTHFREE',
        image: AppAssets.post4,
        categoryColor: Colors.redAccent,
        categoryIcon: Icons.medical_services_outlined,
      ),
    ];
  }

  void copyPromoCode(String code) {
    Clipboard.setData(ClipboardData(text: code));
    Get.snackbar(
      'Code Copied',
      'Promo code $code copied to clipboard!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blueAccent.withOpacity(0.9),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 2),
    );
  }

  void openDealDetails(ExclusiveDealModel deal) {
    Get.snackbar(
      'Deal Detail',
      'Opening details for: ${deal.title}',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.deepPurple.withOpacity(0.8),
      colorText: Colors.white,
    );
  }
}
