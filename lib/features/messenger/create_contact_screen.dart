import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/palette.dart';
import '../../core/constants/app_assets.dart';

class CreateContactScreen extends StatefulWidget {
  const CreateContactScreen({super.key});

  @override
  State<CreateContactScreen> createState() => _CreateContactScreenState();
}

class _CreateContactScreenState extends State<CreateContactScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  String _selectedCountry = 'India (+91)';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
      appBar: AppBar(
        title: const Text('Add Contact', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.check, color: AppPalette.accentBlue),
            onPressed: () {
              Get.back();
              Get.snackbar('Contact Saved', '${_firstNameController.text} has been added.',
                  backgroundColor: Colors.green, colorText: Colors.white);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
             _buildTextField('First Name', Icons.person_outline, _firstNameController, isDark, assetPath: AppAssets.personalInfoIcon3d),
             const SizedBox(height: 20),
             _buildTextField('Last Name', Icons.person_outline, _lastNameController, isDark, assetPath: AppAssets.personalInfoIcon3d),
             const SizedBox(height: 20),
             Container(
               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
               decoration: BoxDecoration(
                 color: isDark ? Colors.white10 : Colors.grey[100],
                 borderRadius: BorderRadius.circular(12),
               ),
               child: DropdownButtonHideUnderline(
                 child: DropdownButton<String>(
                   value: _selectedCountry,
                   isExpanded: true,
                   dropdownColor: isDark ? Colors.grey[900] : Colors.white,
                   items: ['India (+91)', 'USA (+1)', 'UK (+44)', 'Canada (+1)']
                       .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                       .toList(),
                   onChanged: (val) => setState(() => _selectedCountry = val!),
                 ),
               ),
             ),
             const SizedBox(height: 20),
             _buildTextField('Phone Number', Icons.phone_outlined, _phoneController, isDark, keyboardType: TextInputType.phone),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, IconData icon, TextEditingController controller, bool isDark, {TextInputType? keyboardType, String? assetPath}) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: TextStyle(color: isDark ? Colors.white : Colors.black),
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: assetPath != null 
            ? Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(assetPath, width: 20, height: 20),
              )
            : Icon(icon, color: Colors.grey),
        filled: true,
        fillColor: isDark ? Colors.white10 : Colors.grey[100],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      ),
    );
  }
}
