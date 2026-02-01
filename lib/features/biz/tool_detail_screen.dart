import 'package:flutter/material.dart';
import '../../core/theme/palette.dart';
import 'package:get/get.dart';

class ToolDetailScreen extends StatefulWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  const ToolDetailScreen({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });

  @override
  State<ToolDetailScreen> createState() => _ToolDetailScreenState();
}

class _ToolDetailScreenState extends State<ToolDetailScreen> {
  bool isEnabled = false;
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: widget.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Icon(widget.icon, size: 48, color: widget.color),
                  const SizedBox(height: 16),
                  Text(
                    widget.title,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.description,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            SwitchListTile(
              title: const Text('Enable Feature', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(isEnabled ? 'Currently active' : 'Currently inactive'),
              value: isEnabled,
              activeColor: widget.color,
              onChanged: (val) {
                setState(() {
                  isEnabled = val;
                });
                Get.snackbar('Settings', isEnabled ? '${widget.title} enabled' : '${widget.title} disabled');
              },
            ),
            const Divider(),
            if (widget.title != 'Labels') ...[
              const SizedBox(height: 16),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Custom Message', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _messageController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Enter your automated message here...',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: isDark ? Colors.white10 : Colors.grey[100],
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                    Get.snackbar('Success', 'Settings saved');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.color,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Save Changes'),
                ),
              ),
            ] else ...[
               // Specific UI for labels if needed, or placeholder
               const SizedBox(height: 16),
               Expanded(
                 child: ListView(
                   children: [
                     _buildLabelItem('New Customer', Colors.blue),
                     _buildLabelItem('Pending Payment', Colors.orange),
                     _buildLabelItem('Order Completed', Colors.green),
                     _buildLabelItem('VIP', Colors.purple),
                   ],
                 ),
               )
            ],
          ],
        ),
      ),
    );
  }
  
  Widget _buildLabelItem(String text, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(Icons.label, color: color),
        title: Text(text),
        trailing: IconButton(icon: const Icon(Icons.edit, size: 20), onPressed: (){}),
      ),
    );
  }
}
