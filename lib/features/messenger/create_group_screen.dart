import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/services/mock_service.dart';
import '../../core/theme/palette.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final TextEditingController _nameController = TextEditingController();
  final Set<String> _selectedMembers = {};
  String _searchQuery = '';

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final filteredContacts = MockService.chats.where((c) => c.name.toLowerCase().contains(_searchQuery.toLowerCase())).toList();

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
      appBar: AppBar(
        title: const Text('New Group', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: _selectedMembers.isEmpty || _nameController.text.isEmpty
                ? null
                : () {
                    Get.back();
                    Get.snackbar('Group Created', 'Successfully created "${_nameController.text}"',
                        backgroundColor: Colors.green, colorText: Colors.white);
                  },
            child: Text('CREATE', style: TextStyle(
              color: _selectedMembers.isEmpty || _nameController.text.isEmpty 
                ? Colors.grey 
                : AppPalette.accentBlue, 
              fontWeight: FontWeight.bold
            )),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: AppPalette.accentBlue.withOpacity(0.2),
                  child: const Icon(Icons.camera_alt, color: AppPalette.accentBlue),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: _nameController,
                    onChanged: (val) => setState(() {}),
                    style: TextStyle(color: isDark ? Colors.white : Colors.black),
                    decoration: const InputDecoration(
                      hintText: 'Group Name',
                      border: UnderlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              onChanged: (val) => setState(() => _searchQuery = val),
              decoration: InputDecoration(
                hintText: 'Add members',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: isDark ? Colors.white10 : Colors.grey[100],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: filteredContacts.length,
              itemBuilder: (context, index) {
                final contact = filteredContacts[index];
                final isSelected = _selectedMembers.contains(contact.id);
                return CheckboxListTile(
                  value: isSelected,
                  onChanged: (val) {
                    setState(() {
                      if (val!) {
                        _selectedMembers.add(contact.id);
                      } else {
                        _selectedMembers.remove(contact.id);
                      }
                    });
                  },
                  title: Text(contact.name),
                  secondary: CircleAvatar(backgroundImage: AssetImage(contact.avatarUrl)),
                  activeColor: AppPalette.accentBlue,
                  checkboxShape: const CircleBorder(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
