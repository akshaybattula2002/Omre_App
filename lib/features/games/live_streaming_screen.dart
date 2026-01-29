import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

class LiveStreamingScreen extends StatefulWidget {
  final String streamTitle;
  final String gameName;

  const LiveStreamingScreen({
    super.key, 
    required this.streamTitle, 
    required this.gameName
  });

  @override
  State<LiveStreamingScreen> createState() => _LiveStreamingScreenState();
}

class _LiveStreamingScreenState extends State<LiveStreamingScreen> {
  Timer? _timer;
  int _secondsElapsed = 0;
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, String>> _messages = [];
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _startTimer();
    _simulateIncomingMessages();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _secondsElapsed++;
        });
      }
    });
  }

  void _simulateIncomingMessages() {
    // Simulate chat messages arriving
    Timer.periodic(const Duration(seconds: 3), (timer) {
      if (mounted) {
        final newMsg = {
          'user': 'User${DateTime.now().millisecond}', 
          'message': _getRandomMessage()
        };
        setState(() {
          _messages.add(newMsg);
          // Keep only last 50 messages
          if (_messages.length > 50) _messages.removeAt(0);
        });
        
        // Auto scroll to bottom
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent + 50,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      }
    });
  }

  String _getRandomMessage() {
    const msgs = [
      'Awesome stream!', 
      'Hello from Brazil!', 
      'Which level is this?', 
      'Wow!', 
      'GG', 
      'Can you play Valorant next?',
      'You are a pro!', 
      'Nice graphics',
      'LFG!!!'
    ];
    return msgs[DateTime.now().second % msgs.length];
  }

  String _formatDuration(int seconds) {
    final int h = seconds ~/ 3600;
    final int m = (seconds % 3600) ~/ 60;
    final int s = seconds % 60;
    return '${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scrollController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  void _endStream() {
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        title: const Text('End Stream?', style: TextStyle(color: Colors.white)),
        content: const Text('Are you sure you want to stop streaming?', style: TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              Get.back(); // Close dialog
              Get.back(); // Go back to GoLiveScreen
              Get.snackbar(
                'Stream Ended', 
                'You streamed for ${_formatDuration(_secondsElapsed)}',
                backgroundColor: Colors.redAccent,
                colorText: Colors.white,
              );
            },
            child: const Text('End Stream', style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background (Camera Placeholder)
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black54, Colors.black26, Colors.transparent, Colors.black54, Colors.black87],
              ),
            ),
            child: Center(
              child: Icon(Icons.videocam_outlined, size: 80, color: Colors.white.withOpacity(0.1)),
            ),
            // In a real app, CameraPreview goes here
          ),

          // Top Header Overlay
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(4)),
                    child: const Text('LIVE', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(4)),
                    child: Row(
                      children: [
                        const Icon(Icons.visibility, color: Colors.white, size: 14),
                        const SizedBox(width: 4),
                        const Text('1.2K', style: TextStyle(color: Colors.white, fontSize: 12)),
                      ],
                    ),
                  ),
                   const SizedBox(width: 8),
                   Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(4)),
                    child: Text(_formatDuration(_secondsElapsed), style: const TextStyle(color: Colors.white, fontSize: 12)),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: _endStream,
                  ),
                ],
              ),
            ),
          ),

          // Bottom Area (Chat & Controls)
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Chat Area
                  SizedBox(
                    height: 200,
                    child: ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Colors.black, Colors.black],
                          stops: [0.0, 0.2, 1.0],
                        ).createShader(bounds);
                      },
                      blendMode: BlendMode.dstIn,
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: _messages.length,
                        itemBuilder: (context, index) {
                          final msg = _messages[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 12,
                                  backgroundColor: Colors.primaries[msg['user'].hashCode % Colors.primaries.length],
                                  child: Text(msg['user']![0], style: const TextStyle(fontSize: 10, color: Colors.white)),
                                ),
                                const SizedBox(width: 8),
                                Text(msg['user']!, style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 12)),
                                const SizedBox(width: 8),
                                Expanded(child: Text(msg['message']!, style: const TextStyle(color: Colors.white, fontSize: 12))),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 16),

                  // Controls
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: const Align(
                             alignment: Alignment.centerLeft,
                             child: Text('Say something...', style: TextStyle(color: Colors.white54))
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                       CircleAvatar(
                         backgroundColor: Colors.white.withOpacity(0.1),
                         child: IconButton(icon: const Icon(Icons.mic, color: Colors.white), onPressed: () {}),
                       ),
                       const SizedBox(width: 8),
                       CircleAvatar(
                         backgroundColor: Colors.white.withOpacity(0.1),
                         child: IconButton(icon: const Icon(Icons.videocam, color: Colors.white), onPressed: () {}),
                       ),
                        const SizedBox(width: 8),
                       CircleAvatar(
                         backgroundColor: Colors.white.withOpacity(0.1),
                         child: IconButton(icon: const Icon(Icons.more_horiz, color: Colors.white), onPressed: () {}),
                       ),
                    ],
                  ),
                  const SizedBox(height: 20), // Bottom SafeArea padding
                ],
              ),
            ),
          ),
          
          // Stream Info Overlay (Game Title)
          Positioned(
            top: 80,
            left: 16,
            child: Container(
               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
               decoration: BoxDecoration(
                 color: Colors.black45,
                 borderRadius: BorderRadius.circular(8),
               ),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text(widget.streamTitle.isEmpty ? 'Live Stream' : widget.streamTitle, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                   const SizedBox(height: 4),
                   Row(
                     children: [
                       const Icon(Icons.gamepad, color: Colors.amber, size: 14),
                       const SizedBox(width: 4),
                       Text(widget.gameName, style: const TextStyle(color: Colors.amber, fontSize: 12)),
                     ],
                   )
                 ],
               ),
            ),
          ),
        ],
      ),
    );
  }
}
