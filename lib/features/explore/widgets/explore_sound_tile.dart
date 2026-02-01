import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_assets.dart';

class ExploreSoundTile extends StatelessWidget {
  final Map<String, dynamic> sound;
  final bool isDark;
  final VoidCallback? onPlay;
  final VoidCallback? onSave;

  const ExploreSoundTile({
    super.key, 
    required this.sound, 
    required this.isDark,
    this.onPlay,
    this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: ListTile(
        leading: GestureDetector(
          onTap: onPlay,
          child: Obx(() {
            final rxIsPlaying = sound['isPlaying'];
            final isPlaying = rxIsPlaying is RxBool ? rxIsPlaying.value : false;
             return Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.blueAccent.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isPlaying ? Icons.pause : Icons.play_arrow, 
                color: Colors.blueAccent
              ),
            );
          }),
        ),
        title: Text(
          sound['title'],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        subtitle: Text(
          '${sound['usage']} • ${sound['duration']}',
          style: TextStyle(
            fontSize: 12,
            color: isDark ? Colors.grey[400] : Colors.grey[600],
          ),
        ),
        trailing: Obx(() {
           final rxIsSaved = sound['isSaved'];
           final isSaved = rxIsSaved is RxBool ? rxIsSaved.value : false;
           return IconButton(
            icon: Image.asset(
              AppAssets.savedIcon3d,
              width: 24,
              height: 24,
              color: isSaved ? Colors.blueAccent : (isDark ? Colors.grey[400] : Colors.grey[600]),
            ),
            onPressed: onSave,
          );
        }),
      ),
    );
  }
}
