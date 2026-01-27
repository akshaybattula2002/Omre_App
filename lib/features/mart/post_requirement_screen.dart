import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/post_requirement_controller.dart';
import '../../core/theme/palette.dart';

class PostRequirementScreen extends StatelessWidget {
  const PostRequirementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PostRequirementController());
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subtitleColor = isDark ? Colors.grey[400] : Colors.grey[600];

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF101010) : Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Post a Requirement',
          style: TextStyle(color: textColor, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
              // Card Container
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Text(
                        'Post a Requirement',
                        style: TextStyle(
                          color: textColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Tell us what you need, and we’ll connect you with verified suppliers.',
                        style: TextStyle(
                          color: subtitleColor,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Requirement Name
                      _buildLabel('What are you looking for?', true, textColor),
                      const SizedBox(height: 8),
                      _buildTextField(
                        controller: controller.requirementController,
                        hint: 'e.g. 50 Office Chairs or Home Cleaning Service',
                        isDark: isDark,
                        validator: (val) => controller.validateRequired(val, 'Requirement'),
                      ),
                      const SizedBox(height: 24),

                      // Quantity & Budget Row
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildLabel('Quantity', true, textColor),
                                const SizedBox(height: 8),
                                _buildTextField(
                                  controller: controller.quantityController,
                                  hint: 'e.g. 50',
                                  isDark: isDark,
                                  keyboardType: TextInputType.number,
                                  validator: (val) => controller.validateNumeric(val, 'Quantity'),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildLabel('Budget (Optional)', false, textColor),
                                const SizedBox(height: 8),
                                _buildTextField(
                                  controller: controller.budgetController,
                                  hint: 'e.g. ₹50,000',
                                  isDark: isDark,
                                  keyboardType: TextInputType.number,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Additional Details
                      _buildLabel('Additional Details', false, textColor),
                      const SizedBox(height: 8),
                      _buildTextField(
                        controller: controller.detailsController,
                        hint: 'Describe your requirements in detail...',
                        isDark: isDark,
                        maxLines: 5,
                      ),
                      const SizedBox(height: 32),

                      // Submit Button
                      Obx(() => SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: ElevatedButton(
                          onPressed: controller.isLoading.value ? null : () {
                            // Trigger haptic feedback if possible, or just proceed
                            controller.submit();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppPalette.accentBlue,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 4,
                            shadowColor: AppPalette.accentBlue.withOpacity(0.4),
                          ),
                          child: controller.isLoading.value
                              ? const SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text(
                                  'Submit Requirement',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      )),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text, bool isRequired, Color color) {
    return Row(
      children: [
        Text(
          text,
          style: TextStyle(
            color: color.withOpacity(0.8),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (isRequired)
          const Text(
            ' *',
            style: TextStyle(color: Colors.red, fontSize: 14),
          ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required bool isDark,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      style: TextStyle(color: isDark ? Colors.white : Colors.black, fontSize: 14),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: isDark ? Colors.grey[600] : Colors.grey[400], fontSize: 14),
        filled: true,
        fillColor: isDark ? Colors.black.withOpacity(0.2) : Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppPalette.accentBlue, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }
}
