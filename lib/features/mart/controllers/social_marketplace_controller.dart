import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../post_requirement_screen.dart';
import '../marketplace_listing_screen.dart';
import '../exclusive_deals_screen.dart';
import '../models/marketplace_models.dart';
import '../../../core/services/mock_service.dart';
import '../../messenger/chat_detail_screen.dart';
import '../../../core/constants/app_assets.dart';

class SocialMarketplaceController extends GetxController {
  final selectedCategory = 'All'.obs;
  final searchQuery = ''.obs;
  final searchFocusNode = FocusNode();

  final categories = <CategoryModel>[].obs;
  final services = <ServiceModel>[].obs;
  final deals = <DealModel>[].obs;
  final products = <ProductModel>[].obs;
  final popularServices = <ServiceModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadMockData();
  }

  @override
  void onClose() {
    searchFocusNode.dispose();
    super.onClose();
  }

  void focusSearch() {
    Future.delayed(const Duration(milliseconds: 300), () {
      searchFocusNode.requestFocus();
    });
  }

  void _loadMockData() {
    categories.value = [
      CategoryModel(name: 'Home Services', icon: 'assets/icons/home_services.png'), 
      CategoryModel(name: 'Repair', icon: 'assets/icons/repair.png'),
      CategoryModel(name: 'Health', icon: 'assets/icons/health.png'),
      CategoryModel(name: 'Education', icon: 'assets/icons/education.png'),
      CategoryModel(name: 'Events', icon: 'assets/icons/events.png'),
      CategoryModel(name: 'Logistics', icon: 'assets/icons/logistics.png'),
      CategoryModel(name: 'Baby Care', icon: 'assets/icons/baby.png'),
      CategoryModel(name: 'Travel', icon: 'assets/icons/travel.png'),
      CategoryModel(name: 'Pets', icon: 'assets/icons/pets.png'),
    ];

    deals.value = [
      DealModel(title: 'Home Cleaning', description: 'Deep clean your entire house', discount: '50% Off'),
      DealModel(title: 'Office Furniture', description: 'Bulk discount for startups', discount: '30% Off'),
      DealModel(title: 'AC Service', description: 'Get ready for summer', discount: '20% Off'),
    ];

    services.value = [
      ServiceModel(name: 'Wedding Photography', rating: 4.8, reviews: 120, distance: '2.5 km', fastResponse: true, image: AppAssets.post1),
      ServiceModel(name: 'Spa & Massage', rating: 4.5, reviews: 85, distance: '1.2 km', fastResponse: true, image: AppAssets.post2),
      ServiceModel(name: 'Laptop Repair', rating: 4.7, reviews: 200, distance: '3.0 km', fastResponse: false, image: AppAssets.post3),
      ServiceModel(name: 'Grocery Delivery', rating: 4.2, reviews: 500, distance: '0.5 km', fastResponse: true, image: AppAssets.post4),
    ];

    popularServices.value = [
      ServiceModel(name: 'Urban Clap Home Cleaning', rating: 4.9, reviews: 1540, distance: '1.2 km', fastResponse: true, image: AppAssets.post1),
      ServiceModel(name: 'City Logistics & Movers', rating: 4.6, reviews: 320, distance: '5.0 km', fastResponse: true, image: AppAssets.post2),
      ServiceModel(name: 'Tech Fix Laptop Repair', rating: 4.8, reviews: 890, distance: '2.8 km', fastResponse: false, image: AppAssets.post3),
      ServiceModel(name: 'Yoga & Wellness Center', rating: 4.7, reviews: 450, distance: '1.5 km', fastResponse: true, image: AppAssets.post4),
    ];

    products.value = [
      ProductModel(name: 'Industrial Heavy Duty Drill', price: '\$150.00', minOrder: 5, supplier: 'Tools Pro Ltd', location: 'New York', image: AppAssets.thumbnail1),
      ProductModel(name: 'Cotton T-Shirts Bulk', price: '\$5.00/pc', minOrder: 50, supplier: 'Fashion Hub', location: 'Los Angeles', image: AppAssets.thumbnail2),
      ProductModel(name: 'Solar Panels 400W', price: '\$200.00', minOrder: 10, supplier: 'Green Energy Co', location: 'Texas', image: AppAssets.thumbnail3),
      ProductModel(name: 'Packaging Boxes', price: '\$0.50/pc', minOrder: 100, supplier: 'Box Master', location: 'Chicago', image: AppAssets.thumbnail1),
    ];
  }

  void filterByCategory(String categoryName) {
    if (categoryName == 'All') {
      selectedCategory.value = 'All';
      return;
    }
    
    // Globally handle ALL specific categories to browse screen
    Get.to(() => MarketplaceListingScreen(categoryName: categoryName));
  }

  void postRequest() {
    Get.to(() => const PostRequirementScreen());
  }

  void grabOffer(String dealTitle) {
    Get.to(() => const ExclusiveDealsScreen());
  }

  void callService(String serviceName) {
    Get.snackbar('Call', 'Calling $serviceName...', backgroundColor: Colors.green, colorText: Colors.white);
  }

  void chatService(String serviceName) {
    // Navigate to chat detail with mock service data
    Get.to(() => const ChatDetailScreen(), arguments: MockChat(
      id: 'service_chat_${serviceName.toLowerCase().replaceAll(' ', '_')}',
      name: serviceName,
      avatarUrl: AppAssets.post2, // Default avatar for mock
      lastMessage: 'Hi, I am interested in your service.',
      time: 'Just now',
      unreadCount: 0,
      category: 'Service',
    ));
  }

  void getBestPrice(String productName) {
    Get.to(() => const PostRequirementScreen());
  }
}
