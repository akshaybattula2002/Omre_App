import 'package:flutter/material.dart';

class NewsSearchScreen extends StatelessWidget {
  const NewsSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search News')),
      body: const Center(child: Text('News Search Results')),
    );
  }
}
