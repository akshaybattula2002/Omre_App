import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/palette.dart';
import '../../../core/constants/app_assets.dart';

class CallScreen extends StatefulWidget {
  final Map<String, dynamic> caller;
  final bool isVideo;

  const CallScreen({super.key, required this.caller, required this.isVideo});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  bool isMuted = false;
  bool isVideoOn = false;
  
  @override
  void initState() {
    super.initState();
    isVideoOn = widget.isVideo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Dark background for calls
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image (blurred or video feed)
          if (isVideoOn)
            widget.caller['avatarUrl'].startsWith('http')
                ? Image.asset(
                    AppAssets.avatar1,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    widget.caller['avatarUrl'],
                    fit: BoxFit.cover,
                  )
          else
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black, Colors.blueGrey.shade900],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundImage: widget.caller['avatarUrl'].startsWith('http')
                        ? AssetImage(AppAssets.avatar1)
                        : AssetImage(widget.caller['avatarUrl']) as ImageProvider,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    widget.caller['name'] ?? 'Unknown Caller',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Calling...',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),

          // Controls
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildCallControl(
                  icon: isMuted ? Icons.mic_off : Icons.mic,
                  label: 'Mute',
                  isActive: isMuted,
                  onTap: () => setState(() => isMuted = !isMuted),
                ),
                _buildCallControl(
                  icon: isVideoOn ? Icons.videocam : Icons.videocam_off,
                  label: 'Video',
                  isActive: isVideoOn,
                  onTap: () => setState(() => isVideoOn = !isVideoOn),
                ),
                FloatingActionButton(
                  onPressed: () => Get.back(),
                  backgroundColor: Colors.red,
                  child: const Icon(Icons.call_end, color: Colors.white),
                ),
              ],
            ),
          ),
          
          // Header buttons
          Positioned(
            top: 50,
            left: 16,
            child: IconButton(
              icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
              onPressed: () => Get.back(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCallControl({required IconData icon, required String label, required bool isActive, required VoidCallback onTap}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(30),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isActive ? Colors.white : Colors.white24,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: isActive ? Colors.black : Colors.white, size: 28),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }
}
