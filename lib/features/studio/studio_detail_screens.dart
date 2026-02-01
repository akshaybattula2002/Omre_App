import 'package:flutter/material.dart';
import '../../core/constants/app_assets.dart';
import 'package:get/get.dart';

// --- SCRIPT GENERATOR RESULT ---
class ScriptResultScreen extends StatelessWidget {
  final String topic;
  final String tone;

  const ScriptResultScreen({super.key, required this.topic, required this.tone});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Generated Script'), actions: [
        IconButton(onPressed: () => Get.snackbar('Success', 'Script copied to clipboard'), icon: const Icon(Icons.copy)),
        IconButton(onPressed: () => Get.snackbar('Success', 'Script saved to projects'), icon: const Icon(Icons.save)),
      ]),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Topic: $topic', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Text('Tone: $tone', style: TextStyle(color: Colors.grey[600], fontSize: 14)),
              const Divider(height: 32),
              const Text('[Intro]', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
              const Text('Hey everyone! Welcome back to the channel. Today we are diving deep into...'),
              const SizedBox(height: 16),
              const Text('[Body]', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
              const Text('First, let\'s talk about the key aspects...'),
              const SizedBox(height: 16),
              const Text('[Outro]', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
              const Text('If you enjoyed this video, don\'t forget to like and subscribe!'),
            ],
          ),
        ),
      ),
    );
  }
}

// --- IDEA DETAIL ---
class IdeaDetailScreen extends StatelessWidget {
  final String title;
  final String tag;
  final Color color;

  const IdeaDetailScreen({super.key, required this.title, required this.tag, required this.color});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Idea Details')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: color.withOpacity(0.3)),
              ),
              child: Column(
                children: [
                  Icon(Icons.lightbulb, size: 64, color: color),
                  const SizedBox(height: 16),
                  Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                  const SizedBox(height: 8),
                  Chip(label: Text(tag, style: const TextStyle(color: Colors.white)), backgroundColor: color),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Text('Why this idea?', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('Based on current trends, this topic has a high potential for engagement and viral reach.'),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () => Get.to(() => ScriptResultScreen(topic: title, tone: 'Engaging')),
                icon: const Icon(Icons.auto_awesome),
                label: const Text('Generate Script from Idea'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple, foregroundColor: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- SCHEDULER ADD/EDIT ---
class ScheduledItemEditorScreen extends StatelessWidget {
  final String? initialTitle;
  
  const ScheduledItemEditorScreen({super.key, this.initialTitle});

  @override
  Widget build(BuildContext context) {
    final isEditing = initialTitle != null;
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit Schedule' : 'Schedule Content')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title', border: const OutlineInputBorder(), hintText: isEditing ? null : 'e.g., New Vlog'),
              controller: isEditing ? TextEditingController(text: initialTitle) : null,
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(labelText: 'Date & Time', border: OutlineInputBorder(), suffixIcon: Icon(Icons.calendar_today)),
            ),
            const SizedBox(height: 16),
             DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Platform', border: OutlineInputBorder()),
              items: ['YouTube', 'Instagram', 'TikTok'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (v) {},
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Get.back();
                  Get.snackbar('Success', isEditing ? 'Schedule updated!' : 'Content scheduled!');
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white),
                child: Text(isEditing ? 'Update Schedule' : 'Schedule Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- SAFETY CHECK DETAIL ---
class SafetyDetailScreen extends StatelessWidget {
  final String title;
  final String status;
  final bool isGood;

  const SafetyDetailScreen({super.key, required this.title, required this.status, required this.isGood});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(isGood ? Icons.check_circle : Icons.warning, size: 80, color: isGood ? Colors.green : Colors.amber),
            const SizedBox(height: 16),
            Text(status, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: isGood ? Colors.green : Colors.amber)),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.grey.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
              child: Text(
                isGood 
                ? 'Great job! No issues detected with your content related to $title.'
                : 'Attention needed. Please review your content to comply with $title policies.',
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 32),
            if (!isGood)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white), child: const Text('Resolve Issue')),
              ),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(onPressed: () => Get.back(), child: const Text('Back')),
            ),
          ],
        ),
      ),
    );
  }
}
