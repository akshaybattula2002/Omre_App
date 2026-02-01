import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WebsitePreviewScreen extends StatelessWidget {
  const WebsitePreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Live Preview')),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              color: Colors.blue,
              width: double.infinity,
              child: const Column(
                children: [
                  Text('My Awesome Business', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                  Text('Best products in town', style: TextStyle(color: Colors.white70)),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.shopping_bag, size: 80, color: Colors.blue[100]),
                    const SizedBox(height: 20),
                    const Text('Content goes here...', style: TextStyle(fontSize: 18, color: Colors.grey)),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.grey[100],
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('© 2024 My Business'),
                  Icon(Icons.camera_alt),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WebsiteSettingsScreen extends StatelessWidget {
  const WebsiteSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildScaffold('Site Settings', Column(
      children: [
        _buildTextField('Site Title', 'My Awesome Business'),
        const SizedBox(height: 16),
        _buildTextField('Site Description', 'We sell the best products...', maxLines: 3),
        const SizedBox(height: 16),
        _buildTextField('Contact Email', 'contact@business.com'),
      ],
    ));
  }

  Widget _buildTextField(String label, String initialValue, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextFormField(
          initialValue: initialValue,
          maxLines: maxLines,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ],
    );
  }
}

class WebsiteThemeScreen extends StatefulWidget {
  const WebsiteThemeScreen({super.key});

  @override
  State<WebsiteThemeScreen> createState() => _WebsiteThemeScreenState();
}

class _WebsiteThemeScreenState extends State<WebsiteThemeScreen> {
  Color _selectedColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return _buildScaffold('Theme & Colors', Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Primary Color', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 16),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            Colors.blue, Colors.red, Colors.green, Colors.orange, Colors.purple, Colors.teal
          ].map((color) => GestureDetector(
            onTap: () => setState(() => _selectedColor = color),
            child: CircleAvatar(
              backgroundColor: color,
              radius: 24,
              child: _selectedColor == color ? const Icon(Icons.check, color: Colors.white) : null,
            ),
          )).toList(),
        ),
        const SizedBox(height: 32),
        const Text('Font Style', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          value: 'Modern',
          items: ['Modern', 'Classic', 'Playful', 'Minimalist'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: (val) {},
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ],
    ));
  }
}

class WebsitePagesScreen extends StatelessWidget {
  const WebsitePagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildScaffold('Pages', ListView(
      children: [
        _buildPageItem('Home', true),
        _buildPageItem('Shop', true),
        _buildPageItem('About Us', true),
        _buildPageItem('Contact', true),
        _buildPageItem('Blog', false),
        const SizedBox(height: 16),
        OutlinedButton.icon(
          onPressed: () {
            Get.snackbar('Pages', 'New page added');
          },
          icon: const Icon(Icons.add),
          label: const Text('Add New Page'),
        ),
      ],
    ));
  }

  Widget _buildPageItem(String title, bool isVisible) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.article_outlined),
        title: Text(title),
        trailing: Switch(value: isVisible, onChanged: (v) {}),
      ),
    );
  }
}

class WebsiteDomainScreen extends StatelessWidget {
  const WebsiteDomainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildScaffold('Domain', Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Your Subdomain', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                initialValue: 'my-business',
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Text('.omre.site', style: TextStyle(fontSize: 16, color: Colors.grey)),
          ],
        ),
        const SizedBox(height: 32),
        const Text('Custom Domain', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(
            hintText: 'e.g. www.mybusiness.com',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            suffixIcon: TextButton(onPressed: () {}, child: const Text('Connect')),
          ),
        ),
      ],
    ));
  }
}

// Scaffolding Helper
Widget _buildScaffold(String title, Widget body) {
  return Scaffold(
    appBar: AppBar(title: Text(title)),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(child: body),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Get.back();
                Get.snackbar('Success', '$title updated successfully!');
              },
              child: const Text('Save Changes'),
            ),
          ),
        ],
      ),
    ),
  );
}
