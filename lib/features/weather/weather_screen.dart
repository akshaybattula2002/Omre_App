import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/location_search_screen.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Premium Gradients for Weather
    final gradientColors = isDark 
        ? [const Color(0xFF1A2344), const Color(0xFF0F1216)] // Deep Midnight Blue to Black
        : [const Color(0xFF2193b0), const Color(0xFF6dd5ed)]; // Cool Blue to Light Blue

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: GestureDetector(
          onTap: () => Get.to(() => const LocationSearchScreen()),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('San Francisco', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              const SizedBox(width: 4),
              const Icon(Icons.keyboard_arrow_down, color: Colors.white),
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white), 
            onPressed: () => Get.to(() => const LocationSearchScreen())
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradientColors,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 100, 20, 20),
          child: Column(
            children: [
              const Icon(Icons.cloud, size: 100, color: Colors.white),
              const SizedBox(height: 20),
              const Text('22°', style: TextStyle(fontSize: 80, color: Colors.white, fontWeight: FontWeight.w200)),
              const Text('Cloudy', style: TextStyle(fontSize: 24, color: Colors.white70)),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildWeatherStat('Wind', '12 km/h'),
                  _buildWeatherStat('Humidity', '45%'),
                  _buildWeatherStat('Rain', '10%'),
                ],
              ),
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withOpacity(0.2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Today', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 100,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          _buildForecastItem('Now', Icons.cloud, '22°'),
                          _buildForecastItem('1 PM', Icons.wb_sunny, '24°'),
                           _buildForecastItem('2 PM', Icons.wb_sunny, '25°'),
                          _buildForecastItem('3 PM', Icons.wb_cloudy, '23°'),
                          _buildForecastItem('4 PM', Icons.cloud, '21°'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeatherStat(String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(color: Colors.white70)),
      ],
    );
  }

  Widget _buildForecastItem(String time, IconData icon, String temp) {
    return Container(
      width: 60,
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(time, style: const TextStyle(color: Colors.white70)),
          const SizedBox(height: 8),
          Icon(icon, color: Colors.white),
          const SizedBox(height: 8),
          Text(temp, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
