import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class OmniKnowScreen extends StatefulWidget {
  const OmniKnowScreen({super.key});

  @override
  State<OmniKnowScreen> createState() => _OmniKnowScreenState();
}

class _OmniKnowScreenState extends State<OmniKnowScreen> {
  // --- State for Inline Expansions ---
  final Map<String, bool> _expansionStates = {};
  double _skillLevel = 0.5; // 0.0: Beginner, 1.0: Expert
  String _selectedLanguage = 'English';

  void _toggleExpansion(String key) {
    HapticFeedback.mediumImpact();
    setState(() {
      _expansionStates[key] = !(_expansionStates[key] ?? false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    // Scholarly Premium Theme Tokens
    final Color bgColor = isDark ? const Color(0xFF0F1115) : const Color(0xFFFDFCF9);
    final Color surfaceColor = isDark ? const Color(0xFF1A1D23) : Colors.white;
    final Color accentGold = const Color(0xFFD4AF37);
    final Color accentBlue = const Color(0xFF2C5282);
    final Color textColor = isDark ? Colors.white : const Color(0xFF1A202C);
    final Color subTextColor = isDark ? Colors.white54 : Colors.black54;

    return Theme(
      data: isDark 
          ? ThemeData.dark().copyWith(
              scaffoldBackgroundColor: bgColor,
              cardColor: surfaceColor,
              dividerColor: Colors.white10,
            )
          : ThemeData.light().copyWith(
              scaffoldBackgroundColor: bgColor,
              cardColor: surfaceColor,
              dividerColor: Colors.black12,
            ),
      child: Scaffold(
        backgroundColor: bgColor,
        body: Stack(
          children: [
            // Elegant Background Texture / Glows
            _buildBackgroundDesign(isDark),

            SafeArea(
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  // 1️⃣ IDENTITY HEADER (Sticky)
                  _buildIdentityHeader(context, isDark, textColor),

                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        const SizedBox(height: 24),

                        // 2️⃣ OMNISEARCH + AI GUIDE
                        _buildOmniSearch(isDark, surfaceColor, textColor, subTextColor, accentGold),
                        const SizedBox(height: 32),

                        // 3️⃣ KNOWLEDGE DOMAINS MAP
                        _buildSectionHeader('Knowledge Domains Map', isDark, accentGold),
                        const SizedBox(height: 16),
                        _buildDomainsGrid(isDark, surfaceColor, textColor),
                        const SizedBox(height: 32),

                        // 4️⃣ FEATURED CONTENT STREAM
                        _buildSectionHeader('Featured for You', isDark, accentGold),
                        const SizedBox(height: 16),
                        _buildFeaturedStream(isDark, surfaceColor, textColor, subTextColor),
                        const SizedBox(height: 32),

                        // 5️⃣ IMMERSIVE & INTERACTIVE LEARNING
                        _buildExpandableModule(
                          'immersive',
                          'Immersive Learning',
                          'VR, 3D Museums, and Field Exploration',
                          Icons.view_in_ar,
                          _buildImmersiveContent(isDark, surfaceColor, textColor),
                          isDark, accentGold, textColor, subTextColor, surfaceColor,
                        ),
                        const SizedBox(height: 16),

                        // 6️⃣ PERSONALIZED LEARNING PATHS
                        _buildLearningPaths(isDark, surfaceColor, textColor, subTextColor, accentBlue),
                        const SizedBox(height: 32),

                        // 7️⃣ COMMUNITY & COLLABORATION HUB
                        _buildSectionHeader('Community Hub', isDark, accentGold),
                        const SizedBox(height: 16),
                        _buildCommunityHub(isDark, surfaceColor, textColor, subTextColor),
                        const SizedBox(height: 32),

                        // 8️⃣ CONTRIBUTION & CREDIBILITY
                        _buildContributionSection(isDark, surfaceColor, textColor, subTextColor, accentGold),
                        const SizedBox(height: 32),

                        // 9️⃣ AI & SMART KNOWLEDGE FEATURES
                        _buildAISmartFeatures(isDark, surfaceColor, textColor, subTextColor, accentGold),
                        const SizedBox(height: 32),

                        // 🔟 ACCESSIBILITY & GLOBAL ACCESS
                        _buildAccessibilityFeatures(isDark, surfaceColor, textColor, subTextColor),
                        const SizedBox(height: 32),

                        // 1️⃣1️⃣ SUSTAINABILITY & MONETIZATION
                        _buildSustainabilitySection(isDark, surfaceColor, textColor, subTextColor),
                        const SizedBox(height: 48),

                        // 1️⃣2️⃣ VISION FOOTER
                        _buildVisionFooter(isDark, textColor, subTextColor, accentGold),
                        const SizedBox(height: 80),
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

  // --- Background Design ---
  Widget _buildBackgroundDesign(bool isDark) {
    return Positioned.fill(
      child: Opacity(
        opacity: isDark ? 0.05 : 0.03,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const NetworkImage('https://www.transparenttextures.com/patterns/paper-fibers.png'),
              repeat: ImageRepeat.repeat,
              colorFilter: ColorFilter.mode(isDark ? Colors.white : Colors.black, BlendMode.srcIn),
            ),
          ),
        ),
      ),
    );
  }

  // --- 1️⃣ Identity Header ---
  Widget _buildIdentityHeader(BuildContext context, bool isDark, Color textColor) {
    return SliverAppBar(
      pinned: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      flexibleSpace: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(color: (isDark ? Colors.black : Colors.white).withOpacity(0.7)),
        ),
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_new, color: textColor.withOpacity(0.7), size: 18),
        onPressed: () => Navigator.pop(context),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'OMNIKNOW',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              letterSpacing: 2,
              color: textColor,
              fontFamily: 'Serif',
            ),
          ),
          Text(
            'The World Knowledge Library',
            style: TextStyle(fontSize: 10, color: textColor.withOpacity(0.5), letterSpacing: 1),
          ),
        ],
      ),
      actions: [
        _buildHeaderAction(Icons.translate, () => _showLanguageSelector(context)),
        _buildHeaderAction(Icons.mic_none, () {}),
        Padding(
          padding: const EdgeInsets.only(right: 16, left: 8),
          child: CircleAvatar(
            radius: 14,
            backgroundColor: textColor.withOpacity(0.1),
            child: Icon(Icons.person_outline, size: 16, color: textColor),
          ),
        ),
      ],
      expandedHeight: 120,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 12, left: 20, right: 20),
          child: Text(
            'Explore science, culture, history, religion, nature, and human creativity—through text, video, simulations, and immersive worlds.',
            style: TextStyle(fontSize: 10, color: textColor.withOpacity(0.6), height: 1.4),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderAction(IconData icon, VoidCallback onTap) {
    return IconButton(
      icon: Icon(icon, size: 20),
      onPressed: onTap,
    );
  }

  // --- 2️⃣ OmniSearch + AI Guide ---
  Widget _buildOmniSearch(bool isDark, Color surface, Color text, Color subText, Color gold) {
    bool isAiLogicExpanded = _expansionStates['ai_logic'] ?? false;
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: surface,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: text.withOpacity(0.1)),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, 5))],
          ),
          child: TextField(
            style: TextStyle(color: text),
            decoration: InputDecoration(
              hintText: 'Ask anything about the universe, life, history...',
              hintStyle: TextStyle(fontSize: 14, color: text.withOpacity(0.3)),
              border: InputBorder.none,
              icon: Icon(Icons.search, color: gold, size: 22),
            ),
          ),
        ),
        const SizedBox(height: 16),
        InkWell(
          onTap: () => _toggleExpansion('ai_logic'),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: gold.withOpacity(0.05),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: gold.withOpacity(0.2)),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.auto_awesome, color: gold, size: 16),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('AI Knowledge Tutor Active', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: gold)),
                          Text('Results adapt to your language, level, and interests.', style: TextStyle(fontSize: 9, color: text.withOpacity(0.6))),
                        ],
                      ),
                    ),
                    Icon(isAiLogicExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, size: 16, color: gold),
                  ],
                ),
                if (isAiLogicExpanded) ...[
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Divider(height: 1),
                  ),
                  Text(
                    'Explainable AI Logic: Our models prioritize peer-reviewed sources from partner museums and academic institutions. Difficulty is adjusted based on your active learning profile.',
                    style: TextStyle(fontSize: 10, color: text.withOpacity(0.7), height: 1.5),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Text('Skill Level: ', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: text)),
                      const Spacer(),
                      Text(_skillLevel < 0.3 ? 'Beginner' : _skillLevel < 0.7 ? 'Intermediate' : 'Expert', 
                           style: TextStyle(fontSize: 10, color: gold, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SliderTheme(
                    data: SliderThemeData(
                      activeTrackColor: gold,
                      inactiveTrackColor: gold.withOpacity(0.1),
                      thumbColor: gold,
                      overlayColor: gold.withOpacity(0.2),
                      trackHeight: 2,
                    ),
                    child: Slider(
                      value: _skillLevel,
                      onChanged: (val) => setState(() => _skillLevel = val),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  // --- 3️⃣ Knowledge Domains Map ---
  Widget _buildDomainsGrid(bool isDark, Color surface, Color text) {
    final domains = [
      {'name': 'Science & Tech', 'icon': Icons.biotech, 'topics': 'Physics, AI, Space', 'count': '1.2M+', 'color': Colors.blue},
      {'name': 'Medicine & Health', 'icon': Icons.medical_services_outlined, 'topics': 'Anatomy, Vaccine, Genes', 'count': '850K', 'color': Colors.red},
      {'name': 'Humanities & Arts', 'icon': Icons.palette_outlined, 'topics': 'Philosophy, History, Art', 'count': '2.1M+', 'color': Colors.orange},
      {'name': 'Nature & Environment', 'icon': Icons.landscape_outlined, 'topics': 'Climate, Zoology, Botany', 'count': '940K', 'color': Colors.green},
      {'name': 'Culture & Society', 'icon': Icons.people_outline, 'topics': 'Anthropology, Law, Music', 'count': '1.5M', 'color': Colors.purple},
      {'name': 'Museums & Archives', 'icon': Icons.museum_outlined, 'topics': 'Louvre, Smithsonian, Cairo', 'count': '3K Collections', 'color': Colors.brown},
    ];

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: domains.map((d) => _buildDomainCard(d, isDark, surface, text)).toList(),
    );
  }

  Widget _buildDomainCard(Map<String, dynamic> d, bool isDark, Color surface, Color text) {
    String key = 'domain_${d['name']}';
    bool isExp = _expansionStates[key] ?? false;
    Color dColor = d['color'] as Color;

    return InkWell(
      onTap: () => _toggleExpansion(key),
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: isExp ? (Get.width - 40) : (Get.width - 52) / 2,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isExp ? dColor.withOpacity(0.3) : text.withOpacity(0.05)),
          boxShadow: isExp ? [BoxShadow(color: dColor.withOpacity(0.05), blurRadius: 20)] : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(d['icon'] as IconData, color: dColor, size: 24),
                const Spacer(),
                Text(d['count'] as String, style: TextStyle(fontSize: 9, color: text.withOpacity(0.4), fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 12),
            Text(d['name'] as String, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: text)),
            const SizedBox(height: 4),
            Text(d['topics'] as String, style: TextStyle(fontSize: 9, color: text.withOpacity(0.5))),
            if (isExp) ...[
              const SizedBox(height: 16),
              const Divider(height: 1),
              const SizedBox(height: 12),
              Text('Featured Content in ${d['name']}', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: text)),
              const SizedBox(height: 8),
              _buildFeaturedMiniList(dColor, text),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedMiniList(Color color, Color text) {
    return Column(
      children: [
        _buildMiniItem('The Quantum Revolution', 'Video • 12m', color, text),
        _buildMiniItem('History of Ethics', 'Audio • 45m', color, text),
      ],
    );
  }

  Widget _buildMiniItem(String title, String meta, Color color, Color text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(width: 4, height: 4, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 10),
          Expanded(child: Text(title, style: TextStyle(fontSize: 10, color: text.withOpacity(0.8)))),
          Text(meta, style: TextStyle(fontSize: 8, color: text.withOpacity(0.4))),
        ],
      ),
    );
  }

  // --- 4️⃣ Featured Content Stream ---
  Widget _buildFeaturedStream(bool isDark, Color surface, Color text, Color subText) {
    final content = [
      {'title': 'SpaceX Mars Habitat Sim', 'type': 'SIMULATION', 'level': 'Expert', 'time': '20m', 'icon': Icons.rocket_launch, 'ver': true},
      {'title': 'The Silk Road Documentary', 'type': 'VIDEO', 'level': 'Intermediate', 'time': '52m', 'icon': Icons.movie_outlined, 'ver': true},
      {'title': 'Arabic Calligraphy Masterclass', 'type': 'AI LESSON', 'level': 'Beginner', 'time': '15m', 'icon': Icons.brush_outlined, 'ver': false},
    ];

    return Column(
      children: content.map((c) => _buildContentCard(c, isDark, surface, text, subText)).toList(),
    );
  }

  Widget _buildContentCard(Map<String, dynamic> c, bool isDark, Color surface, Color text, Color subText) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: text.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: text.withOpacity(0.03),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(c['icon'] as IconData, color: text.withOpacity(0.3), size: 30),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(c['type'] as String, style: const TextStyle(fontSize: 8, fontWeight: FontWeight.w900, color: Colors.blueAccent, letterSpacing: 1)),
                    const Spacer(),
                    if (c['ver'] == true) Icon(Icons.verified, size: 10, color: Colors.blueAccent.withOpacity(0.7)),
                  ],
                ),
                const SizedBox(height: 6),
                Text(c['title'] as String, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: text)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _buildMetaBadge(c['level'] as String, Colors.orange, text),
                    const SizedBox(width: 8),
                    _buildMetaBadge(c['time'] as String, Colors.blueGrey, text),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetaBadge(String label, Color color, Color text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
      child: Text(label, style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: color)),
    );
  }

  // --- 5️⃣ Immersive & Interactive Learning ---
  Widget _buildImmersiveContent(bool isDark, Color surface, Color text) {
    return Column(
      children: [
        _buildImmersiveTile('British Museum 3D', 'Explore 2k+ artifacts in high fidelity.', Icons.view_in_ar, Colors.teal),
        _buildImmersiveTile('CERN Hadron Collider', 'Interactive particle physics simulation.', Icons.bolt_outlined, Colors.purple),
        _buildImmersiveTile('Ancient Rome VR', 'Walk the streets of 300 AD.', Icons.history_edu, Colors.orange),
      ],
    );
  }

  Widget _buildImmersiveTile(String title, String sub, IconData icon, Color color) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color text = isDark ? Colors.white : Colors.black87;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          CircleAvatar(backgroundColor: color.withOpacity(0.1), child: Icon(icon, color: color, size: 18)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: text)),
                Text(sub, style: TextStyle(fontSize: 10, color: text.withOpacity(0.4))),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 12, color: Colors.grey),
        ],
      ),
    );
  }

  // --- 6️⃣ Personalized Learning Paths ---
  Widget _buildLearningPaths(bool isDark, Color surface, Color text, Color subText, Color accent) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: accent.withOpacity(0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: accent.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.track_changes, color: accent, size: 18),
              const SizedBox(width: 10),
              Text('Your Learning Path', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: text)),
            ],
          ),
          const SizedBox(height: 16),
          _buildPathStep('Current: Philosophy of Science', true, text, accent),
          _buildPathStep('Suggested: Ethical AI Frameworks', false, text, accent),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: surface.withOpacity(0.5), borderRadius: BorderRadius.circular(12)),
            child: Text(
              '🚨 Knowledge Gap: Basic Linear Algebra found in path prerequisite. Would you like to generate a bridge module?',
              style: TextStyle(fontSize: 10, color: Colors.redAccent.withOpacity(0.8), fontStyle: FontStyle.italic),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildSmallBtn('Continue Path', true, accent),
              const SizedBox(width: 12),
              _buildSmallBtn('Generate New', false, accent),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPathStep(String title, bool active, Color text, Color accent) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(active ? Icons.play_circle_fill : Icons.circle_outlined, color: active ? accent : text.withOpacity(0.2), size: 14),
          const SizedBox(width: 10),
          Text(title, style: TextStyle(fontSize: 11, color: active ? text : text.withOpacity(0.5), fontWeight: active ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }

  // --- 7️⃣ Community & Collaboration ---
  Widget _buildCommunityHub(bool isDark, Color surface, Color text, Color subText) {
    return Column(
      children: [
        _buildCommunityTile('Global Philosophy Forum', '2.4k Active', Icons.forum_outlined),
        _buildCommunityTile('Expert Q&A: Astronomy', 'Live Now', Icons.live_tv, active: true),
        _buildCommunityTile('Space Law Collaboration', '12 Contributors', Icons.edit_document),
      ],
    );
  }

  Widget _buildCommunityTile(String title, String count, IconData icon, {bool active = false}) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color text = isDark ? Colors.white : Colors.black87;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: isDark ? Colors.white.withOpacity(0.02) : Colors.black.withOpacity(0.02), borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          Icon(icon, size: 18, color: active ? Colors.green : text.withOpacity(0.4)),
          const SizedBox(width: 16),
          Expanded(child: Text(title, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: text))),
          Text(count, style: TextStyle(fontSize: 10, color: active ? Colors.green : text.withOpacity(0.4), fontWeight: active ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }

  // --- 8️⃣ Contribution & Credibility ---
  Widget _buildContributionSection(bool isDark, Color surface, Color text, Color subText, Color gold) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: surface, borderRadius: BorderRadius.circular(24), border: Border.all(color: text.withOpacity(0.05))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Contribute to Human Knowledge', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: text)),
          const SizedBox(height: 8),
          Text('Upload content, co-author articles, or curate collections with academic oversight.', style: TextStyle(fontSize: 11, color: subText)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildContributorStat('Peer Reviewed', '85%', Icons.verified_user_outlined, Colors.blue),
              _buildContributorStat('Institutions', '124', Icons.account_balance_outlined, Colors.purple),
              _buildContributorStat('Your Rep', '4.9', Icons.star_outline, gold),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: gold, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
              child: const Text('Access Contributor Portal', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContributorStat(String label, String val, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 16),
        const SizedBox(height: 6),
        Text(val, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(fontSize: 8, color: Colors.grey)),
      ],
    );
  }

  // --- 9️⃣ AI & Smart Knowledge Features ---
  Widget _buildAISmartFeatures(bool isDark, Color surface, Color text, Color subText, Color gold) {
    return _buildExpandableModule(
      'ai_smart',
      'AI & Smart Features',
      'Transparency, Voice, and Adaptive Logic',
      Icons.smart_toy_outlined,
      Column(
        children: [
          _buildSmartFeatureTile('AI Tutor & Quizzes', 'Generate instant knowledge checks.'),
          _buildSmartFeatureTile('Dynamic Updates', 'Live research feeds integrated hourly.'),
          _buildSmartFeatureTile('Bias-Aware Logic', 'AI explanations are explainable and audited.'),
        ],
      ),
      isDark, gold, text, subText, surface,
    );
  }

  Widget _buildSmartFeatureTile(String title, String desc) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color text = isDark ? Colors.white : Colors.black87;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: text)),
          const SizedBox(height: 4),
          Text(desc, style: TextStyle(fontSize: 10, color: text.withOpacity(0.4))),
        ],
      ),
    );
  }

  // --- 🔟 Accessibility & Global Access ---
  Widget _buildAccessibilityFeatures(bool isDark, Color surface, Color text, Color subText) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.blue.withOpacity(0.02), borderRadius: BorderRadius.circular(24), border: Border.all(color: Colors.blue.withOpacity(0.1))),
      child: Row(
        children: [
          Icon(Icons.accessibility_new, color: Colors.blue, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Universal Accessibility', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: text)),
                Text('Offline downloads • Low-bandwidth mode • Multilingual Support', style: TextStyle(fontSize: 10, color: text.withOpacity(0.4))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- 1️⃣1️⃣ Sustainability & Monetization ---
  Widget _buildSustainabilitySection(bool isDark, Color surface, Color text, Color subText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Ecosystem Sustainability', isDark, Colors.blueGrey),
        const SizedBox(height: 12),
        Text(
          'OmniKnow is supported through institutional licensing, premium certifications, and community grants. Core knowledge always remains free.',
          style: TextStyle(fontSize: 11, color: text.withOpacity(0.5), height: 1.5),
        ),
      ],
    );
  }

  // --- 1️⃣2️⃣ Vision Footer ---
  Widget _buildVisionFooter(bool isDark, Color text, Color subText, Color gold) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: text.withOpacity(0.02),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        children: [
          Icon(Icons.auto_stories_outlined, color: gold, size: 40),
          const SizedBox(height: 20),
          Text(
            'OMNIKNOW VISION',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 2, color: gold),
          ),
          const SizedBox(height: 12),
          Text(
            '“OmniKnow is a living ecosystem of human knowledge—open, immersive, verified, and collaborative.”',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: text, fontStyle: FontStyle.italic, height: 1.6),
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildFooterStat('12M+', 'Articles', gold),
              _buildFooterStat('3K', 'Partners', gold),
              _buildFooterStat('140', 'Langs', gold),
            ],
          ),
          const SizedBox(height: 40),
          Text('The Digital Makkah of Knowledge', style: TextStyle(fontSize: 10, color: text.withOpacity(0.2), fontWeight: FontWeight.bold, letterSpacing: 1.5)),
        ],
      ),
    );
  }

  Widget _buildFooterStat(String val, String label, Color gold) {
    return Column(
      children: [
        Text(val, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900)),
        Text(label, style: const TextStyle(fontSize: 9, color: Colors.grey)),
      ],
    );
  }

  // --- Helpers ---
  Widget _buildSectionHeader(String title, bool isDark, Color accent) {
    return Row(
      children: [
        Container(width: 4, height: 16, color: accent),
        const SizedBox(width: 12),
        Text(title.toUpperCase(), style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
      ],
    );
  }

  Widget _buildExpandableModule(String key, String title, String sub, IconData icon, Widget content, bool isDark, Color gold, Color text, Color subText, Color surface) {
    bool isExp = _expansionStates[key] ?? false;
    return Column(
      children: [
        InkWell(
          onTap: () => _toggleExpansion(key),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: surface, borderRadius: BorderRadius.circular(24), border: Border.all(color: text.withOpacity(0.05))),
            child: Row(
              children: [
                Icon(icon, color: gold, size: 24),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: text)),
                      Text(sub, style: TextStyle(fontSize: 11, color: subText)),
                    ],
                  ),
                ),
                Icon(isExp ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, size: 20, color: text.withOpacity(0.3)),
              ],
            ),
          ),
        ),
        if (isExp) Padding(padding: const EdgeInsets.only(top: 16, left: 20, right: 20), child: content),
      ],
    );
  }

  Widget _buildSmallBtn(String label, bool primary, Color accent) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: primary ? accent : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: accent),
      ),
      child: Text(label, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: primary ? Colors.white : accent)),
    );
  }

  void _showLanguageSelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Select Knowledge Language', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            _buildLangItem('English', true),
            _buildLangItem('العربية', false),
            _buildLangItem('Español', false),
            _buildLangItem('Mandarin', false),
          ],
        ),
      ),
    );
  }

  Widget _buildLangItem(String label, bool active) {
    return ListTile(
      title: Text(label, style: TextStyle(fontWeight: active ? FontWeight.bold : FontWeight.normal)),
      trailing: active ? const Icon(Icons.check_circle, color: Colors.blue) : null,
      onTap: () => Navigator.pop(context),
    );
  }
}
