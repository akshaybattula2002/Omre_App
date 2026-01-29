import 'package:flutter/material.dart';

class GamesWebBasedScreen extends StatelessWidget {
  const GamesWebBasedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Web Based Games')),
      body: const Center(child: Text('Play games directly in your browser.')),
    );
  }
}

class GamesHTML5Screen extends StatelessWidget {
  const GamesHTML5Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HTML5 Games')),
      body: const Center(child: Text('A collection of lightweight HTML5 games.')),
    );
  }
}

class GamesActivityScreen extends StatelessWidget {
  const GamesActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gaming Activity')),
      body: const Center(child: Text('Track your achievements and playtime.')),
    );
  }
}
