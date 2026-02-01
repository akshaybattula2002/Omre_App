import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_assets.dart'; // Assuming this exists or I'll use placeholders
import 'controllers/games_controller.dart';

class GameVerseScreen extends GetView<GamesController> {
  const GameVerseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensure controller is loaded if not already
    final controller = Get.put(GamesController()); 
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;
    final subtitleColor = isDark ? Colors.grey[400] : Colors.grey[600];

    return Container(
      color: isDark ? const Color(0xFF121212) : Colors.grey[50],
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('GameVerse', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: textColor)),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text('LVL 42', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 10)),
                          ),
                        ],
                      ),
                      Text('Discover games, squads, and live streams', style: TextStyle(color: subtitleColor, fontSize: 14)),
                    ],
                  ),
                ],
              ),
            ),

            // Search + Action Row
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      height: 48,
                      decoration: BoxDecoration(
                        color: isDark ? Colors.grey[800] : Colors.grey[200],
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.search, color: subtitleColor),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text('Search games, players, or clips', style: TextStyle(color: subtitleColor)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: controller.onGoLive,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(color: Colors.red.withOpacity(0.4), blurRadius: 8, offset: const Offset(0, 4)),
                        ],
                      ),
                      child: Row(
                        children: [
                          Image.asset('assets/images/video_icon_3d.png', width: 24, height: 24),
                          const SizedBox(width: 4),
                          const Text('Go Live', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Quick Action Cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: controller.quickActions.map((action) {
                  return GestureDetector(
                    onTap: () => controller.onQuickActionTap(action['title']),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isDark ? Colors.grey[900] : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5)),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: (action['color'] as Color).withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(action['icon'] as IconData, color: action['color'] as Color),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(action['title'], style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: textColor)),
                              Text(action['subtitle'], style: TextStyle(fontSize: 13, color: subtitleColor)),
                            ],
                          ),
                          const Spacer(),
                          Icon(Icons.arrow_forward_ios, size: 16, color: subtitleColor),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 24),

            // Live Now Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('Live Now', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor)),
            ),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Obx(() => Row(
                children: controller.liveStreams.map((stream) {
                  return GestureDetector(
                    onTap: () => controller.onWatchLive(stream),
                    child: Container(
                      margin: const EdgeInsets.only(right: 16),
                      width: 260,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.asset(stream['image'], height: 160, width: 260, fit: BoxFit.cover),
                              ),
                              Positioned(
                                top: 8,
                                left: 8,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(8)),
                                  child: const Text('LIVE', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10)),
                                ),
                              ),
                              Positioned(
                                bottom: 8,
                                left: 8,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(8)),
                                  child: Text(stream['viewers'], style: const TextStyle(color: Colors.white, fontSize: 12)),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              CircleAvatar(radius: 16, backgroundImage: AssetImage(stream['avatar'])),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(stream['streamer'], style: TextStyle(fontWeight: FontWeight.bold, color: textColor)),
                                    Text(stream['game'], style: TextStyle(color: subtitleColor, fontSize: 12)),
                                  ],
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () => controller.onWatchLive(stream),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueAccent,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  minimumSize: Size.zero, 
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: const Text('Watch'),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }).toList(),
              )),
            ),

            const SizedBox(height: 28),

            // Categories Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('Categories', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor)),
            ),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Obx(() => Row(
                children: controller.categories.map((category) {
                  final isSelected = controller.selectedCategory.value == category;
                   return Padding(
                     padding: const EdgeInsets.only(right: 8),
                     child: ChoiceChip(
                       label: Text(category),
                       selected: isSelected,
                       onSelected: (selected) => controller.selectCategory(category),
                       backgroundColor: isDark ? Colors.grey[800] : Colors.grey[200],
                       selectedColor: Colors.blueAccent,
                       labelStyle: TextStyle(
                         color: isSelected ? Colors.white : textColor,
                         fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                       ),
                       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24), side: BorderSide.none),
                       showCheckmark: false,
                     ),
                   );
                }).toList(),
              )),
            ),

            const SizedBox(height: 28),

            // Top Picks For You
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('Top Picks For You', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor)),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Obx(() => GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.8,
                ),
                itemCount: controller.topPicks.length,
                itemBuilder: (context, index) {
                  final game = controller.topPicks[index];
                  return GestureDetector(
                    onTap: () => controller.onGameTap(game['name']),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isDark ? Colors.grey[900] : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5)),
                        ],
                      ),
                      child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Expanded(
                             child: ClipRRect(
                               borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                               child: Image.asset(game['image'], width: double.infinity, fit: BoxFit.cover),
                             ),
                           ),
                           Padding(
                             padding: const EdgeInsets.all(12),
                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Text(game['name'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: textColor), maxLines: 1, overflow: TextOverflow.ellipsis),
                                 const SizedBox(height: 4),
                                 Row(
                                   children: [
                                     Icon(Icons.thumb_up, size: 14, color: Colors.blueAccent),
                                     const SizedBox(width: 4),
                                     Text(game['likes'], style: TextStyle(fontSize: 12, color: subtitleColor)),
                                   ],
                                 ),
                                  const SizedBox(height: 4),
                                 Text(game['players'], style: TextStyle(fontSize: 12, color: Colors.greenAccent)),
                               ],
                             ),
                           ),
                         ],
                      ),
                    ),
                  );
                },
              )),
            ),

            const SizedBox(height: 28),

            // Trending Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('Trending', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor)),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Obx(() => Column(
                children: controller.trendingGames.map((game) {
                  return GestureDetector(
                    onTap: () => controller.onGameTap(game['name']),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                       color: Colors.transparent, 
                       child: Row(
                         children: [
                           Text(
                             '#${game['rank']}', 
                             style: TextStyle(
                               fontSize: 18, 
                               fontWeight: FontWeight.bold, 
                               color: (game['rank'] <= 3) ? Colors.amber : subtitleColor
                             )
                           ),
                           const SizedBox(width: 16),
                           Container(
                             padding: const EdgeInsets.all(10),
                             decoration: BoxDecoration(
                               color: isDark ? Colors.grey[800] : Colors.grey[100],
                               borderRadius: BorderRadius.circular(12),
                             ),
                             child: Icon(game['icon'], color: Colors.blueAccent),
                           ),
                           const SizedBox(width: 16),
                           Expanded(
                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Text(game['name'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: textColor)),
                                 Text(game['plays'], style: TextStyle(color: subtitleColor, fontSize: 12)),
                               ],
                             ),
                           ),
                           Icon(Icons.chevron_right, color: subtitleColor),
                         ],
                       ),
                    ),
                  );
                }).toList(),
              )),
            ),
            const SizedBox(height: 40), 
          ],
        ),
      ),
    );
  }
}
