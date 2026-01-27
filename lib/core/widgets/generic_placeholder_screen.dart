import 'package:flutter/material.dart';

class GenericPlaceholderScreen extends StatelessWidget {
  final String title;
  final IconData? icon;

  const GenericPlaceholderScreen({
    super.key, 
    required this.title,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon ?? Icons.construction, 
              size: 80, 
              color: Theme.of(context).primaryColor.withOpacity(0.5),
            ),
            const SizedBox(height: 20),
            Text(
              '$title Screen',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 10),
            Text(
              'This feature is coming soon!',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
