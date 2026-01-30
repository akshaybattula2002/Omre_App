import 'package:flutter/material.dart';

class MartNearMeScreen extends StatelessWidget {
  const MartNearMeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Near Me')),
      body: const Center(child: Text('Near Me Items')),
    );
  }
}

class MartVerifiedScreen extends StatelessWidget {
  const MartVerifiedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verified Items')),
      body: const Center(child: Text('Verified Items')),
    );
  }
}

class MartTrendingScreen extends StatelessWidget {
  const MartTrendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Trending')),
      body: const Center(child: Text('Trending Items')),
    );
  }
}

class MartWholesaleScreen extends StatelessWidget {
  const MartWholesaleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wholesale')),
      body: const Center(child: Text('Wholesale Items')),
    );
  }
}

class MartSavedItemsScreen extends StatelessWidget {
  const MartSavedItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Saved Items')),
      body: const Center(child: Text('Saved Items')),
    );
  }
}

class MartEnquiriesScreen extends StatelessWidget {
  const MartEnquiriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Enquiries')),
      body: const Center(child: Text('My Enquiries')),
    );
  }
}

class MartRecentViewsScreen extends StatelessWidget {
  const MartRecentViewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recent Views')),
      body: const Center(child: Text('Recent Views')),
    );
  }
}
