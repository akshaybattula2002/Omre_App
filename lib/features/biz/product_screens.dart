import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import '../../core/constants/app_assets.dart';
import '../../core/theme/palette.dart';
import 'controllers/biz_controller.dart';

class ProductListScreen extends GetView<BizController> {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF121212) : const Color(0xFFF9FAFB);
    final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Catalog',
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: ElevatedButton.icon(
              onPressed: () => Get.to(() => const AddProductScreen()),
              icon: const Icon(Icons.add, size: 18, color: Colors.white),
              label: const Text('Add Product'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2563EB),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(horizontal: 12),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Filter Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Manage your products and inventory.',
                  style: TextStyle(
                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        style: TextStyle(color: textColor),
                        onChanged: (val) => controller.searchQuery.value = val,
                        decoration: InputDecoration(
                          hintText: 'Search products...',
                          hintStyle: TextStyle(color: Colors.grey[500]),
                          prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
                          filled: true,
                          fillColor: cardColor,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: isDark ? Colors.grey[800]! : Colors.grey[300]!),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: isDark ? Colors.grey[800]! : Colors.grey[300]!),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    OutlinedButton.icon(
                      onPressed: () => _showFilterSheet(context),
                      icon: Icon(Icons.filter_list, size: 18, color: textColor),
                      label: Text('Filter', style: TextStyle(color: textColor)),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        side: BorderSide(color: isDark ? Colors.grey[800]! : Colors.grey[300]!),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        backgroundColor: cardColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Product List
          Expanded(
            child: Obx(() => controller.filteredProducts.isEmpty 
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
                      const SizedBox(height: 16),
                      Text('No products found', style: TextStyle(color: Colors.grey[500], fontSize: 16)),
                    ],
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  itemCount: controller.filteredProducts.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final product = controller.filteredProducts[index];
                    final status = product['status'] as String? ?? 'Active';
                    final isDraft = status == 'Draft';

                    return Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: isDark ? Colors.grey[800]! : Colors.grey[200]!),
                        boxShadow: [
                          if (!isDark)
                            BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 4, offset: const Offset(0, 2)),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Image
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: isDark ? Colors.grey[800] : Colors.grey[100],
                                  borderRadius: BorderRadius.circular(8),
                                  image: const DecorationImage(
                                    image: AssetImage(AppAssets.thumbnail1),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Icon(Icons.image, color: Colors.grey[400]), // Fallback
                              ),
                              const SizedBox(width: 12),
                              // Content
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            product['name'] as String,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: textColor,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Icon(Icons.more_horiz, color: Colors.grey[500]),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      product['price'] as String,
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: textColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          const Divider(height: 1),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                               // Status Badge
                               Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: isDraft 
                                    ? (isDark ? Colors.grey[800] : Colors.grey[200])
                                    : (isDark ? const Color(0xFF1E3A8A) : const Color(0xFFEFF6FF)), // Blue/Grey bg
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Text(
                                  status,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: isDraft 
                                      ? (isDark ? Colors.grey[400] : Colors.grey[700])
                                      : const Color(0xFF2563EB), // Blue text
                                  ),
                                ),
                               ),
                               const SizedBox(width: 12),
                               // Category
                               Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  border: Border.all(color: isDark ? Colors.grey[700]! : Colors.grey[300]!),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Text(
                                  product['category'] as String? ?? 'General',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isDark ? Colors.grey[400] : Colors.grey[700],
                                  ),
                                ),
                               ),
                               const Spacer(),
                               Text(
                                 product['stock'] as String? ?? '0 in stock',
                                 style: TextStyle(
                                   fontSize: 12,
                                   color: isDark ? Colors.grey[500] : Colors.grey[500],
                                 ),
                               ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                )
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterSheet(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Filter Products',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                TextButton(
                  onPressed: () {
                     controller.clearFilters();
                     Get.back();
                  },
                  child: const Text('Clear All'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text('Category', style: TextStyle(fontWeight: FontWeight.w600, color: textColor)),
            const SizedBox(height: 12),
            Obx(() => Wrap(
              spacing: 8,
              children: ['All', 'Widgets', 'Pro', 'Accessories'].map((cat) {
                 final isSelected = controller.selectedCategory.value == cat || 
                                   (cat == 'All' && controller.selectedCategory.value == null);
                 return FilterChip(
                   label: Text(cat),
                   selected: isSelected,
                   onSelected: (val) {
                     controller.selectedCategory.value = cat == 'All' ? null : cat;
                   },
                   backgroundColor: isDark ? Colors.grey[800] : Colors.grey[200],
                   selectedColor: AppPalette.accentBlue.withOpacity(0.2),
                   checkmarkColor: AppPalette.accentBlue,
                   labelStyle: TextStyle(
                     color: isSelected ? AppPalette.accentBlue : textColor,
                   ),
                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: BorderSide.none),
                 );
              }).toList(),
            )),
            const SizedBox(height: 24),
             Text('Status', style: TextStyle(fontWeight: FontWeight.w600, color: textColor)),
            const SizedBox(height: 12),
            Obx(() => Wrap(
              spacing: 8,
              children: ['All', 'Active', 'Draft'].map((status) {
                 final isSelected = controller.selectedStatus.value == status || 
                                   (status == 'All' && controller.selectedStatus.value == null);
                 return FilterChip(
                   label: Text(status),
                   selected: isSelected,
                   onSelected: (val) {
                     controller.selectedStatus.value = status == 'All' ? null : status;
                   },
                   backgroundColor: isDark ? Colors.grey[800] : Colors.grey[200],
                   selectedColor: AppPalette.accentBlue.withOpacity(0.2),
                   checkmarkColor: AppPalette.accentBlue,
                   labelStyle: TextStyle(
                     color: isSelected ? AppPalette.accentBlue : textColor,
                   ),
                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: BorderSide.none),
                 );
              }).toList(),
            )),
             const SizedBox(height: 32),
             SizedBox(
               width: double.infinity,
               child: ElevatedButton(
                 onPressed: () => Get.back(),
                 style: ElevatedButton.styleFrom(
                   backgroundColor: AppPalette.accentBlue,
                   padding: const EdgeInsets.symmetric(vertical: 16),
                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                 ),
                 child: const Text('Apply Filters', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
               ),
             ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }
}

// Placeholder for AddProductScreen inside same file for now or separate?
// I'll make it separate.
class AddProductScreen extends GetView<BizController> {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF121212) : const Color(0xFFF9FAFB);
    final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: cardColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: textColor), // 'x' is common for modals/full screen forms on mobile
          onPressed: () => Get.back(),
        ),
        title: Text(
          'New Product',
          style: TextStyle(
            color: textColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Product Media
            _buildSection(
              title: 'Media',
              child: GestureDetector(
                onTap: () => controller.pickProductImage(),
                child: Obx(() => Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey[900] : Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isDark ? Colors.grey[800]! : Colors.grey[300]!,
                      width: 1,
                    ),
                    image: controller.selectedProductImage.value != null
                        ? DecorationImage(
                            image: FileImage(controller.selectedProductImage.value!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: controller.selectedProductImage.value == null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: isDark ? Colors.grey[800] : Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  if(!isDark) const BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0,2))
                                ]
                              ),
                              child: const Icon(Icons.add_a_photo_outlined, size: 32, color: AppPalette.accentBlue),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Tap to add image',
                              style: TextStyle(
                                color: isDark ? Colors.grey[400] : Colors.grey[600],
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        )
                      : const SizedBox.shrink(),
                )),
              ),
            ),
            const SizedBox(height: 24),

            // Product Details
            _buildSection(
              title: 'Details',
              child: Column(
                children: [
                  _buildTextField(label: 'Product Name', hint: 'e.g. Classic Denim Jacket', isDark: isDark),
                  const SizedBox(height: 16),
                  _buildTextField(label: 'Description', hint: 'Describe your product...', isDark: isDark, maxLines: 4),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Pricing & Inventory
            _buildSection(
              title: 'Pricing & Inventory',
              child: Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      label: 'Price', 
                      hint: '0.00', 
                      isDark: isDark, 
                      prefixIcon: Icons.attach_money,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildTextField(
                      label: 'Stock', 
                      hint: '0', 
                      isDark: isDark, 
                      prefixIcon: Icons.inventory_2_outlined,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
            ),
             const SizedBox(height: 24),

            // Organization
            _buildSection(
              title: 'Organization',
              child: Column(
                children: [
                   _buildDropdownField(label: 'Status', value: 'Active', isDark: isDark),
                   const SizedBox(height: 16),
                   _buildTextField(label: 'Category', hint: 'Select Category', isDark: isDark, suffixIcon: Icons.arrow_drop_down),
                ],
              ),
            ),
            const SizedBox(height: 100), // Space for bottom bar
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16) + MediaQuery.of(context).padding.copyWith(top: 0),
        decoration: BoxDecoration(
          color: cardColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () {
            Get.back();
            Get.snackbar('Success', 'Product published successfully', 
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green,
              colorText: Colors.white,
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppPalette.accentBlue,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          child: const Text('Publish Product'),
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
             fontSize: 16,
             fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        child,
      ],
    );
  }

  Widget _buildTextField({
    required String label, 
    required String hint, 
    required bool isDark, 
    int maxLines = 1,
    IconData? prefixIcon,
    IconData? suffixIcon,
    TextInputType? keyboardType,
  }) {
    final fillColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: isDark ? Colors.grey[400] : Colors.grey[700],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: fillColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              if(!isDark) BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 4, offset: const Offset(0, 2)),
            ],
          ),
          child: TextField(
            maxLines: maxLines,
            keyboardType: keyboardType,
            style: TextStyle(color: isDark ? Colors.white : Colors.black),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey[500]),
              prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: Colors.grey[500], size: 20) : null,
              suffixIcon: suffixIcon != null ? Icon(suffixIcon, color: Colors.grey[500]) : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.all(16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField({required String label, required String value, required bool isDark}) {
     final fillColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
     return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: isDark ? Colors.grey[400] : Colors.grey[700],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: fillColor,
            borderRadius: BorderRadius.circular(12),
             boxShadow: [
              if(!isDark) BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 4, offset: const Offset(0, 2)),
            ],
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              dropdownColor: fillColor,
              icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey[500]),
              underline: const SizedBox(),
              onChanged: (_) {},
              items: [
                DropdownMenuItem(
                  value: 'Active',
                  child: Text('Active', style: TextStyle(color: isDark ? Colors.white : Colors.black)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
