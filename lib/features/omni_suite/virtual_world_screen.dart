import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class VirtualWorldScreen extends StatefulWidget {
  const VirtualWorldScreen({super.key});

  @override
  State<VirtualWorldScreen> createState() => _VirtualWorldScreenState();
}

class _VirtualWorldScreenState extends State<VirtualWorldScreen> {
  // Expansion states for inline modules
  final Map<String, bool> _expansionStates = {
    'unified_model': true, // Default expanded for impact
    'matrix': false,
    'participation': false,
    'education': false,
    'trust': false,
  };

  void _toggleExpansion(String key) {
    HapticFeedback.lightImpact();
    setState(() {
      _expansionStates[key] = !(_expansionStates[key] ?? false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    // Adaptive Design Tokens
    final Color bgColor = isDark ? const Color(0xFF0A0C0E) : const Color(0xFFF7F8FA);
    final Color surfaceColor = isDark ? const Color(0xFF14171A) : Colors.white;
    final Color textColor = isDark ? Colors.white : Colors.black87;
    final Color subTextColor = isDark ? Colors.white38 : Colors.black45;
    final Color borderColor = isDark ? Colors.white.withOpacity(0.05) : Colors.black.withOpacity(0.05);

    return Theme(
      data: isDark 
          ? ThemeData.dark().copyWith(
              scaffoldBackgroundColor: const Color(0xFF0A0C0E),
              cardColor: const Color(0xFF14171A),
              dividerColor: Colors.white10,
            )
          : ThemeData.light().copyWith(
              scaffoldBackgroundColor: const Color(0xFFF7F8FA),
              cardColor: Colors.white,
              dividerColor: Colors.black12,
            ),
      child: Scaffold(
        body: Stack(
          children: [
            // Mesh Gradient Background (Mobile Aesthetic)
            Positioned.fill(
              child: Opacity(
                opacity: isDark ? 0.15 : 0.08,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: RadialGradient(
                      center: Alignment(-0.8, -0.6),
                      radius: 1.5,
                      colors: [Color(0xFF1D4ED8), Colors.transparent],
                    ),
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Opacity(
                opacity: isDark ? 0.1 : 0.06,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: RadialGradient(
                      center: Alignment(0.8, 0.5),
                      radius: 1.2,
                      colors: [Color(0xFF9333EA), Colors.transparent],
                    ),
                  ),
                ),
              ),
            ),

            SafeArea(
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  // 1️⃣ Global Header — Virtual World (Glassmorphism)
                  _buildStickyHeader(context),

                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        // 2️⃣ System Snapshot (At-a-Glance)
                        _buildSystemSnapshot(),
                        const SizedBox(height: 32),

                        // 3️⃣ Discovery & Entry Hub
                        _buildSectionHeader('Discover & Participate'),
                        const SizedBox(height: 16),
                        _buildDiscoveryHub(),
                        const SizedBox(height: 32),

                        // 4️⃣ Organization Virtual World (Unified Model)
                        _buildExpandableSection(
                          key: 'unified_model',
                          title: 'Institutional Digital Twins',
                          subtitle: 'Mirrors real-world institutions with synced identities.',
                          content: _buildOrgUnifiedModel(),
                        ),
                        const SizedBox(height: 24),

                        // 5️⃣ Organization Capabilities Matrix
                        _buildExpandableSection(
                          key: 'matrix',
                          title: 'Capabilities Matrix',
                          subtitle: 'Integrated participation & management layers.',
                          content: _buildCapabilityMatrix(),
                        ),
                        const SizedBox(height: 24),

                        // 6️⃣ Structured Participation Layer
                        _buildExpandableSection(
                          key: 'participation',
                          title: 'Civic Participation',
                          subtitle: 'Moderated discussion & legislative simulations.',
                          content: _buildParticipationLayer(),
                        ),
                        const SizedBox(height: 24),

                        // 7️⃣ Education & Learning Layer
                        _buildExpandableSection(
                          key: 'education',
                          title: 'Learn & Simulate',
                          subtitle: 'Governance learning paths & policy scenarios.',
                          content: _buildEducationLayer(),
                        ),
                        const SizedBox(height: 32),

                        // 8️⃣ Notifications & Awareness
                        _buildSectionHeader('System Notifications'),
                        const SizedBox(height: 16),
                        _buildNotificationsList(),
                        const SizedBox(height: 32),

                        // 9️⃣ Trust, Moderation & Integrity
                        _buildExpandableSection(
                          key: 'trust',
                          title: 'Trust & Safety Framework',
                          subtitle: 'Internal audit & moderation transparency protocols.',
                          content: _buildTrustFramework(),
                        ),
                        const SizedBox(height: 32),

                        // 🔟 Admin, Analytics & Governance
                        _buildSectionHeader('Platform Governance'),
                        const SizedBox(height: 16),
                        _buildAdminAnalytics(),
                        const SizedBox(height: 60), // Extra space for mobile scroll comfort
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Premium Mobile UI Components ---

  Widget _buildStickyHeader(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return SliverAppBar(
      pinned: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      flexibleSpace: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(color: (isDark ? Colors.black : Colors.white).withOpacity(0.4)),
        ),
      ),
      expandedHeight: 120,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_new, color: isDark ? Colors.white70 : Colors.black54, size: 20),
        onPressed: () => Get.back(),
      ),
      title: Text(
        'VIRTUAL WORLD',
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, letterSpacing: 2, color: isDark ? Colors.white : Colors.black87),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildHeaderBadge('Global Sync', 'Active', Colors.greenAccent, isDark),
              _buildHeaderBadge('Jurisdiction', 'US/EU', Colors.blueAccent, isDark),
              _buildHeaderBadge('Role', 'Citizen', Colors.purpleAccent, isDark),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderBadge(String label, String val, Color color, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(width: 4, height: 4, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 6),
          Text('$label: ', style: TextStyle(fontSize: 9, color: isDark ? Colors.white38 : Colors.black38)),
          Text(val, style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }

  Widget _buildSystemSnapshot() {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      children: [
        _buildSnapshotItem('Orgs', '124', Icons.account_balance, isDark),
        _buildSnapshotItem('Live', '1.2K', Icons.sensors, isDark),
        _buildSnapshotItem('Legis', '842', Icons.gavel, isDark),
        _buildSnapshotItem('Polls', '3.1K', Icons.poll, isDark),
      ],
    );
  }

  Widget _buildSnapshotItem(String label, String value, IconData icon, bool isDark) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF14171A) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isDark ? Colors.white.withOpacity(0.05) : Colors.black.withOpacity(0.05)),
          boxShadow: isDark ? [] : [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)],
        ),
        child: Column(
          children: [
            Icon(icon, size: 14, color: isDark ? Colors.white24 : Colors.black26),
            const SizedBox(height: 6),
            Text(value, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black87)),
            Text(label, style: TextStyle(fontSize: 9, color: isDark ? Colors.white38 : Colors.black38)),
          ],
        ),
      ),
    );
  }

  Widget _buildDiscoveryHub() {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          _buildHubCard('UN General Assembly', 'Global Sovereignty', 'Voting Open', Colors.blueAccent, isDark),
          _buildHubCard('EU Digital Commission', 'Regional Policy', 'Active Debate', Colors.greenAccent, isDark),
          _buildHubCard('FIFA Federation', 'Governance', 'Live Stream', Colors.orangeAccent, isDark),
          _buildHubCard('WHO Council', 'Public Health', 'Simulation', Colors.purpleAccent, isDark),
        ],
      ),
    );
  }

  Widget _buildHubCard(String name, String type, String status, Color color, bool isDark) {
    return Container(
      width: 180,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF14171A) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isDark ? Colors.white.withOpacity(0.05) : Colors.black.withOpacity(0.05)),
        boxShadow: isDark ? [] : [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 20)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(type.toUpperCase(), style: TextStyle(fontSize: 9, color: color, fontWeight: FontWeight.bold, letterSpacing: 1)),
          const SizedBox(height: 12),
          Text(name, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, height: 1.3, color: isDark ? Colors.white : Colors.black87), maxLines: 2),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(width: 6, height: 6, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
              const SizedBox(width: 8),
              Text(status, style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.w600)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrgUnifiedModel() {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        _buildOrgTwinItem('Global Government', 'Executive Authority', '12 Active Modules', Colors.blueAccent, Icons.account_balance, isDark),
        _buildOrgTwinItem('Citizens Parliament', 'Legislative Chamber', '8 Policy Drafts', Colors.greenAccent, Icons.gavel, isDark),
        _buildOrgTwinItem('Omni NGO Hub', 'Social Impact Layer', '150 Organizations', Colors.purpleAccent, Icons.groups, isDark),
      ],
    );
  }

  Widget _buildOrgTwinItem(String title, String sub, String stat, Color color, IconData icon, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withOpacity(0.03) : Colors.black.withOpacity(0.02),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(backgroundColor: color.withOpacity(0.1), child: Icon(icon, color: color, size: 18)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black87)),
                Text(sub, style: TextStyle(fontSize: 11, color: isDark ? Colors.white38 : Colors.black45)),
              ],
            ),
          ),
          Text(stat, style: TextStyle(fontSize: 10, color: isDark ? Colors.white54 : Colors.black54)),
        ],
      ),
    );
  }

  Widget _buildCapabilityMatrix() {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final caps = [
      {'title': 'Overview', 'icon': Icons.info_outline},
      {'title': 'Leadership', 'icon': Icons.admin_panel_settings_outlined},
      {'title': 'Discussions', 'icon': Icons.forum_outlined},
      {'title': 'Legislation', 'icon': Icons.description_outlined},
      {'title': 'Polls', 'icon': Icons.bar_chart_outlined},
      {'title': 'Elections', 'icon': Icons.how_to_vote_outlined},
      {'title': 'Events', 'icon': Icons.sensors_outlined},
      {'title': 'Learn', 'icon': Icons.school_outlined},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2.8,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemCount: caps.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: isDark ? Colors.white.withOpacity(0.03) : Colors.black.withOpacity(0.02),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              caps[index]['title'] == 'Learn'
                  ? Image.asset('assets/images/learn_icon_3d.png', width: 16, height: 16)
                  : Icon(caps[index]['icon'] as IconData, size: 16, color: Colors.blueAccent),
              const SizedBox(width: 10),
              Text(caps[index]['title'] as String, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: isDark ? Colors.white : Colors.black87)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildParticipationLayer() {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        _buildParticipationCard('Moderated Discussion', 'Engage in verified civic debates with AI compliance.', 'Active', Colors.blueAccent, isDark),
        _buildParticipationCard('Policy Simulation', 'Draft and vote on non-binding digital legislation.', 'Simulation', Colors.purpleAccent, isDark),
      ],
    );
  }

  Widget _buildParticipationCard(String title, String desc, String tag, Color color, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withOpacity(0.03) : Colors.black.withOpacity(0.02),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: isDark ? Colors.white : Colors.black87)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
                child: Text(tag, style: TextStyle(fontSize: 9, color: color, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(desc, style: TextStyle(fontSize: 11, color: isDark ? Colors.white38 : Colors.black54, height: 1.4)),
        ],
      ),
    );
  }

  Widget _buildEducationLayer() {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        _buildEduModule('Governance Learning Paths', '12 Course Modules available', Icons.auto_stories, isDark),
        const SizedBox(height: 12),
        _buildEduModule('Crisis Simulations', '3 Ready to start', Icons.warning_amber, isDark),
      ],
    );
  }

  Widget _buildEduModule(String title, String sub, IconData icon, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withOpacity(0.03) : Colors.black.withOpacity(0.02),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.purpleAccent, size: 20),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black87)),
              Text(sub, style: TextStyle(fontSize: 10, color: isDark ? Colors.white24 : Colors.black26)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationsList() {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        _buildNotifyItem('Poll Opened', 'UN Assembly Sovereignty Vote', '2m ago', isDark),
        _buildNotifyItem('Policy Response', 'EU Data Act Compliance', '1h ago', isDark),
      ],
    );
  }

  Widget _buildNotifyItem(String title, String msg, String time, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: isDark ? Colors.white.withOpacity(0.02) : Colors.black.withOpacity(0.01), borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Container(width: 6, height: 6, decoration: const BoxDecoration(color: Colors.blueAccent, shape: BoxShape.circle)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: isDark ? Colors.white38 : Colors.black38)),
                Text(msg, style: TextStyle(fontSize: 12, color: isDark ? Colors.white70 : Colors.black87)),
              ],
            ),
          ),
          Text(time, style: TextStyle(fontSize: 9, color: isDark ? Colors.white24 : Colors.black26)),
        ],
      ),
    );
  }

  Widget _buildTrustFramework() {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.redAccent.withOpacity(isDark ? 0.05 : 0.08), borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('SYSTEM INTEGRITY PROTOCOL', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.redAccent)),
          const SizedBox(height: 16),
          Text('• AI Neutrality Audit: Pass', style: TextStyle(fontSize: 11, color: isDark ? Colors.white70 : Colors.black87)),
          Text('• Decentralized Logging: Verified', style: TextStyle(fontSize: 11, color: isDark ? Colors.white70 : Colors.black87)),
          Text('• Role Jurisdiction Enforcement: Active', style: TextStyle(fontSize: 11, color: isDark ? Colors.white70 : Colors.black87)),
        ],
      ),
    );
  }

  Widget _buildAdminAnalytics() {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildAdminMiniCard('Audit Logs', Icons.history_edu, isDark),
        _buildAdminMiniCard('User Compliance', Icons.gavel, isDark),
        _buildAdminMiniCard('Platform Health', Icons.bolt, isDark),
      ],
    );
  }

  Widget _buildAdminMiniCard(String title, IconData icon, bool isDark) {
    return Container(
      width: (Get.width - 48) / 3,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withOpacity(0.03) : Colors.black.withOpacity(0.02),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, size: 16, color: isDark ? Colors.white24 : Colors.black26),
          const SizedBox(height: 8),
          Text(title, style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black87), textAlign: TextAlign.center),
        ],
      ),
    );
  }

  // --- Helper Layouts ---

  Widget _buildSectionHeader(String title) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Text(
      title.toUpperCase(),
      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 1.5, color: isDark ? Colors.white24 : Colors.black26),
    );
  }

  Widget _buildExpandableSection({required String key, required String title, required String subtitle, required Widget content}) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    bool isExpanded = _expansionStates[key] ?? false;
    return Column(
      children: [
        InkWell(
          onTap: () => _toggleExpansion(key),
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF14171A) : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: isDark ? Colors.white.withOpacity(0.05) : Colors.black.withOpacity(0.05)),
              boxShadow: isExpanded ? [BoxShadow(color: (isDark ? Colors.blueAccent : Colors.black).withOpacity(0.05), blurRadius: 20)] : [],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black87)),
                      const SizedBox(height: 4),
                      Text(subtitle, style: TextStyle(fontSize: 12, color: isDark ? Colors.white38 : Colors.black38)),
                    ],
                  ),
                ),
                Icon(isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, color: isDark ? Colors.white24 : Colors.black26),
              ],
            ),
          ),
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(opacity: animation, child: SizeTransition(sizeFactor: animation, child: child));
          },
          child: isExpanded
              ? Padding(
                  padding: const EdgeInsets.only(top: 16, left: 4, right: 4),
                  child: content,
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
