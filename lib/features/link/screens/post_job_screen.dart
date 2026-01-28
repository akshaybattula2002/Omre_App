import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/link_controller.dart';
import '../../../../core/theme/palette.dart';

class PostJobScreen extends StatelessWidget {
  const PostJobScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    // Form controllers
    final titleController = TextEditingController();
    final companyController = TextEditingController();
    final locationController = TextEditingController();
    final salaryController = TextEditingController();
    final descriptionController = TextEditingController();

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Post a Job'),
        centerTitle: true,
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.iconTheme.color),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Create a Job Post',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Reach thousands of qualified candidates.',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 32),

            _buildTextField('Job Title', 'e.g. Senior Frontend Engineer', titleController, isDark),
            const SizedBox(height: 20),
            _buildTextField('Company Name', 'e.g. TechFlow', companyController, isDark),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: _buildTextField('Location', 'e.g. Remote / NYC', locationController, isDark)),
                const SizedBox(width: 16),
                Expanded(child: _buildTextField('Salary Range', 'e.g. \$120k - \$150k', salaryController, isDark)),
              ],
            ),
            const SizedBox(height: 20),
            
            // Job Type Dropdown (Mock)
            const Text('Job Type', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E1E1E) : Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: isDark ? Colors.grey[800]! : Colors.grey[200]!),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: 'Full-time',
                  isExpanded: true,
                  dropdownColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                  items: ['Full-time', 'Part-time', 'Contract', 'Internship'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: TextStyle(color: isDark ? Colors.white : Colors.black)),
                    );
                  }).toList(),
                  onChanged: (_) {},
                ),
              ),
            ),

            const SizedBox(height: 20),
            _buildTextField('Description', 'Describe the role, responsibilities, and requirements...', descriptionController, isDark, maxLines: 6),

            const SizedBox(height: 40),
            
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  if (titleController.text.isEmpty || companyController.text.isEmpty) {
                    Get.snackbar('Error', 'Please fill in all required fields', backgroundColor: Colors.redAccent, colorText: Colors.white);
                    return;
                  }

                  final newJob = JobModel(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    title: titleController.text,
                    company: companyController.text,
                    location: locationController.text.isEmpty ? 'Remote' : locationController.text,
                    salary: salaryController.text.isEmpty ? '\$Competitive' : salaryController.text,
                    type: 'Full-time', // Simplified for demo
                    description: descriptionController.text.isEmpty ? 'No description provided.' : descriptionController.text,
                    themeColor: AppPalette.accentBlue,
                    postedAgo: 'Just now',
                    requirements: [],
                  );

                  final controller = Get.find<LinkController>();
                  controller.addJob(newJob);
                  
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppPalette.accentBlue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                ),
                child: const Text('Post Job Now', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String hint, TextEditingController controller, bool isDark, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E1E1E) : Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: isDark ? Colors.grey[800]! : Colors.grey[200]!),
          ),
          child: TextField(
            controller: controller,
            maxLines: maxLines,
            style: TextStyle(color: isDark ? Colors.white : Colors.black),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey[500], fontSize: 14),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
