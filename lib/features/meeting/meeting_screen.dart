import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'controllers/meeting_controller.dart';
import '../../core/constants/app_assets.dart';

class MeetingScreen extends StatelessWidget {
  const MeetingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MeetingController());
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;
    final secondaryTextColor = isDark ? Colors.white70 : Colors.black87;
    final cardBg = isDark ? const Color(0xFF13161D) : Colors.grey[100];
    final borderColor = isDark ? Colors.white.withAlpha(13) : Colors.black.withAlpha(13);

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0A0C10) : Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              
              // Secure Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.blue.withAlpha(25),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.blue.withAlpha(51)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(AppAssets.securitySafeIcon3d, width: 14, height: 14),
                    const SizedBox(width: 8),
                    Text(
                      'SECURE & ENCRYPTED',
                      style: TextStyle(
                        color: Colors.blue.withAlpha(204),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              Text(
                'Premium Video',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: textColor,
                ),
              ),
              Text(
                'Conferencing for Everyone.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: textColor,
                  height: 1.1,
                ),
              ),

              const SizedBox(height: 32),

              // Action Cards Grid
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 24,
                crossAxisSpacing: 24,
                childAspectRatio: 1.1,
                children: [
                  _buildActionCard(
                    'New Meeting',
                    Icons.videocam,
                    const Color(0xFFFE5722),
                    onTap: () => _onNewMeeting(context, controller),
                  ),
                  _buildActionCard(
                    'Join',
                    Icons.add,
                    const Color(0xFF2575FC),
                    onTap: () => _onJoinMeeting(context, controller),
                  ),
                  _buildActionCard(
                    'Schedule',
                    Icons.calendar_month,
                    const Color(0xFF2575FC),
                    onTap: () => controller.scheduleMeeting(),
                  ),
                  _buildActionCard(
                    'Share Screen',
                    Icons.present_to_all,
                    const Color(0xFF2575FC),
                    onTap: () => _onShareScreen(context, controller),
                  ),
                ],
              ),

              const SizedBox(height: 32),
              
              // Upcoming Meetings Section
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Upcoming Meetings', 
                  style: TextStyle(
                    fontSize: 18, 
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Obx(() => ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.upcomingMeetings.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final meeting = controller.upcomingMeetings[index];
                  return _buildMeetingCard(meeting, isDark, controller);
                },
              )),

              const SizedBox(height: 32),

              // Join Bar (Optional if "Join" button exists, but good for direct input)
               Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: cardBg,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: borderColor),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.keyboard_alt_outlined, color: Colors.grey),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextField(
                        style: TextStyle(color: textColor),
                        onSubmitted: (val) => controller.joinMeeting(val),
                        decoration: const InputDecoration(
                          hintText: 'Enter meeting code or link',
                          hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => _onJoinMeeting(context, controller),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1A3D8A),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        elevation: 0,
                      ),
                      child: const Text('Join Now', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
              

              // 1️⃣ System Check Card
              const SizedBox(height: 32),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: cardBg,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: borderColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'System Check',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Icon(Icons.settings, color: Colors.grey),
                      ],
                    ),
                    const SizedBox(height: 16),

                    Obx(() {
                      final status = controller.cameraStatus.value;
                      String statusText = 'Unknown';
                      Color color = Colors.grey;
                      
                      if (status.isGranted) {
                        statusText = 'Ready to use';
                        color = Colors.green;
                      } else if (status.isDenied) {
                        statusText = 'Denied';
                        color = Colors.red;
                      } else if (status.isPermanentlyDenied) {
                        statusText = 'Permanently Denied';
                        color = Colors.red;
                      } else if (status.isRestricted) {
                        statusText = 'Restricted';
                        color = Colors.orange;
                      }

                      return InkWell(
                        onTap: () => controller.requestCameraPermission(),
                        child: _buildSystemItem(
                          icon: Icons.videocam,
                          title: 'FaceTime HD',
                          status: statusText,
                          statusColor: color,
                          isDark: isDark,
                        ),
                      );
                    }),
                    const SizedBox(height: 12),
                    Obx(() {
                      final status = controller.micStatus.value;
                      String statusText = 'Unknown';
                      Color color = Colors.grey;
                      
                      if (status.isGranted) {
                        statusText = 'Active';
                        color = Colors.green;
                      } else if (status.isDenied) {
                        statusText = 'Denied';
                        color = Colors.red;
                      } else if (status.isPermanentlyDenied) {
                        statusText = 'Permanently Denied';
                        color = Colors.red;
                      } else if (status.isRestricted) {
                        statusText = 'Restricted';
                        color = Colors.orange;
                      }

                      return InkWell(
                        onTap: () => controller.requestMicPermission(),
                        child: _buildSystemItem(
                          icon: Icons.mic,
                          title: 'MacBook Pro Mic',
                          status: statusText,
                          statusColor: color,
                          isDark: isDark,
                        ),
                      );
                    }),
                  ],
                ),
              ),

              // 2️⃣ Next Up Header
              const SizedBox(height: 32),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Next Up',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'See full schedule',
                    style: TextStyle(
                      color: Color(0xFF2575FC),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              // 3️⃣ Recent Recording Card
              const SizedBox(height: 32),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1A3D8A), Color(0xFF13161D)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 72,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.play_arrow, color: Colors.white),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Q4 Strategy Sync',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const _NewBadge(),
                            ],
                          ),
                          SizedBox(height: 6),
                          Text(
                            'Recorded 2h ago',
                            style: TextStyle(color: Colors.white70, fontSize: 12),
                          ),
                          SizedBox(height: 6),
                          Text(
                            'Watch Summary',
                            style: TextStyle(
                              color: Colors.lightBlueAccent,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
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
  
   void _onNewMeeting(BuildContext context, MeetingController controller) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? const Color(0xFF13161D) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
               width: 40, height: 4, 
               decoration: BoxDecoration(color: isDark ? Colors.white30 : Colors.black12, borderRadius: BorderRadius.circular(2))
            ),
            const SizedBox(height: 32),
            _buildModalOption(Icons.link, 'Get a meeting link to share', 'Send this to people you want to meet with', isDark),
            const SizedBox(height: 24),
            _buildModalOption(
              Icons.videocam_outlined, 
              'Start an instant meeting', 
              'Join the meeting immediately', 
              isDark,
              onTap: () => controller.startInstantMeeting(),
            ),
            const SizedBox(height: 24),
            _buildModalOption(
              Icons.calendar_month_outlined, 
              'Schedule in Google Calendar', 
              'Plan your meeting for later',
              isDark,
              onTap: () => controller.scheduleMeeting(),
            ),
          ],
        ),
      ),
    );
  }

  void _onJoinMeeting(BuildContext context, MeetingController controller) {
    final textCtrl = TextEditingController();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? const Color(0xFF13161D) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;

    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: cardBg,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
             mainAxisSize: MainAxisSize.min,
             children: [
               Text('Join a Meeting', style: TextStyle(color: textColor, fontSize: 20, fontWeight: FontWeight.bold)),
               const SizedBox(height: 24),
               TextField(
                controller: textCtrl,
                 style: TextStyle(color: textColor),
                 decoration: InputDecoration(
                   hintText: 'Example: abc-defg-hij',
                   hintStyle: TextStyle(color: Colors.grey.withAlpha(128)),
                   filled: true,
                   fillColor: isDark ? Colors.black.withAlpha(51) : Colors.grey.withAlpha(25),
                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                 ),
               ),
               const SizedBox(height: 24),
               Row(
                 mainAxisAlignment: MainAxisAlignment.end,
                 children: [
                   TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
                   const SizedBox(width: 16),
                   ElevatedButton(
                     onPressed: () => controller.joinMeeting(textCtrl.text),
                     child: const Text('Join'),
                   ),
                 ],
               ),
             ],
          ),
        ),
      ),
    );
  }

   void _onShareScreen(BuildContext context, MeetingController controller) {
     final isDark = Theme.of(context).brightness == Brightness.dark;
     final cardBg = isDark ? const Color(0xFF13161D) : Colors.white;
     final textColor = isDark ? Colors.white : Colors.black;

     showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: cardBg,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.present_to_all, color: Color(0xFF2575FC), size: 48),
              const SizedBox(height: 16),
              Text('Share your screen?', style: TextStyle(color: textColor, fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => controller.shareScreen(),
                child: const Text('Start Presenting'),
              ),
              TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMeetingCard(Map<String, dynamic> meeting, bool isDark, MeetingController controller) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF13161D) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isDark ? Colors.white12 : Colors.grey.shade300),
        boxShadow: [
          if (!isDark) BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.calendar_today, color: Colors.orange),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(meeting['title'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: isDark ? Colors.white : Colors.black)),
                const SizedBox(height: 4),
                Text('${meeting['time']} • ${meeting['duration']}', style: TextStyle(color: Colors.grey.shade500, fontSize: 13)),
                const SizedBox(height: 4),
                Text('Hosted by ${meeting['host']}', style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () => controller.joinMeeting(meeting['code']),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2575FC),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              minimumSize: const Size(0, 36),
            ),
            child: const Text('Join'),
          ),
        ],
      ),
    );
  }

   Widget _buildModalOption(IconData icon, String title, String subtitle, bool isDark, {VoidCallback? onTap, String? assetPath}) {
    final textColor = isDark ? Colors.white : Colors.black;
    final subTextColor = isDark ? Colors.grey : Colors.grey[700];

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark ? Colors.white.withAlpha(13) : Colors.black.withAlpha(13),
              shape: BoxShape.circle,
            ),
            child: assetPath != null
                ? Image.asset(assetPath, width: 24, height: 24)
                : Icon(icon, color: isDark ? Colors.white : Colors.black, size: 24),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(subtitle, style: TextStyle(color: subTextColor, fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(String title, IconData icon, Color color, {required VoidCallback onTap, String? assetPath}) {
     return GestureDetector(
       onTap: onTap,
       child: Container(
         decoration: BoxDecoration(
           color: color,
           borderRadius: BorderRadius.circular(24),
           boxShadow: [
             BoxShadow(color: color.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 5)),
           ],
         ),
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             assetPath != null
                 ? Image.asset(assetPath, width: 32, height: 32)
                 : Icon(icon, color: Colors.white, size: 32),
             const SizedBox(height: 12),
             Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
           ],
         ),
       ),
     );
  }
  Widget _buildSystemItem({
    required IconData icon,
    required String title,
    required String status,
    required Color statusColor,
    required bool isDark,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isDark ? Colors.white.withAlpha(13) : Colors.black.withAlpha(13),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: isDark ? Colors.white : Colors.black),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            title,
            style: TextStyle(color: isDark ? Colors.white : Colors.black),
          ),
        ),
        Row(
          children: [
            Icon(Icons.circle, size: 8, color: statusColor),
            const SizedBox(width: 6),
            Text(
              status,
              style: TextStyle(color: statusColor, fontSize: 12),
            ),
          ],
        ),
      ],
    );
  }
}

class _NewBadge extends StatelessWidget {
  const _NewBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.redAccent,
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Text(
        'NEW',
        style: TextStyle(color: Colors.white, fontSize: 10),
      ),
    );
  }
}
