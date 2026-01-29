import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class DigitalCitizenScreen extends StatefulWidget {
  const DigitalCitizenScreen({super.key});

  @override
  State<DigitalCitizenScreen> createState() => _DigitalCitizenScreenState();
}

class _DigitalCitizenScreenState extends State<DigitalCitizenScreen> {
  // Expansion states for interactive modules
  final Map<String, bool> _expansionStates = {
    'identity': true,
    'enforcement': false,
    'integrity': false,
    'governance': false,
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
                opacity: isDark ? 0.12 : 0.08,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: RadialGradient(
                      center: Alignment(-0.8, -0.6),
                      radius: 1.5,
                      colors: [Color(0xFF10B981), Colors.transparent], // Emerald accents for citizenship
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
                      colors: [Color(0xFF3B82F6), Colors.transparent], // Blue accents for trust
                    ),
                  ),
                ),
              ),
            ),

            SafeArea(
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  // 1️⃣ Global Header — Digital Citizen (Glassmorphism)
                  _buildGlassHeader(context),

                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        // 2️⃣ Primary Status Banner
                        _buildStatusBanner(),
                        const SizedBox(height: 32),

                        // 3️⃣ Identity & Trust Panel (Expandable)
                        _buildExpandableModule(
                          key: 'identity',
                          title: 'Identity & Trust Score',
                          subtitle: 'Credibility rooted in verification & behavior.',
                          icon: Icons.verified_user_outlined,
                          accentColor: Colors.blueAccent,
                          content: _buildIdentityTrustContent(),
                        ),
                        const SizedBox(height: 24),

                        // 4️⃣ Reputation Dimensions Grid
                        _buildSectionLabel('Reputation Dimensions'),
                        const SizedBox(height: 16),
                        _buildReputationGrid(),
                        const SizedBox(height: 32),

                        // 5️⃣ Rights & Responsibilities (Triptych)
                        _buildRightsResponsibilities(),
                        const SizedBox(height: 32),

                        // 6️⃣ Content Integrity (Expandable)
                        _buildExpandableModule(
                          key: 'integrity',
                          title: 'Content Integrity Audit',
                          subtitle: 'AI & human oversight status across your media.',
                          icon: Icons.security_outlined,
                          accentColor: Colors.purpleAccent,
                          content: _buildIntegrityContent(),
                        ),
                        const SizedBox(height: 24),

                        // 7️⃣ Civic Participation Hub
                        _buildSectionLabel('Civic Participation'),
                        const SizedBox(height: 16),
                        _buildCivicTiles(),
                        const SizedBox(height: 32),

                        // 8️⃣ Community Governance (Expandable)
                        _buildExpandableModule(
                          key: 'governance',
                          title: 'Community Governance',
                          subtitle: 'Jury eligibility & organizational voting weight.',
                          icon: Icons.gavel_outlined,
                          accentColor: Colors.orangeAccent,
                          content: _buildGovernanceContent(),
                        ),
                        const SizedBox(height: 32),

                        // 9️⃣ Citizenship Badges
                        _buildSectionLabel('Institutional Recognition'),
                        const SizedBox(height: 16),
                        _buildBadgesTray(),
                        const SizedBox(height: 32),

                        // 🔟 Enforcement History (Expandable)
                        _buildExpandableModule(
                          key: 'enforcement',
                          title: 'Enforcement History',
                          subtitle: 'Transparent log of warnings & active limitations.',
                          icon: Icons.history_edu_outlined,
                          accentColor: Colors.redAccent,
                          content: _buildEnforcementLog(),
                        ),
                        const SizedBox(height: 48),

                        // 📋 AI Ethics Footer
                        _buildEthicsTransparencyFooter(),
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

  // --- Premium UI Components ---

  Widget _buildGlassHeader(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return SliverAppBar(
      pinned: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      flexibleSpace: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(color: (isDark ? Colors.black : Colors.white).withOpacity(0.5)),
        ),
      ),
      expandedHeight: 100,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_new, color: isDark ? Colors.white70 : Colors.black54, size: 18),
        onPressed: () => Get.back(),
      ),
      title: Text(
        'CITIZENSHIP DASHBOARD',
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 2, color: isDark ? Colors.white54 : Colors.black45),
      ),
      centerTitle: true,
    );
  }

  Widget _buildStatusBanner() {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF14171A) : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: isDark ? Colors.white.withOpacity(0.05) : Colors.black.withOpacity(0.05)),
        boxShadow: [
          BoxShadow(color: (isDark ? Colors.blueAccent : Colors.black).withOpacity(0.05), blurRadius: 40, offset: const Offset(0, 10)),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Current Tier', style: TextStyle(color: isDark ? Colors.white38 : Colors.black38, fontSize: 11)),
                  const SizedBox(height: 4),
                  Text('Trusted Citizen', style: TextStyle(color: isDark ? Colors.white : Colors.black87, fontSize: 22, fontWeight: FontWeight.bold)),
                ],
              ),
              const Icon(Icons.verified_user, color: Colors.blueAccent, size: 40),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTrustCircular('Identity', 0.95, Colors.blueAccent, isDark),
              _buildTrustCircular('Behavior', 0.88, Colors.tealAccent, isDark),
              _buildTrustCircular('Integrity', 1.0, Colors.purpleAccent, isDark),
              _buildTrustCircular('Civic', 0.72, Colors.orangeAccent, isDark),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTrustCircular(String label, double val, Color color, bool isDark) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 54,
              height: 54,
              child: CircularProgressIndicator(
                value: val,
                strokeWidth: 3,
                backgroundColor: color.withOpacity(0.1),
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ),
            Text('${(val * 100).toInt()}%', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black87)),
          ],
        ),
        const SizedBox(height: 10),
        Text(label, style: TextStyle(fontSize: 10, color: isDark ? Colors.white38 : Colors.black38)),
      ],
    );
  }

  Widget _buildIdentityTrustContent() {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        _buildTrustRow('Email Verified', true, isDark),
        _buildTrustRow('Phone Verified', true, isDark),
        _buildTrustRow('Biometric Link (Protected)', true, isDark),
        _buildTrustRow(' Institutional Sync', true, isDark),
        const Divider(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Account Maturity', style: TextStyle(color: isDark ? Colors.white38 : Colors.black38, fontSize: 12)),
            Text('8.4 Years', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: isDark ? Colors.white : Colors.black87)),
          ],
        ),
      ],
    );
  }

  Widget _buildTrustRow(String label, bool verified, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 13, color: isDark ? Colors.white70 : Colors.black87)),
          Icon(verified ? Icons.check_circle : Icons.radio_button_unchecked, color: verified ? Colors.tealAccent : (isDark ? Colors.white10 : Colors.black12), size: 16),
        ],
      ),
    );
  }

  Widget _buildReputationGrid() {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final statusData = [
      {'label': 'Civic Behavior', 'status': 'Exceptional', 'color': Colors.tealAccent},
      {'label': 'Content Context', 'status': 'High Accuracy', 'color': Colors.blueAccent},
      {'label': 'Reporting Integrity', 'status': 'Balanced', 'color': Colors.orangeAccent},
      {'label': 'System Interaction', 'status': 'Neutral', 'color': isDark ? Colors.white54 : Colors.black45},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.6,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemCount: statusData.length,
      itemBuilder: (context, index) {
        final d = statusData[index];
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF14171A) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: isDark ? Colors.white.withOpacity(0.04) : Colors.black.withOpacity(0.05)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(d['label'] as String, style: TextStyle(fontSize: 10, color: isDark ? Colors.white38 : Colors.black38)),
              const Spacer(),
              Text(d['status'] as String, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: d['color'] as Color)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRightsResponsibilities() {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      children: [
        Expanded(
          child: _buildPolicyBox('YOUR RIGHTS', [
            'Appeal Moderation',
            'Data Ownership',
            'Neutral Access',
            'Privacy Shield',
          ], Colors.blueAccent, isDark),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildPolicyBox('YOUR DUTIES', [
            'Authentic Interaction',
            'System Compliance',
            'Verified Information',
            'No Coordinated Harm',
          ], Colors.orangeAccent, isDark),
        ),
      ],
    );
  }

  Widget _buildPolicyBox(String title, List<String> list, Color color, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF14171A) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(isDark ? 0.1 : 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.w900, letterSpacing: 1)),
          const SizedBox(height: 16),
          ...list.map((item) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Container(width: 3, height: 3, decoration: BoxDecoration(color: color.withOpacity(0.5), shape: BoxShape.circle)),
                const SizedBox(width: 8),
                Expanded(child: Text(item, style: TextStyle(fontSize: 10, color: isDark ? Colors.white54 : Colors.black54))),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildIntegrityContent() {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        _buildIntegrityStat('Labeled Content', '0 Items', Icons.label_important_outline, isDark),
        _buildIntegrityStat('Contextualized Media', '0 Overlays', Icons.auto_awesome_motion_outlined, isDark),
        _buildIntegrityStat('AI Content Disclosure', 'Pass (Verified)', Icons.policy_outlined, isDark),
        const SizedBox(height: 12),
        Text('AI & Human moderation audits occur 24/7 for platform synchronization.', style: TextStyle(fontSize: 10, color: isDark ? Colors.white24 : Colors.black26, fontStyle: FontStyle.italic)),
      ],
    );
  }

  Widget _buildIntegrityStat(String label, String val, IconData icon, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 16, color: isDark ? Colors.white24 : Colors.black26),
          const SizedBox(width: 16),
          Text(label, style: TextStyle(fontSize: 13, color: isDark ? Colors.white70 : Colors.black87)),
          const Spacer(),
          Text(val, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.tealAccent)),
        ],
      ),
    );
  }

  Widget _buildCivicTiles() {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        _buildCivicTile('Governance Debate Chambers', 'Role-aware, moderated discussion suites.', Icons.chat_bubble_outline, isDark),
        _buildCivicTile('Verified Institutional AMAs', 'Direct line to verified world leaders.', Icons.verified_user_outlined, isDark),
        _buildCivicTile('Region-Aware Legislation Hub', 'Local policy updates & simulation votes.', Icons.how_to_vote_outlined, isDark),
      ],
    );
  }

  Widget _buildCivicTile(String title, String sub, IconData icon, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        tileColor: isDark ? Colors.white.withOpacity(0.02) : Colors.black.withOpacity(0.02),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        leading: Icon(icon, color: isDark ? Colors.white24 : Colors.black26, size: 20),
        title: Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black87)),
        subtitle: Text(sub, style: TextStyle(fontSize: 11, color: isDark ? Colors.white38 : Colors.black38)),
        trailing: Icon(Icons.chevron_right, size: 16, color: isDark ? Colors.white10 : Colors.black12),
      ),
    );
  }

  Widget _buildGovernanceContent() {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Voting Power', style: TextStyle(color: isDark ? Colors.white38 : Colors.black38, fontSize: 12)),
            const Text('1.0x (Standard)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.blueAccent)),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Jury Eligibility', style: TextStyle(color: isDark ? Colors.white38 : Colors.black38, fontSize: 12)),
            const Text('QUALIFIED', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.tealAccent)),
          ],
        ),
        const Divider(height: 32),
        Text('Your organizational involvement is tracked for institutional transparency.', style: TextStyle(fontSize: 10, color: isDark ? Colors.white24 : Colors.black26)),
      ],
    );
  }

  Widget _buildBadgesTray() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          _buildCitizenBadge('Trusted Citizen', Icons.shield, Colors.blueAccent),
          _buildCitizenBadge('Truth Anchor', Icons.anchor, Colors.purpleAccent),
          _buildCitizenBadge('Civic Pioneer', Icons.rocket_launch, Colors.tealAccent),
        ],
      ),
    );
  }

  Widget _buildCitizenBadge(String label, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 10),
          Text(label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }

  Widget _buildEnforcementLog() {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        _buildEnforcementItem('Soft Warning', 'Misleading Information', 'Expired', Colors.orangeAccent, isDark),
        _buildEnforcementItem('Reduced Reach', 'Inauthentic Interaction', 'Appealed', Colors.redAccent, isDark),
      ],
    );
  }

  Widget _buildEnforcementItem(String type, String reason, String status, Color color, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: isDark ? Colors.white.withOpacity(0.03) : Colors.black.withOpacity(0.02), borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(type, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: color)),
              Text(reason, style: TextStyle(fontSize: 10, color: isDark ? Colors.white38 : Colors.black38)),
            ],
          ),
          Text(status, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: isDark ? Colors.white54 : Colors.black54)),
        ],
      ),
    );
  }

  Widget _buildEthicsTransparencyFooter() {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF14171A) : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: isDark ? Colors.white.withOpacity(0.05) : Colors.black.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('AI ETHICS & PLATFORM TRANSPARENCY', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 2, color: isDark ? Colors.white38 : Colors.black38)),
          const SizedBox(height: 24),
          _buildEthicsIndicator('Algorithm Audit (v2.4.9) Verified', isDark),
          _buildEthicsIndicator('No Sub-conscious Influence active', isDark),
          _buildEthicsIndicator('Synthetic Media Disclosures enforced', isDark),
          const SizedBox(height: 24),
          Text(
            'Digital citizenship is a fundamental right. Platform governance ensures a safe, accountable, and transparent institutional experience for all.',
            style: TextStyle(fontSize: 10, color: isDark ? Colors.white24 : Colors.black26, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildEthicsIndicator(String txt, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          const Icon(Icons.check_circle_outline, size: 14, color: Colors.blueAccent),
          const SizedBox(width: 12),
          Text(txt, style: TextStyle(fontSize: 11, color: isDark ? Colors.white54 : Colors.black54)),
        ],
      ),
    );
  }

  // --- Helper Layouts ---

  Widget _buildSectionLabel(String txt) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Text(txt.toUpperCase(), style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 1.5, color: isDark ? Colors.white24 : Colors.black26));
  }

  Widget _buildExpandableModule({required String key, required String title, required String subtitle, required IconData icon, required Color accentColor, required Widget content}) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    bool isExpanded = _expansionStates[key] ?? false;
    return Column(
      children: [
        InkWell(
          onTap: () => _toggleExpansion(key),
          borderRadius: BorderRadius.circular(24),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF14171A) : Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: isExpanded ? accentColor.withOpacity(0.3) : (isDark ? Colors.white.withOpacity(0.05) : Colors.black.withOpacity(0.05))),
              boxShadow: isExpanded ? [BoxShadow(color: accentColor.withOpacity(0.05), blurRadius: 40)] : [],
            ),
            child: Row(
              children: [
                CircleAvatar(backgroundColor: accentColor.withOpacity(0.1), child: Icon(icon, color: accentColor, size: 20)),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black87)),
                      const SizedBox(height: 4),
                      Text(subtitle, style: TextStyle(fontSize: 11, color: isDark ? Colors.white38 : Colors.black38)),
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
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(color: isDark ? Colors.white.withOpacity(0.02) : Colors.black.withOpacity(0.01), borderRadius: BorderRadius.circular(24)),
                    child: content,
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
