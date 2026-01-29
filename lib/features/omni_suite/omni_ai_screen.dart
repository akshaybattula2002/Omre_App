import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class OmniAIScreen extends StatefulWidget {
  const OmniAIScreen({super.key});

  @override
  State<OmniAIScreen> createState() => _OmniAIScreenState();
}

class _OmniAIScreenState extends State<OmniAIScreen> {
  // Expansion states for inline modules
  final Map<String, bool> _expansionStates = {};

  final Color bgDeep = const Color(0xFF050709);
  final Color surfaceGlass = Colors.white.withOpacity(0.03);
  final Color accentTitan = const Color(0xFF6366F1); // Indigo-violet primary
  final Color accentCyan = const Color(0xFF22D3EE);
  final Color accentRose = const Color(0xFFFB7185);

  void _toggleExpansion(String key) {
    HapticFeedback.mediumImpact();
    setState(() {
      _expansionStates[key] = !(_expansionStates[key] ?? false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    // Adaptive Design Tokens
    final Color bgColor = isDark ? bgDeep : const Color(0xFFF7F8FA);
    final Color surfaceColor = isDark ? const Color(0xFF0F1115) : Colors.white;
    final Color textColor = isDark ? Colors.white : Colors.black87;
    final Color subTextColor = isDark ? Colors.white38 : Colors.black45;
    final Color borderColor = isDark ? Colors.white.withOpacity(0.05) : Colors.black.withOpacity(0.05);

    return Theme(
      data: isDark 
          ? ThemeData.dark().copyWith(
              scaffoldBackgroundColor: bgDeep,
              cardColor: const Color(0xFF0F1115),
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
            // Futuristic Gradient Background
            _buildBackgroundGradients(isDark),

            SafeArea(
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  // 1️⃣ TITANCONNECT IDENTITY HEADER (Sticky)
                  _buildStickyHeader(),

                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        // 2️⃣ PERSONAL DIGITAL STATUS CORE
                        _buildStatusCore(),
                        const SizedBox(height: 32),

                        // 3️⃣ AI-CURATED SOCIAL STREAM
                        _buildSectionLabel('Intelligent Discourse'),
                        const SizedBox(height: 16),
                        _buildSmartFeedPreview(),
                        const SizedBox(height: 32),

                        // 4️⃣ STORIES, REELS & LIVE
                        _buildSectionLabel('Co-Creation Hub'),
                        const SizedBox(height: 16),
                        _buildMediaStrip(),
                        const SizedBox(height: 32),

                        // 5️⃣ MESSAGING & COMMUNICATION HUB
                        _buildMessagingHub(),
                        const SizedBox(height: 32),

                        // 6️⃣ CREATOR & CONTENT ECONOMY
                        _buildCreatorEconomy(),
                        const SizedBox(height: 32),

                        // 7️⃣ COMMERCE & DIGITAL ASSETS
                        _buildCommerceModule(),
                        const SizedBox(height: 32),

                        // 8️⃣ GOVERNANCE, CIVIC & EDUCATION
                        _buildGovernanceHub(),
                        const SizedBox(height: 32),

                        // 9️⃣ AI & WELLBEING LAYER
                        _buildWellbeingModule(),
                        const SizedBox(height: 32),

                        // 🔟 GAMIFICATION & METAVERSE
                        _buildMetaversePreview(),
                        const SizedBox(height: 48),

                        // 1️⃣1️⃣ DATA OWNERSHIP & TRUST FOOTER
                        _buildOwnershipFooter(),
                        const SizedBox(height: 60),
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

  // --- Aesthetic Components ---

  Widget _buildBackgroundGradients(bool isDark) {
    return Positioned.fill(
      child: Stack(
        children: [
          Positioned(
            top: -100,
            right: -100,
            child: _blurSphere(accentTitan.withOpacity(isDark ? 0.15 : 0.08), 300),
          ),
          Positioned(
            bottom: 100,
            left: -50,
            child: _blurSphere(accentCyan.withOpacity(isDark ? 0.1 : 0.05), 250),
          ),
        ],
      ),
    );
  }

  Widget _blurSphere(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(colors: [color, Colors.transparent]),
      ),
    );
  }

  // --- Sticky Header ---

  Widget _buildStickyHeader() {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return SliverAppBar(
      pinned: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      flexibleSpace: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(color: (isDark ? Colors.black : Colors.white).withOpacity(0.6)),
        ),
      ),
      expandedHeight: 110,
      leadingWidth: 40,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 18, color: isDark ? Colors.white70 : Colors.black54),
          onPressed: () => Get.back(),
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'TITANCONNECT',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.5,
              foreground: Paint()
                ..shader = LinearGradient(
                  colors: isDark ? [Colors.white, accentCyan] : [accentTitan, accentCyan],
                ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
            ),
          ),
          Text(
            'Identity • Intelligence • Integrity',
            style: TextStyle(fontSize: 10, color: isDark ? Colors.white38 : Colors.black38, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      actions: [
        _buildHeaderAction(Icons.verified_user, 'Level 4', accentCyan),
        const SizedBox(width: 8),
        _buildHeaderAction(Icons.bolt, '842', Colors.amber),
        const SizedBox(width: 16),
      ],
    );
  }

  Widget _buildHeaderAction(IconData icon, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 6),
          Text(label, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }

  // --- Status Core ---

  Widget _buildStatusCore() {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF0F1115) : Colors.white,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: isDark ? Colors.white.withOpacity(0.05) : Colors.black.withOpacity(0.05)),
        boxShadow: [
          BoxShadow(color: (isDark ? accentTitan : Colors.black).withOpacity(0.03), blurRadius: 60, offset: const Offset(0, 20)),
        ],
      ),
      child: Column(
        children: [
          _buildReputationMeter(isDark),
          const SizedBox(height: 32),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: [
              _buildStatusChip('Identity: 98%', accentCyan),
              _buildStatusChip('Impact: High', accentTitan),
              _buildStatusChip('Gov: Active', Colors.greenAccent),
              _buildStatusChip('Creator: Gold', Colors.amber),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(child: _buildInlineBtn('Explain AI', Icons.psychology_outlined, isDark)),
              const SizedBox(width: 12),
              Expanded(child: _buildInlineBtn('Preferences', Icons.tune_outlined, isDark)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReputationMeter(bool isDark) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 160,
          height: 160,
          child: CircularProgressIndicator(
            value: 0.84,
            strokeWidth: 4,
            backgroundColor: isDark ? Colors.white.withOpacity(0.05) : Colors.black.withOpacity(0.05),
            valueColor: AlwaysStoppedAnimation<Color>(accentTitan),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('842', style: TextStyle(fontSize: 44, fontWeight: FontWeight.w900, color: isDark ? Colors.white : Colors.black87)),
            Text(
              'TRUST QUOTIENT',
              style: TextStyle(fontSize: 9, fontWeight: FontWeight.w900, letterSpacing: 1, color: accentTitan),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatusChip(String label, Color color) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(isDark ? 0.05 : 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(isDark ? 0.1 : 0.2)),
      ),
      child: Text(label, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: color)),
    );
  }

  // --- Smart Feed Preview ---

  Widget _buildSmartFeedPreview() {
    return Column(
      children: [
        _buildFeedCard(
          'Ethics of Autonomous Transit',
          'Civic Thread • Global Hub',
          'Explainable AI: Matches your interest in Urban Planning.',
          accentTitan,
        ),
        _buildFeedCard(
          'Co-Creating the Future of AR',
          'Creator Lab • Live in 5m',
          '98% match with your skill set.',
          accentCyan,
        ),
      ],
    );
  }

  Widget _buildFeedCard(String title, String meta, String aiReason, Color themeColor) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? surfaceGlass : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: isDark ? Colors.white.withOpacity(0.05) : Colors.black.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black87)),
                    const SizedBox(height: 4),
                    Text(meta, style: TextStyle(fontSize: 10, color: isDark ? Colors.white38 : Colors.black38)),
                  ],
                ),
              ),
              Icon(Icons.more_horiz, size: 18, color: isDark ? Colors.white24 : Colors.black26),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: themeColor.withOpacity(0.05), borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Icon(Icons.auto_awesome, size: 14, color: themeColor),
                const SizedBox(width: 10),
                Expanded(child: Text(aiReason, style: TextStyle(fontSize: 10, color: themeColor.withOpacity(0.8), fontStyle: FontStyle.italic))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Media Strip ---

  Widget _buildMediaStrip() {
    final media = [
      {'label': 'Live Event', 'type': 'Metaverse', 'color': accentRose},
      {'label': 'New Reel', 'type': 'Physics Sim', 'color': accentCyan},
      {'label': 'Podcast', 'type': 'AI Safety', 'color': accentTitan},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: media.map((m) => Container(
          width: 130,
          height: 180,
          margin: const EdgeInsets.only(right: 12),
          decoration: BoxDecoration(
            color: (m['color'] as Color).withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: (m['color'] as Color).withOpacity(0.2)),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(m['label'] as String, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white)),
                      Text(m['type'] as String, style: const TextStyle(fontSize: 9, color: Colors.white70)),
                    ],
                  ),
                ),
              ),
              Positioned(top: 16, right: 16, child: Icon(Icons.play_circle_fill, color: m['color'] as Color, size: 24)),
            ],
          ),
        )).toList(),
      ),
    );
  }

  // --- Modules ---

  Widget _buildMessagingHub() {
    return _buildExpandableModule(
      'messaging',
      'Communication Hub',
      'Encrypted • Context-Aware • Summarized',
      Icons.chat_bubble_outline,
      accentCyan,
      Column(
        children: [
          _buildMsgSummary('Design Sync', 'AI Summary: 3 decisions made regarding UI.'),
          _buildMsgSummary('Board Meeting', 'Suggested Reply: I can confirm my attendance.'),
        ],
      ),
    );
  }

  Widget _buildMsgSummary(String chat, String summary) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          CircleAvatar(radius: 12, backgroundColor: isDark ? Colors.white10 : Colors.black.withOpacity(0.05)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(chat, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black87)),
                Text(summary, style: TextStyle(fontSize: 10, color: isDark ? Colors.white24 : Colors.black38)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCreatorEconomy() {
    return _buildExpandableModule(
      'creator',
      'Creator Economy',
      'AI Co-Creation • monetization • Reward v2',
      Icons.auto_fix_high,
      accentTitan,
      const Text('Revenue distribution optimized for long-term depth, not virality.', style: TextStyle(fontSize: 11, color: Colors.white38)),
    );
  }

  Widget _buildCommerceModule() {
    return _buildExpandableModule(
      'commerce',
      'Commerce & Assets',
      'Social Marketplace • Micro-Payments',
      Icons.shopping_bag_outlined,
      Colors.greenAccent,
      const Text('Integrated identity-linked digital assets and tipping.', style: TextStyle(fontSize: 11, color: Colors.white38)),
    );
  }

  Widget _buildGovernanceHub() {
    return _buildExpandableModule(
      'governance',
      'Governance & Civic',
      'Simulations • Policy Voting • Transparency',
      Icons.account_balance_outlined,
      accentCyan,
      Column(
        children: [
          _buildGovItem('Community Rule 14.b', 'Voting ends in 4h'),
          _buildGovItem('AI Ethics Audit', 'Verified Transparent'),
        ],
      ),
    );
  }

  Widget _buildGovItem(String title, String val) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 12, color: isDark ? Colors.white70 : Colors.black87)),
          Text(val, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: accentCyan)),
        ],
      ),
    );
  }

  Widget _buildWellbeingModule() {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: accentRose.withOpacity(isDark ? 0.05 : 0.08), borderRadius: BorderRadius.circular(24)),
      child: Row(
        children: [
          Icon(Icons.spa_outlined, color: accentRose, size: 24),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Usage Balance: Optimal', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black87)),
                Text('Algorithmic nudges focused on positive social depth.', style: TextStyle(fontSize: 10, color: isDark ? accentRose.withOpacity(0.6) : accentRose)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetaversePreview() {
    return _buildExpandableModule(
      'metaverse',
      'MetaverseRooms',
      'Events • Concerts • Study Hubs',
      Icons.vrpano_outlined,
      Colors.purpleAccent,
      const Text('Collaborative study room live with 42 members.', style: TextStyle(fontSize: 11, color: Colors.white38)),
    );
  }

  Widget _buildOwnershipFooter() {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(color: isDark ? Colors.white.withOpacity(0.02) : Colors.black.withOpacity(0.02), borderRadius: BorderRadius.circular(32)),
      child: Column(
        children: [
          Text('SOVEREIGNTY & TRUST', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 2, color: isDark ? Colors.white24 : Colors.black26)),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _footerIcon(Icons.data_usage, 'Data Control', isDark),
              _footerIcon(Icons.visibility_off, 'Ad Shield', isDark),
              _footerIcon(Icons.security, 'Decentralized', isDark),
            ],
          ),
          const SizedBox(height: 32),
          Text(
            'Anti-algorithmic manipulation pledge active. No virality gaming logic enforced. Your identity safely mirrored across the Titan ecosystem.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 9, color: isDark ? Colors.white12 : Colors.black26, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _footerIcon(IconData icon, String label, bool isDark) {
    return Column(
      children: [
        Icon(icon, size: 20, color: isDark ? Colors.white24 : Colors.black26),
        const SizedBox(height: 8),
        Text(label, style: TextStyle(fontSize: 9, color: isDark ? Colors.white24 : Colors.black26)),
      ],
    );
  }

  // --- Shared Layout Helpers ---

  Widget _buildSectionLabel(String text) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Text(text.toUpperCase(), style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 1.5, color: isDark ? Colors.white24 : Colors.black26));
  }

  Widget _buildInlineBtn(String label, IconData icon, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withOpacity(0.03) : Colors.black.withOpacity(0.03),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isDark ? Colors.white10 : Colors.black12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 14, color: isDark ? Colors.white70 : Colors.black54),
          const SizedBox(width: 8),
          Text(label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black87)),
        ],
      ),
    );
  }

  Widget _buildExpandableModule(String key, String title, String sub, IconData icon, Color color, Widget content) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    bool isExp = _expansionStates[key] ?? false;
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF0F1115) : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: isExp ? color.withOpacity(0.3) : (isDark ? Colors.white.withOpacity(0.05) : Colors.black.withOpacity(0.05))),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () => _toggleExpansion(key),
            borderRadius: BorderRadius.circular(24),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(16)),
                    child: Icon(icon, size: 20, color: color),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black87)),
                        Text(sub, style: TextStyle(fontSize: 9, color: isDark ? Colors.white24 : Colors.black38, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  Icon(isExp ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, color: isDark ? Colors.white24 : Colors.black26),
                ],
              ),
            ),
          ),
          if (isExp) AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDark ? Colors.white.withOpacity(0.01) : Colors.black.withOpacity(0.01),
                borderRadius: BorderRadius.circular(20),
              ),
              child: content,
            ),
          ),
        ],
      ),
    );
  }
}
