import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../marketplace_listing_screen.dart';

class MartServicesController extends GetxController {
  
  // Primary Services
  final primaryServices = <Map<String, dynamic>>[
    {'title': 'B2B', 'subtitle': 'Quick Quotes', 'icon': Icons.business, 'assetPath': 'assets/images/biz_icon_3d.png'},
    {'title': 'Repairs & Services', 'subtitle': 'Get Nearest Vendor', 'icon': Icons.build},
    {'title': 'Real Estate', 'subtitle': 'Finest Agents', 'icon': Icons.real_estate_agent, 'assetPath': 'assets/images/mart_icon_3d.png'},
    {'title': 'Doctors', 'subtitle': 'Book Now', 'icon': Icons.medical_services, 'assetPath': 'assets/images/mart_icon_3d.png'},
  ].obs;

  // Tim to Fly Offer
  final showFlightOffer = true.obs;

  // Popular Categories
  final popularCategories = <Map<String, dynamic>>[
    {'name': 'AC Service', 'icon': Icons.ac_unit},
    {'name': 'Astrologers', 'icon': Icons.auto_awesome},
    {'name': 'Body Massage', 'icon': Icons.spa},
    {'name': 'Beauty Spa', 'icon': Icons.face},
    {'name': 'Car Hire', 'icon': Icons.directions_car},
    {'name': 'Caterers', 'icon': Icons.restaurant},
    {'name': 'Charted Accountant', 'icon': Icons.calculate},
    {'name': 'Computer Training', 'icon': Icons.computer},
    {'name': 'Courier Services', 'icon': Icons.local_shipping},
    {'name': 'Laptop Repair', 'icon': Icons.laptop_mac},
    {'name': 'Car', 'icon': Icons.directions_car_filled},
  ].obs;

  // Service Categories (Gradient Cards)
  final serviceCategories = <Map<String, dynamic>>[
    {'name': 'Home Services', 'colors': [const Color(0xFF6A11CB), const Color(0xFF2575FC)]},
    {'name': 'Repair & Maintenance', 'colors': [const Color(0xFFFF512F), const Color(0xFFDD2476)]},
    {'name': 'Health & Medical', 'colors': [const Color(0xFF00B09B), const Color(0xFF96C93D)]},
    {'name': 'Education & Training', 'colors': [const Color(0xFF8E2DE2), const Color(0xFF4A00E0)]},
    {'name': 'Events & Wedding', 'colors': [const Color(0xFFFF5F6D), const Color(0xFFFFC371)]},
    {'name': 'Logistics & Courier', 'colors': [const Color(0xFF11998E), const Color(0xFF38EF7D)]},
    {'name': 'Baby Care', 'colors': [const Color(0xFFFC5C7D), const Color(0xFF6A82FB)]},
    {'name': 'Hotel & Travel', 'colors': [const Color(0xFF1E90FF), const Color(0xFF00BFFF)]},
     {'name': 'Pets & Pet Supplies', 'colors': [const Color(0xFFFFD700), const Color(0xFFFFA500)]},
     {'name': 'Agriculture', 'colors': [const Color(0xFF4CAF50), const Color(0xFF8BC34A)]},
  ].obs;

  // Product Categories
  final productCategories = <String>[
    'Electronics', 'Apparel & Fashion', 'Industrial Plants', 'Construction Materials',
    'Chemicals & Allied', 'Electronic Components', 'Furniture & Decor', 'Jewellery & Gems'
  ].obs;

  // Search
  final searchQuery = ''.obs;

  void onItemTap(String title) {
    // Navigate to generic MarketplaceListingScreen for ANY category/service tapped
    Get.to(() => MarketplaceListingScreen(categoryName: title));
  }

  void onPostReq() {
    Get.snackbar('Post Requirement', 'Post Requirement clicked', 
       snackPosition: SnackPosition.BOTTOM,
       backgroundColor: Colors.green.withOpacity(0.8),
       colorText: Colors.white,
       margin: const EdgeInsets.all(16),
    );
  }
}
