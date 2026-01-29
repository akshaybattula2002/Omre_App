import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/orbit_controller.dart';

class OrbitCreateTopicScreen extends StatefulWidget {
  const OrbitCreateTopicScreen({super.key});

  @override
  State<OrbitCreateTopicScreen> createState() => _OrbitCreateTopicScreenState();
}

class _OrbitCreateTopicScreenState extends State<OrbitCreateTopicScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final OrbitController controller = Get.find();
  
  String _selectedCategory = 'Tech'; // Default
  
  @override
  void initState() {
    super.initState();
    // Ensure we have a valid initial category from the controller if available, 
    // skipping 'All' if possible, or just default to Tech.
    if (controller.categories.contains('Tech')) {
      _selectedCategory = 'Tech';
    } else if (controller.categories.length > 1) {
      _selectedCategory = controller.categories[1]; // Skip 'All'
    }
  }

  void _submitTopic(Color cardColor, Color textPrimary, Color accentBlue) {
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();

    if (title.isEmpty || description.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill in all fields',
        backgroundColor: cardColor,
        colorText: textPrimary,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final newTopic = OrbitTopic(
      title: title,
      description: description,
      category: _selectedCategory,
      status: 'Active', // Default status for new topics
      liveUsers: 1, // Starter count
      languages: ['EN'], // Default language
      isVerified: false,
    );

    controller.addTopic(newTopic);
    Get.back();
    Get.snackbar(
      'Success',
      'Topic "$title" created!',
      backgroundColor: cardColor,
      colorText: textPrimary,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Theme-aware colors
    final bgColor = theme.scaffoldBackgroundColor;
    final cardColor = isDark ? const Color(0xFF1A1A1D) : Colors.white;
    final accentBlue = isDark ? const Color(0xFF2962FF) : theme.primaryColor;
    final textPrimary = theme.textTheme.bodyLarge?.color ?? (isDark ? Colors.white : Colors.black);
    final textSecondary = theme.textTheme.bodyMedium?.color?.withOpacity(0.7) ?? (isDark ? const Color(0xFFB0BEC5) : Colors.black54);

    // Filter out 'All' for creation
    final selectableCategories = controller.categories.where((c) => c != 'All').toList();

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        title: Text('Create Topic', style: TextStyle(color: textPrimary, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textSecondary),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLabel('Topic Title', textSecondary),
            _buildTextField(_titleController, 'Ex: Quantum Physics Discussion', cardColor, textPrimary, textSecondary),
            const SizedBox(height: 20),
            
            _buildLabel('Category', textSecondary),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: (isDark ? Colors.white : Colors.black).withOpacity(0.1)),
                boxShadow: [
                  if (!isDark) BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
                ],
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedCategory,
                  dropdownColor: cardColor,
                  isExpanded: true,
                  icon: Icon(Icons.keyboard_arrow_down, color: textSecondary),
                  style: TextStyle(color: textPrimary, fontSize: 16),
                  items: selectableCategories.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    if (newValue != null) {
                      setState(() {
                        _selectedCategory = newValue;
                      });
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),

            _buildLabel('Description', textSecondary),
            _buildTextField(_descriptionController, 'What is this topic about?', cardColor, textPrimary, textSecondary, maxLines: 4),
            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () => _submitTopic(cardColor, textPrimary, accentBlue),
                style: ElevatedButton.styleFrom(
                  backgroundColor: accentBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                ),
                child: const Text(
                  'Create Topic',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text, Color textSecondary) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: TextStyle(
          color: textSecondary,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, Color cardColor, Color textPrimary, Color textSecondary, {int maxLines = 1}) {
    final isDark = Theme.of(Get.context!).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: (isDark ? Colors.white : Colors.black).withOpacity(0.1)),
        boxShadow: [
          if (!isDark) BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        style: TextStyle(color: textPrimary),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: textSecondary.withOpacity(0.5)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }
}
