import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostRequirementController extends GetxController {
  final requirementController = TextEditingController();
  final quantityController = TextEditingController();
  final budgetController = TextEditingController();
  final detailsController = TextEditingController();

  final isLoading = false.obs;
  final formKey = GlobalKey<FormState>();

  @override
  void onClose() {
    requirementController.dispose();
    quantityController.dispose();
    budgetController.dispose();
    detailsController.dispose();
    super.onClose();
  }

  Future<void> submit() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;
    
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    
    isLoading.value = false;
    
    Get.back(); // Navigate back
    Get.snackbar(
      'Success',
      'Requirement submitted successfully',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 3),
      icon: const Icon(Icons.check_circle, color: Colors.white),
    );
  }

  String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  String? validateNumeric(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    if (double.tryParse(value) == null) {
      return 'Please enter a valid number';
    }
    return null;
  }
}
