import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/palette.dart';

// --- Shared Components ---

Widget _buildMeetingAppBar(String title, BuildContext context) {
  final theme = Theme.of(context);
  final isDark = theme.brightness == Brightness.dark;
  return AppBar(
      backgroundColor: theme.scaffoldBackgroundColor,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: theme.iconTheme.color),
        onPressed: () => Get.back(),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isDark ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
  );
}

// --- Screen Implementations ---

class MeetingUpcomingScreen extends StatelessWidget {
  const MeetingUpcomingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: _buildMeetingAppBar('Upcoming Meetings', context),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildMeetingCard(
            context,
            'Product Sync - Q4',
            '10:30 AM - 11:30 AM',
            'Hosted by Sarah Jenkins',
            true,
            isDark,
          ),
          _buildMeetingCard(
            context,
            'Design Review',
            '02:00 PM - 03:00 PM',
            'Hosted by Mike Ross',
            false,
            isDark,
          ),
          _buildMeetingCard(
            context,
            'Marketing Strategy',
            'Tomorrow, 11:00 AM',
            'Hosted by Jessica Pearson',
            false,
            isDark,
          ),
        ],
      ),
    );
  }

  Widget _buildMeetingCard(BuildContext context, String title, String time, String host, bool isNow, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF13161D) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isDark ? Colors.white.withAlpha(13) : Colors.black.withAlpha(13)),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.black.withAlpha(13),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (isNow)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: Colors.red.withAlpha(25), borderRadius: BorderRadius.circular(8)),
                  child: const Row(
                    children: [
                      Icon(Icons.circle, color: Colors.red, size: 8),
                      SizedBox(width: 6),
                      Text('LIVE NOW', style: TextStyle(color: Colors.red, fontSize: 10, fontWeight: FontWeight.bold)),
                    ],
                  ),
                )
              else
                Icon(Icons.calendar_today, size: 16, color: Colors.blue.withAlpha(153)),
              const Icon(Icons.more_horiz, color: Colors.grey, size: 20),
            ],
          ),
          const SizedBox(height: 16),
          Text(title, style: TextStyle(color: isDark ? Colors.white : Colors.black, fontSize: 17, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(time, style: const TextStyle(color: Colors.blue, fontSize: 13, fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text(host, style: TextStyle(color: isDark ? Colors.white70 : Colors.black54, fontSize: 13)),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: isNow ? const Color(0xFF1A3D8A) : (isDark ? Colors.white.withAlpha(13) : Colors.grey[100]),
                foregroundColor: isNow ? Colors.white : (isDark ? Colors.white : Colors.black),
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(isNow ? 'Join Now' : 'Details'),
            ),
          ),
        ],
      ),
    );
  }
}

class MeetingJoinScreen extends StatelessWidget {
  const MeetingJoinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: _buildMeetingAppBar('Join a Meeting', context),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Icon(Icons.videocam_outlined, size: 80, color: Colors.blue.withAlpha(153)),
            const SizedBox(height: 24),
            Text(
              'Enter Meeting Details',
              style: TextStyle(color: textColor, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Enter a code or link provided by the host.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 40),
            TextField(
              style: TextStyle(color: textColor),
              decoration: InputDecoration(
                hintText: 'Example: abc-defg-hij',
                hintStyle: TextStyle(color: Colors.grey.withAlpha(128)),
                filled: true,
                fillColor: isDark ? Colors.white.withAlpha(13) : Colors.grey[100],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                prefixIcon: const Icon(Icons.link, color: Colors.blue),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1A3D8A),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                ),
                child: const Text('Join Meeting', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MeetingScheduleScreen extends StatelessWidget {
  const MeetingScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: _buildMeetingAppBar('Schedule Meeting', context),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInputLabel('Meeting Title', textColor),
            _buildTextField('Enter title', Icons.title, isDark, textColor),
            
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInputLabel('Date', textColor),
                      _buildTextField('Oct 24, 2026', Icons.calendar_today, isDark, textColor),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInputLabel('Time', textColor),
                      _buildTextField('10:00 AM', Icons.access_time, isDark, textColor),
                    ],
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            _buildInputLabel('Duration', textColor),
            _buildTextField('60 Minutes', Icons.timer_outlined, isDark, textColor),
            
            const SizedBox(height: 24),
            _buildInputLabel('Add Participants', textColor),
            _buildTextField('Emails separated by comma', Icons.person_add_outlined, isDark, textColor),
            
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1A3D8A),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                ),
                child: const Text('Schedule', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputLabel(String label, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(label, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 14)),
    );
  }

  Widget _buildTextField(String hint, IconData icon, bool isDark, Color textColor) {
    return TextField(
      style: TextStyle(color: textColor),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey.withAlpha(128)),
        filled: true,
        fillColor: isDark ? Colors.white.withAlpha(13) : Colors.grey[100],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        prefixIcon: Icon(icon, color: Colors.blue, size: 20),
      ),
    );
  }
}

class MeetingRecordingsScreen extends StatelessWidget {
  const MeetingRecordingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: _buildMeetingAppBar('Recordings', context),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildRecordingItem('Project Kickoff', '24 Oct, 2026', '45:30', isDark, textColor),
          _buildRecordingItem('Weekly Standup', '22 Oct, 2026', '15:20', isDark, textColor),
          _buildRecordingItem('Client Presentation', '20 Oct, 2026', '01:10:45', isDark, textColor),
          _buildRecordingItem('Interview - Frontend', '18 Oct, 2026', '55:12', isDark, textColor),
        ],
      ),
    );
  }

  Widget _buildRecordingItem(String title, String date, String duration, bool isDark, Color textColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF13161D) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isDark ? Colors.white.withAlpha(13) : Colors.black.withAlpha(13)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: Colors.red.withAlpha(25), shape: BoxShape.circle),
          child: const Icon(Icons.play_arrow, color: Colors.red, size: 20),
        ),
        title: Text(title, style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
        subtitle: Text(date, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(color: isDark ? Colors.white.withAlpha(13) : Colors.grey[100], borderRadius: BorderRadius.circular(6)),
          child: Text(duration, style: TextStyle(color: isDark ? Colors.white70 : Colors.black54, fontSize: 11, fontWeight: FontWeight.bold)),
        ),
        onTap: () {},
      ),
    );
  }
}
