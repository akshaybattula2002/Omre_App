import 'package:flutter/material.dart';
import '../../core/constants/app_assets.dart';
import 'package:get/get.dart';

// --- SALARY INSIGHTS ---
class SalaryDetailScreen extends StatelessWidget {
  final String title;
  final String range;

  const SalaryDetailScreen({super.key, required this.title, required this.range});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Average Base Salary', style: TextStyle(color: Colors.grey[600])),
            const SizedBox(height: 8),
            Text(range, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.green)),
            const SizedBox(height: 24),
            const Text('Salary Distribution', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Container(height: 200, width: double.infinity, color: Colors.blue.withOpacity(0.1), child: const Center(child: Text('Chart Placeholder', style: TextStyle(color: Colors.blue)))),
            const SizedBox(height: 24),
            const Text('Top Companies for this Role', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
             _buildCompanySalary('Google', '\$180k'),
             _buildCompanySalary('Meta', '\$175k'),
             _buildCompanySalary('Amazon', '\$165k'),
          ],
        ),
      ),
    );
  }

  Widget _buildCompanySalary(String company, String salary) {
    return ListTile(title: Text(company), trailing: Text(salary, style: const TextStyle(fontWeight: FontWeight.bold)), contentPadding: EdgeInsets.zero);
  }
}

// --- RESUME BUILDER ---
class TemplateSelectionScreen extends StatelessWidget {
  const TemplateSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Template')),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        children: [
          _buildTemplate(context, 'Modern', Colors.blue),
          _buildTemplate(context, 'Professional', Colors.grey),
          _buildTemplate(context, 'Creative', Colors.purple),
          _buildTemplate(context, 'Simple', Colors.green),
        ],
      ),
    );
  }

  Widget _buildTemplate(BuildContext context, String name, Color color) {
    return Card(
      child: InkWell(
        onTap: () {
          Get.to(() => const ResumeEditorScreen());
          Get.snackbar('Resume', 'Selected $name template');
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.description, size: 60, color: color),
            const SizedBox(height: 12),
            Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

class ResumeEditorScreen extends StatelessWidget {
  const ResumeEditorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Resume'), actions: [TextButton(onPressed: () => Get.snackbar('Success', 'Resume Saved!'), child: const Text('Save'))]),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          TextField(decoration: InputDecoration(labelText: 'Full Name', border: OutlineInputBorder())),
          SizedBox(height: 16),
          TextField(decoration: InputDecoration(labelText: 'Professional Summary', border: OutlineInputBorder()), maxLines: 4),
          SizedBox(height: 16),
          TextField(decoration: InputDecoration(labelText: 'Experience', border: OutlineInputBorder()), maxLines: 6),
        ],
      ),
    );
  }
}

// --- PORTFOLIO CREATE ---
class PortfolioPreviewScreen extends StatelessWidget {
  const PortfolioPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Portfolio Preview')),
      body: const Center(child: Text('Your portfolio looks amazing!')),
    );
  }
}

// --- COVER LETTER ---
class GeneratedCoverLetterScreen extends StatelessWidget {
  const GeneratedCoverLetterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Generated Letter')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(8)),
                child: const SingleChildScrollView(child: Text('Dear Hiring Manager,\n\nI am writing to express my interest...')),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: OutlinedButton(onPressed: () {}, child: const Text('Edit'))),
                const SizedBox(width: 16),
                Expanded(child: ElevatedButton(onPressed: () => Get.snackbar('Success', 'Downloaded PDF'), child: const Text('Download'))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// --- AI HEADSHOT ---
class AiHeadshotProcessingScreen extends StatelessWidget {
  const AiHeadshotProcessingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Simulate processing delay
    Future.delayed(const Duration(seconds: 3), () {
        if(Get.currentRoute != '/AiHeadshotResultScreen') {
           Get.off(() => const AiHeadshotResultScreen());
        }
    });

    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('AI is generating your headshots...'),
          ],
        ),
      ),
    );
  }
}

class AiHeadshotResultScreen extends StatelessWidget {
  const AiHeadshotResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Headshots')),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        children: List.generate(4, (index) => Card(margin: const EdgeInsets.all(8), color: Colors.grey[300], child: const Icon(Icons.person, size: 64))),
      ),
      bottomNavigationBar: Padding(padding: const EdgeInsets.all(16), child: ElevatedButton(onPressed: () => Get.snackbar('Success', 'Headshots saved to gallery'), child: const Text('Save All'))),
    );
  }
}

// --- ATS CHECKER ---
class AtsResultScreen extends StatelessWidget {
  const AtsResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan Results')),
      body: const Center(child: Text('Scan Complete: 85/100')),
    );
  }
}
