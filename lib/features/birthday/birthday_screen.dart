import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_assets.dart';
import 'screens/gift_shop_screen.dart';
import '../friends/screens/friend_profile_screen.dart';

class BirthdayScreen extends StatelessWidget {
  const BirthdayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('Birthdays', style: TextStyle(color: theme.textTheme.bodyLarge?.color, fontWeight: FontWeight.bold)),
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.iconTheme.color),
          onPressed: () => Get.back(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
           Container(
             padding: const EdgeInsets.all(16),
             decoration: BoxDecoration(
               gradient: const LinearGradient(colors: [Color(0xFF6A11CB), Color(0xFF2575FC)]),
               borderRadius: BorderRadius.circular(16),
             ),
             child: Row(
               children: [
                 const Icon(Icons.cake, color: Colors.white, size: 40),
                 const SizedBox(width: 16),
                 const Expanded(
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text("Today's Birthdays", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                       Text("3 friends are celebrating today!", style: TextStyle(color: Colors.white70)),
                     ],
                   ),
                 ),
               ],
             ),
           ),
           const SizedBox(height: 24),
           Text('Recent & Upcoming', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: theme.textTheme.bodyLarge?.color)),
           const SizedBox(height: 16),
           _buildBirthdayItem('Sarah Williams', 'Turning 25 today', AppAssets.avatar1, AppAssets.cover1, isDark),
           _buildBirthdayItem('Mike Chen', 'Tomorrow', AppAssets.avatar2, AppAssets.cover2, isDark),
           _buildBirthdayItem('Emma Wilson', 'In 3 days', AppAssets.avatar3, AppAssets.cover3, isDark),
           
           const SizedBox(height: 32),
           _buildGiftCard(isDark),
        ],
      ),
    );
  }

  Widget _buildBirthdayItem(String name, String date, String img, String cover, bool isDark) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8),
      leading: GestureDetector(
        onTap: () => Get.to(() => FriendProfileScreen(name: name, image: img, cover: cover, isFriend: true)),
        child: CircleAvatar(radius: 28, backgroundImage: AssetImage(img)),
      ),
      title: Text(name, style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black)),
      subtitle: Text(date, style: const TextStyle(color: Colors.grey)),
      trailing: ElevatedButton(
        onPressed: () {
           Get.bottomSheet(
             Container(
               padding: const EdgeInsets.all(16),
               color: isDark ? const Color(0xFF242526) : Colors.white,
               child: Column(
                 mainAxisSize: MainAxisSize.min,
                 children: [
                   const Text('Write a birthday wish', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                   const SizedBox(height: 16),
                   TextField(
                     decoration: const InputDecoration(border: OutlineInputBorder(), hintText: 'Happy Birthday!'),
                     maxLines: 3,
                   ),
                   const SizedBox(height: 16),
                   ElevatedButton(onPressed: () => Get.back(), child: const Text('Post'))
                 ],
               ),
             )
           );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.pinkAccent,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        child: const Text('Wish'),
      ),
    );
  }

  Widget _buildGiftCard(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[900] : Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(Icons.card_giftcard, size: 40, color: Colors.pinkAccent),
          const SizedBox(height: 12),
          Text('Send a Digital Gift', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: isDark ? Colors.white : Colors.black)),
          const SizedBox(height: 8),
          const Text('Make their day special with a virtual gift card or surprise.', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Get.to(() => const GiftShopScreen());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.pinkAccent,
                side: const BorderSide(color: Colors.pinkAccent),
              ),
              child: const Text('Visit Gift Shop'),
            ),
          ),
        ],
      ),
    );
  }
}
