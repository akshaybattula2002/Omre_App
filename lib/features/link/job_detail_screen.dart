import 'package:flutter/material.dart';
import '../../core/constants/app_assets.dart';
import 'package:get/get.dart';

class JobDetailScreen extends StatelessWidget {
  final String title;
  final String company;
  final String location;
  final String time;
  final String description;

  const JobDetailScreen({
    super.key,
    required this.title,
    required this.company,
    required this.location,
    required this.time,
    this.description = 'We are looking for a skilled professional to join our dynamic team...',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(radius: 40, backgroundColor: Colors.grey[200], child: const Icon(Icons.business, size: 40, color: Colors.grey)),
                  const SizedBox(height: 16),
                  Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(company, style: const TextStyle(fontSize: 18, color: Colors.blue)),
                  Text(location, style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 8),
                  Text(time, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(child: ElevatedButton(onPressed: () => Get.snackbar('Job', 'Application started'), child: const Text('Apply Now'))),
                const SizedBox(width: 16),
                OutlinedButton(onPressed: () => Get.snackbar('Job', 'Saved to your jobs'), child: const Text('Save')),
              ],
            ),
            const SizedBox(height: 24),
            const Text('Job Description', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
             Text(
              description * 3, // Dummy long text
              style: TextStyle(color: Colors.grey[800], height: 1.5),
            ),
            const SizedBox(height: 24),
            const Text('Requirements', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
             const SizedBox(height: 8),
            _buildRequirement('Bachelor\'s degree in Computer Science or related field'),
            _buildRequirement('3+ years of experience in mobile development'),
            _buildRequirement('Proficient in Dart and Flutter'),
            _buildRequirement('Experience with REST APIs and state management'),
          ],
        ),
      ),
    );
  }

  Widget _buildRequirement(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, size: 16, color: Colors.green),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
