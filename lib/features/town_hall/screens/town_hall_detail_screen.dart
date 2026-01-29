import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TownHallDetailScreen extends StatelessWidget {
  final String title;
  final String description;
  final String author;
  final String time;

  const TownHallDetailScreen({
    super.key,
    required this.title,
    required this.description,
    required this.author,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(title: const Text('Discussion'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(backgroundColor: Colors.grey, child: Text(author[0])),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(author, style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(time, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Text(description, style: const TextStyle(fontSize: 16, height: 1.5)),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[900] : Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Poll Results', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 12),
                  _buildPollBar('Approve', 0.7, Colors.green),
                  const SizedBox(height: 8),
                  _buildPollBar('Reject', 0.3, Colors.red),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Get.snackbar('Voted', 'Your vote has been recorded', backgroundColor: Colors.green, colorText: Colors.white);
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white),
                    child: const Text('Cast Your Vote'),
                  ),
                ],
              ),
            ),
             const SizedBox(height: 24),
            const Text('Comments', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(radius: 16, backgroundColor: Colors.grey[300]),
                  title: Text('Citizen ${index + 1}'),
                  subtitle: const Text('I agree with this motion completely. It will help our community grow.'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPollBar(String label, double percent, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             Text(label),
             Text('${(percent * 100).toInt()}%'),
          ],
        ),
        const SizedBox(height: 4),
        LinearProgressIndicator(value: percent, color: color, backgroundColor: color.withOpacity(0.2), minHeight: 8, borderRadius: BorderRadius.circular(4)),
      ],
    );
  }
}
