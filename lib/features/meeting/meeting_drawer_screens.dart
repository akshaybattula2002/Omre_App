import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/palette.dart';
import '../../core/constants/app_assets.dart';

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

class MeetingUpcomingScreen extends StatefulWidget {
  const MeetingUpcomingScreen({super.key});

  @override
  State<MeetingUpcomingScreen> createState() => _MeetingUpcomingScreenState();
}

class _MeetingUpcomingScreenState extends State<MeetingUpcomingScreen> {
  // Dummy data state
  List<Map<String, dynamic>> meetings = [
    {
      'title': 'Product Sync - Q4',
      'time': '10:30 AM - 11:30 AM',
      'host': 'Hosted by Sarah Jenkins',
      'isNow': true,
    },
    {
      'title': 'Design Review',
      'time': '02:00 PM - 03:00 PM',
      'host': 'Hosted by Mike Ross',
      'isNow': false,
    },
    {
      'title': 'Marketing Strategy',
      'time': 'Tomorrow, 11:00 AM',
      'host': 'Hosted by Jessica Pearson',
      'isNow': false,
    },
  ];

  void _cancelMeeting(int index) {
    var removed = meetings[index];
    setState(() {
      meetings.removeAt(index);
    });
    Get.snackbar(
      'Meeting Cancelled',
      'You have cancelled "${removed['title']}"',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }

  void _joinMeeting(String title) {
    // Simulate joining process
    Get.dialog(
      Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(color: Color(0xFF1A3D8A)),
              const SizedBox(height: 16),
              Text(
                'Joining "$title"...',
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    decoration: TextDecoration.none),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );

    Future.delayed(const Duration(seconds: 2), () {
      Get.back(); // Close dialog
      Get.snackbar(
        'Success',
        'Successfully joined "$title"!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    });
  }

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
      body: meetings.isEmpty
          ? Center(
              child: Text(
                'No upcoming meetings',
                style: TextStyle(color: textColor.withOpacity(0.5), fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: meetings.length,
              itemBuilder: (context, index) {
                final meeting = meetings[index];
                return _buildMeetingCard(
                  context,
                  meeting['title'],
                  meeting['time'],
                  meeting['host'],
                  meeting['isNow'],
                  isDark,
                  index,
                );
              },
            ),
    );
  }

  Widget _buildMeetingCard(BuildContext context, String title, String time,
      String host, bool isNow, bool isDark, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF13161D) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
            color: isDark
                ? Colors.white.withAlpha(13)
                : Colors.black.withAlpha(13)),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                      color: Colors.red.withAlpha(25),
                      borderRadius: BorderRadius.circular(8)),
                  child: const Row(
                    children: [
                      Icon(Icons.circle, color: Colors.red, size: 8),
                      SizedBox(width: 6),
                      Text('LIVE NOW',
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 10,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                )
              else
                Icon(Icons.calendar_today,
                    size: 16, color: Colors.blue.withAlpha(153)),
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_horiz, color: Colors.grey, size: 20),
                color: isDark ? const Color(0xFF1E222B) : Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                onSelected: (value) {
                  if (value == 'details') {
                    _showDetailsSheet(context, title, time, host, isDark);
                  } else if (value == 'cancel') {
                    _cancelMeeting(index);
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'details',
                    child: Row(
                      children: [
                        Icon(Icons.info_outline,
                            size: 20,
                            color: isDark ? Colors.white : Colors.black),
                        const SizedBox(width: 12),
                        Text('View Details',
                            style: TextStyle(
                                color: isDark ? Colors.white : Colors.black)),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'cancel',
                    child: Row(
                      children: [
                        Icon(Icons.cancel_outlined, size: 20, color: Colors.red),
                        const SizedBox(width: 12),
                        const Text('Cancel Meeting',
                            style: TextStyle(color: Colors.red)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(title,
              style: TextStyle(
                  color: isDark ? Colors.white : Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(time,
              style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 13,
                  fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text(host,
              style: TextStyle(
                  color: isDark ? Colors.white70 : Colors.black54,
                  fontSize: 13)),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (isNow) {
                  _joinMeeting(title);
                } else {
                  _showDetailsSheet(context, title, time, host, isDark);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isNow
                    ? const Color(0xFF1A3D8A)
                    : (isDark ? Colors.white.withAlpha(13) : Colors.grey[100]),
                foregroundColor: isNow
                    ? Colors.white
                    : (isDark ? Colors.white : Colors.black),
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(isNow ? 'Join Now' : 'Details'),
            ),
          ),
        ],
      ),
    );
  }

  void _showDetailsSheet(BuildContext context, String title, String time, String host, bool isDark) {
    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? const Color(0xFF13161D) : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                    color: isDark ? Colors.white24 : Colors.grey[300],
                    borderRadius: BorderRadius.circular(2)),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildDetailRow(Icons.access_time, 'Time', time, isDark),
            const SizedBox(height: 12),
            _buildDetailRow(Icons.person_outline, 'Host', host, isDark, assetPath: AppAssets.personalInfoIcon3d),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Get.back(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDark ? Colors.white10 : Colors.grey[200],
                  foregroundColor: isDark ? Colors.white : Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                child: const Text('Close'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
      IconData icon, String label, String value, bool isDark, {String? assetPath}) {
    return Row(
      children: [
        assetPath != null 
            ? Image.asset(assetPath, width: 20, height: 20)
            : Icon(icon, size: 20, color: Colors.blue),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: isDark ? Colors.white54 : Colors.black54,
                fontSize: 12,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
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
            Image.asset('assets/images/meeting_icon_3d.png', width: 80, height: 80),
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
            _buildTextField('Emails separated by comma', Icons.person_add_outlined, isDark, textColor, assetPath: AppAssets.personalInfoIcon3d),
            
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

  Widget _buildTextField(String hint, IconData icon, bool isDark, Color textColor, {String? assetPath}) {
    return TextField(
      style: TextStyle(color: textColor),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey.withAlpha(128)),
        filled: true,
        fillColor: isDark ? Colors.white.withAlpha(13) : Colors.grey[100],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        prefixIcon: assetPath != null 
            ? Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(assetPath, width: 20, height: 20),
              )
            : Icon(icon, color: Colors.blue, size: 20),
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

class MeetingHistoryScreen extends StatefulWidget {
  const MeetingHistoryScreen({super.key});

  @override
  State<MeetingHistoryScreen> createState() => _MeetingHistoryScreenState();
}

class _MeetingHistoryScreenState extends State<MeetingHistoryScreen> {
  String selectedFilter = 'All';
  final List<String> filters = ['All', 'Recorded', 'Missed', 'Completed'];

  final List<Map<String, dynamic>> _allMeetings = [
    {
      'title': 'Q3 Product Roadmap',
      'date': 'Yesterday, 10:00 AM',
      'duration': '54 min',
      'status': 'Completed',
      'color': Colors.green
    },
    {
      'title': 'Design Weekly Sync',
      'date': 'Oct 22, 2026',
      'duration': '32 min',
      'status': 'Recorded',
      'color': Colors.red
    },
    {
      'title': 'Client Onboarding - Acme',
      'date': 'Oct 20, 2026',
      'duration': '0 min',
      'status': 'Missed',
      'color': Colors.orange
    },
    {
      'title': '1:1 with Manager',
      'date': 'Oct 18, 2026',
      'duration': '28 min',
      'status': 'Completed',
      'color': Colors.green
    },
    {
      'title': 'Tech Talk: Flutter 4.0',
      'date': 'Oct 15, 2026',
      'duration': '1h 20m',
      'status': 'Recorded',
      'color': Colors.red
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;

    // Filter logic
    final filteredMeetings = selectedFilter == 'All'
        ? _allMeetings
        : _allMeetings.where((m) => m['status'] == selectedFilter).toList();

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: _buildMeetingAppBar('Meeting History', context),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              style: TextStyle(color: textColor),
              decoration: InputDecoration(
                hintText: 'Search past meetings...',
                hintStyle: TextStyle(color: Colors.grey.withAlpha(128)),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor:
                    isDark ? Colors.white.withAlpha(13) : Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: filters.map((filter) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: _buildFilterChip(filter, selectedFilter == filter, isDark),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: filteredMeetings.length,
              itemBuilder: (context, index) {
                final meeting = filteredMeetings[index];
                return _buildHistoryItem(
                  meeting['title'],
                  meeting['date'],
                  meeting['duration'],
                  meeting['status'],
                  meeting['color'],
                  isDark,
                  textColor,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected, bool isDark) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF1A3D8A)
              : (isDark ? Colors.white.withAlpha(13) : Colors.grey[100]),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? Colors.transparent
                : (isDark
                    ? Colors.white.withAlpha(26)
                    : Colors.black.withAlpha(13)),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected
                ? Colors.white
                : (isDark ? Colors.white70 : Colors.black87),
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryItem(String title, String date, String duration,
      String status, Color statusColor, bool isDark, Color textColor) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: isDark ? const Color(0xFF13161D) : Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          builder: (context) => Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                        color: isDark ? Colors.white24 : Colors.grey[300],
                        borderRadius: BorderRadius.circular(2)),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  title,
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                _buildDetailRow(Icons.calendar_today, 'Date', date, isDark),
                const SizedBox(height: 12),
                _buildDetailRow(Icons.timer_outlined, 'Duration', duration, isDark),
                const SizedBox(height: 12),
                _buildDetailRow(
                  status == 'Recorded' ? Icons.play_arrow : (status == 'Missed' ? Icons.call_missed : Icons.check_circle),
                  'Status',
                  status,
                  isDark
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Get.back(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDark ? Colors.white10 : Colors.grey[200],
                      foregroundColor: isDark ? Colors.white : Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      elevation: 0,
                    ),
                    child: const Text('Close'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF13161D) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
              color: isDark
                  ? Colors.white.withAlpha(13)
                  : Colors.black.withAlpha(13)),
          boxShadow: [
            if (!isDark)
              BoxShadow(
                color: Colors.black.withAlpha(13),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: statusColor.withAlpha(25),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                status == 'Recorded'
                    ? Icons.play_arrow
                    : (status == 'Missed'
                        ? Icons.call_missed
                        : Icons.check_circle),
                color: statusColor,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$date • $duration',
                    style: TextStyle(
                      color: isDark ? Colors.white54 : Colors.black54,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor.withAlpha(25),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                status,
                style: TextStyle(
                  color: statusColor,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
      IconData icon, String label, String value, bool isDark) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.blue),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: isDark ? Colors.white54 : Colors.black54,
                fontSize: 12,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );

  }
}

class MeetingCreateTemplateScreen extends StatefulWidget {
  const MeetingCreateTemplateScreen({super.key});

  @override
  State<MeetingCreateTemplateScreen> createState() => _MeetingCreateTemplateScreenState();
}

class _MeetingCreateTemplateScreenState extends State<MeetingCreateTemplateScreen> {
  // Form State
  bool _videoOn = true;
  bool _muteOnEntry = false;
  bool _waitingRoom = true;
  bool _recordAutomatically = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: _buildMeetingAppBar('Create Template', context),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('Template Details', textColor),
            const SizedBox(height: 16),
            _buildTextField('Template Name', 'e.g., Weekly Sync', Icons.bookmark_outline, isDark, textColor, controller: _nameController),
            const SizedBox(height: 16),
            _buildTextField('Meeting Description', 'Enter default description...', Icons.description_outlined, isDark, textColor, maxLines: 3, controller: _descriptionController),
            
            const SizedBox(height: 32),
            _buildSectionHeader('Default Settings', textColor),
            const SizedBox(height: 16),
            _buildSwitchItem(
              'Video On', 
              'Start meetings with video enabled', 
              _videoOn, 
              isDark, 
              textColor,
              (val) => setState(() => _videoOn = val),
            ),
            _buildSwitchItem(
              'Mute on Entry', 
              'Mute participants when they join', 
              _muteOnEntry, 
              isDark, 
              textColor,
              (val) => setState(() => _muteOnEntry = val),
            ),
            _buildSwitchItem(
              'Waiting Room', 
              'Participants wait for admittance', 
              _waitingRoom, 
              isDark, 
              textColor,
              (val) => setState(() => _waitingRoom = val),
            ),
            _buildSwitchItem(
              'Record Automatically', 
              'Start recording when meeting begins', 
              _recordAutomatically, 
              isDark, 
              textColor,
              (val) => setState(() => _recordAutomatically = val),
            ),
            
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  if (_nameController.text.isEmpty) {
                    Get.snackbar(
                      'Error',
                      'Please enter a template name',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                    return;
                  }

                  Get.back();
                  Get.snackbar(
                    'Success',
                    'Template "${_nameController.text}" saved!',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1A3D8A),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                ),
                child: const Text('Save Template', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, Color color) {
    return Text(
      title,
      style: TextStyle(
        color: color,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildTextField(String label, String hint, IconData icon, bool isDark, Color textColor, {int maxLines = 1, TextEditingController? controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: textColor.withOpacity(0.7),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          style: TextStyle(color: textColor),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey.withAlpha(128)),
            filled: true,
            fillColor: isDark ? Colors.white.withAlpha(13) : Colors.grey[100],
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            prefixIcon: maxLines == 1 ? Icon(icon, color: Colors.blue, size: 20) : Container(padding: const EdgeInsets.only(top: 12, left: 12), child: Icon(icon, color: Colors.blue, size: 20)),
          ),
        ),
      ],
    );
  }

  Widget _buildSwitchItem(String title, String subtitle, bool value, bool isDark, Color textColor, ValueChanged<bool> onChanged) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withAlpha(10) : Colors.grey.withAlpha(25),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: isDark ? Colors.white54 : Colors.black54,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF1A3D8A),
          ),
        ],
      ),
    );
  }
}
