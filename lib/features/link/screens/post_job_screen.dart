import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/link_controller.dart';
import '../../../../core/theme/palette.dart';

class PostJobScreen extends StatefulWidget {
  const PostJobScreen({super.key});

  @override
  State<PostJobScreen> createState() => _PostJobScreenState();
}

class _PostJobScreenState extends State<PostJobScreen> {
  final _titleController = TextEditingController();
  final _companyController = TextEditingController();
  final _locationController = TextEditingController();
  final _salaryController = TextEditingController();
  final _descriptionController = TextEditingController();

  String _selectedJobType = 'Full-time';
  final List<String> _jobTypes = ['Full-time', 'Part-time', 'Contract', 'Internship', 'Freelance'];

  String _selectedCategory = 'Engineering';
  final List<String> _categories = [
    'Engineering',
    'Design',
    'Marketing',
    'Sales',
    'Product',
    'HR',
    'Operations',
    'Education',
    'General'
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _companyController.dispose();
    _locationController.dispose();
    _salaryController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

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

            _buildTextField('Job Title', 'e.g. Senior Frontend Engineer', _titleController, isDark),
            const SizedBox(height: 20),
            _buildTextField('Company Name', 'e.g. TechFlow', _companyController, isDark),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: _buildTextField('Location', 'e.g. Remote / NYC', _locationController, isDark)),
                const SizedBox(width: 16),
                Expanded(child: _buildTextField('Salary Range', 'e.g. \$120k - \$150k', _salaryController, isDark)),
              ],
            ),
            const SizedBox(height: 20),
            
            // Job Type Dropdown
            _buildDropdown(
              label: 'Job Type',
              value: _selectedJobType,
              items: _jobTypes,
              onChanged: (val) => setState(() => _selectedJobType = val!),
              isDark: isDark,
            ),

            const SizedBox(height: 20),

            // Category Dropdown
            _buildDropdown(
              label: 'Category',
              value: _selectedCategory,
              items: _categories,
              onChanged: (val) => setState(() => _selectedCategory = val!),
              isDark: isDark,
            ),

            const SizedBox(height: 20),
            _buildTextField('Description', 'Describe the role, responsibilities, and requirements...', _descriptionController, isDark, maxLines: 6),

            const SizedBox(height: 40),
            
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _submitJob,
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

  void _submitJob() {
    if (_titleController.text.isEmpty || _companyController.text.isEmpty) {
      Get.snackbar('Error', 'Please fill in all required fields', backgroundColor: Colors.redAccent, colorText: Colors.white);
      return;
    }

    // Assign a random theme color for visual variety
    final colors = [Colors.blue, Colors.teal, Colors.orange, Colors.purple, Colors.indigo, Colors.green];
    final randomColor = (colors..shuffle()).first;

    final newJob = JobModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: _titleController.text,
      company: _companyController.text,
      location: _locationController.text.isEmpty ? 'Remote' : _locationController.text,
      salary: _salaryController.text.isEmpty ? 'Competitive' : _salaryController.text,
      type: _selectedJobType,
      category: _selectedCategory,
      description: _descriptionController.text.isEmpty ? 'No description provided.' : _descriptionController.text,
      themeColor: randomColor,
      postedAgo: 'Just now',
      requirements: ['Experience with Flutter', 'Strong communication skills'], // Default reqs for now
      companyDescription: '${_companyController.text} is a leading company in the ${_selectedCategory} space.',
    );

    final controller = Get.find<LinkController>();
    controller.addJob(newJob);
    
    Get.back();
    Get.snackbar(
      'Success', 
      'Job posted successfully!', 
      backgroundColor: Colors.green, 
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM
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

  Widget _buildDropdown({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    required bool isDark,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
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
              value: value,
              isExpanded: true,
              dropdownColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
              items: items.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: TextStyle(color: isDark ? Colors.white : Colors.black)),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
