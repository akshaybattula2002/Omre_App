import 'package:flutter/material.dart';

class ExploreSoundTile extends StatelessWidget {
  final Map<String, dynamic> sound;
  final bool isDark;

  const ExploreSoundTile({super.key, required this.sound, required this.isDark});

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
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.blueAccent.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.play_arrow, color: Colors.blueAccent),
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
        trailing: IconButton(
          icon: Icon(Icons.bookmark_border, color: isDark ? Colors.grey[400] : Colors.grey[600]),
          onPressed: () {},
        ),
      ),
    );
  }
}
