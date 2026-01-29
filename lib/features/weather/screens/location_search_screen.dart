import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocationSearchScreen extends StatelessWidget {
  const LocationSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Search city...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: isDark ? Colors.white54 : Colors.black54),
          ),
          style: TextStyle(color: isDark ? Colors.white : Colors.black),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.my_location, color: Colors.blue),
            title: const Text('Use Current Location'),
            onTap: () {
               Get.back();
               Get.snackbar('Location Updated', 'Using current location', backgroundColor: Colors.blue, colorText: Colors.white);
            },
          ),
          const Divider(),
          _buildLocationItem('London, UK'),
          _buildLocationItem('New York, USA'),
          _buildLocationItem('Tokyo, Japan'),
          _buildLocationItem('Paris, France'),
          _buildLocationItem('Sydney, Australia'),
        ],
      ),
    );
  }

  Widget _buildLocationItem(String city) {
    return ListTile(
      leading: const Icon(Icons.location_on_outlined),
      title: Text(city),
      onTap: () {
        Get.back();
        Get.snackbar('Location Updated', 'Selected $city', backgroundColor: Colors.green, colorText: Colors.white);
      },
    );
  }
}
