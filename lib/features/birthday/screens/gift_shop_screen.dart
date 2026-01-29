import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_assets.dart';

class GiftShopScreen extends StatelessWidget {
  const GiftShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    final gifts = [
       {'name': 'Birthday Cake', 'price': '\$5.00', 'img': '🎂'},
       {'name': 'Flower Bouquet', 'price': '\$15.00', 'img': '💐'},
       {'name': 'Gift Box', 'price': '\$10.00', 'img': '🎁'},
       {'name': 'Chocolates', 'price': '\$8.00', 'img': '🍫'},
       {'name': 'Teddy Bear', 'price': '\$20.00', 'img': '🧸'},
       {'name': 'Party Hat', 'price': '\$2.00', 'img': '🥳'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gift Shop'),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: gifts.length,
        itemBuilder: (context, index) {
          final gift = gifts[index];
          return Container(
            decoration: BoxDecoration(
              color: isDark ? Colors.grey[800] : Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: const Offset(0, 2))],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(gift['img'] as String, style: const TextStyle(fontSize: 60)),
                const SizedBox(height: 12),
                Text(gift['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(gift['price'] as String, style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    Get.snackbar('Sent!', 'You sent a ${gift['name']}!', snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green, colorText: Colors.white);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  child: const Text('Send'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
