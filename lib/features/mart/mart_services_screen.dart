import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/mart_services_controller.dart';


class MartServicesScreen extends GetView<MartServicesController> {
  const MartServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<MartServicesController>()) {
      Get.put(MartServicesController());
    }
    
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF101010) : Colors.grey[50];
    final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;
    final subtitleColor = isDark ? Colors.grey[400] : Colors.grey[600];

    return SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Hero Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, height: 1.2, color: textColor),
                      children: [
                        TextSpan(
                          text: 'One-Stop', 
                          style: TextStyle(
                            foreground: Paint()..shader = const LinearGradient(colors: [Colors.blue, Colors.purple]).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
                          ),
                        ),
                        const TextSpan(text: ' for All Local Businesses & Services Across India'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Primary Service Cards (2x2 Grid)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.4,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: controller.primaryServices.length,
                itemBuilder: (context, index) {
                  final service = controller.primaryServices[index];
                  return GestureDetector(
                    onTap: () => controller.onItemTap(service['title']),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(16),
                         boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          service['assetPath'] != null
                              ? Image.asset(service['assetPath'], width: 32, height: 32)
                              : Icon(service['icon'], size: 32, color: Colors.blueAccent),
                          const SizedBox(height: 12),
                          Text(service['title'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: textColor)),
                          const SizedBox(height: 4),
                          Text(service['subtitle'], style: TextStyle(fontSize: 12, color: subtitleColor), textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 24),

            // Time to Fly Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
               child: GestureDetector(
                 onTap: () => controller.onItemTap('Flight Offer'),
                 child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)]),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), shape: BoxShape.circle),
                        child: const Icon(Icons.flight, color: Colors.white, size: 28),
                      ),
                      const SizedBox(width: 16),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Time to Fly', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                          Text('at Lowest', style: TextStyle(color: Colors.white70, fontSize: 14)),
                        ],
                      ),
                      const Spacer(),
                      const Icon(Icons.arrow_forward_ios, color: Colors.white70, size: 16),
                    ],
                  ),
                 ),
               ),
            ),

            const SizedBox(height: 32),

            // Popular Categories
             Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(alignment: Alignment.centerLeft, child: Text('Popular Categories', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor))),
            ),
             const SizedBox(height: 16),
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 16.0),
               child: Obx(() => GridView.builder(
                 shrinkWrap: true,
                 physics: const NeverScrollableScrollPhysics(),
                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                   crossAxisCount: 2,
                   childAspectRatio: 2.5,
                   crossAxisSpacing: 12,
                   mainAxisSpacing: 12,
                 ),
                 itemCount: controller.popularCategories.length,
                 itemBuilder: (context, index) {
                   final cat = controller.popularCategories[index];
                   return GestureDetector(
                     onTap: () => controller.onItemTap(cat['name']),
                     child: Container(
                       padding: const EdgeInsets.symmetric(horizontal: 12),
                       decoration: BoxDecoration(
                         color: cardColor,
                         borderRadius: BorderRadius.circular(12),
                         border: Border.all(color: Colors.grey.withOpacity(0.1)),
                       ),
                       child: Row(
                         children: [
                           Icon(cat['icon'], size: 20, color: Colors.blueAccent),
                           const SizedBox(width: 12),
                           Expanded(child: Text(cat['name'], style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: textColor), overflow: TextOverflow.ellipsis)),
                         ],
                       ),
                     ),
                   );
                 },
               )),
             ),

             const SizedBox(height: 32),

             // Service Categories
             Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(alignment: Alignment.centerLeft, child: Text('Service Categories', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor))),
            ),
             const SizedBox(height: 16),
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 16.0),
               child: Obx(() => GridView.builder(
                 shrinkWrap: true,
                 physics: const NeverScrollableScrollPhysics(),
                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                   crossAxisCount: 2,
                   childAspectRatio: 1.5,
                   crossAxisSpacing: 16,
                   mainAxisSpacing: 16,
                 ),
                 itemCount: controller.serviceCategories.length,
                 itemBuilder: (context, index) {
                   final cat = controller.serviceCategories[index];
                   return GestureDetector(
                     onTap: () => controller.onItemTap(cat['name']),
                     child: Container(
                       padding: const EdgeInsets.all(16),
                       decoration: BoxDecoration(
                         gradient: LinearGradient(colors: cat['colors']),
                         borderRadius: BorderRadius.circular(16),
                       ),
                       child: Center(
                         child: Text(
                           cat['name'],
                           textAlign: TextAlign.center,
                           style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                         ),
                       ),
                     ),
                   );
                 },
               )),
             ),

             const SizedBox(height: 32),

             // Product Categories
             Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(alignment: Alignment.centerLeft, child: Text('Product Categories', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor))),
            ),
             const SizedBox(height: 16),
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 16.0),
               child: Obx(() => GridView.builder(
                 shrinkWrap: true,
                 physics: const NeverScrollableScrollPhysics(),
                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                   crossAxisCount: 2,
                   childAspectRatio: 3,
                   crossAxisSpacing: 12,
                   mainAxisSpacing: 12,
                 ),
                 itemCount: controller.productCategories.length,
                 itemBuilder: (context, index) {
                   final cat = controller.productCategories[index];
                   return GestureDetector(
                     onTap: () => controller.onItemTap(cat),
                     child: Container(
                       alignment: Alignment.center,
                       decoration: BoxDecoration(
                         color: cardColor,
                         borderRadius: BorderRadius.circular(12),
                         border: Border.all(color: Colors.grey.withOpacity(0.1)),
                       ),
                       child: Text(cat, style: TextStyle(fontWeight: FontWeight.w500, color: textColor)),
                     ),
                   );
                 },
               )),
             ),

             const SizedBox(height: 40),
          ],
        ),
      );
  }
}
