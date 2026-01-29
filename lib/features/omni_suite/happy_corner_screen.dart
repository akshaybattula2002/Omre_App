import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HappyCornerScreen extends StatefulWidget {
  const HappyCornerScreen({super.key});

  @override
  State<HappyCornerScreen> createState() => _HappyCornerScreenState();
}

class _HappyCornerScreenState extends State<HappyCornerScreen> {
  // Expansion states for AI transparency modules
  final Map<String, bool> _expansionStates = {};
  String selectedMood = 'Calm';
  String selectedCategory = 'All';

  final List<String> moods = ['Calm', 'Fun', 'Exciting', 'Inspiring'];
  final List<String> categories = ['All', 'Showbiz', 'Sports', 'Jokes', 'Achievements', 'Concerts'];

  void _toggleExpansion(String key) {
    HapticFeedback.lightImpact();
    setState(() {
      _expansionStates[key] = !(_expansionStates[key] ?? false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    // Define Adaptive Colors
    final Color bgColor = isDark ? const Color(0xFF0A0C0E) : const Color(0xFFFFF9F2);
    final Color cardColor = isDark ? const Color(0xFF14171A) : Colors.white;
    final Color textColor = isDark ? Colors.white : Colors.black87;
    final Color subTextColor = isDark ? Colors.white38 : Colors.black45;
    final Color accentColor = const Color(0xFFFFB347); // Remains consistent for optimism

    return Theme(
      data: isDark ? ThemeData.dark() : ThemeData.light(),
      child: Scaffold(
        backgroundColor: bgColor,
        body: Stack(
          children: [
            // Soft sky blue & coral gradients
            _buildBackgroundGlows(isDark),

            SafeArea(
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  // 1️⃣ HAPPY CORNER HEADER (Sticky)
                  _buildStickyHeader(context, isDark),

                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        // 2️⃣ HAPPINESS FACTOR INDICATOR
                        _buildHappinessFactorMeter(),
                        const SizedBox(height: 24),

                        // 3️⃣ CATEGORY SELECTOR (Horizontal Chips)
                        _buildCategorySelector(),
                        const SizedBox(height: 32),

                        // 4️⃣ HAPPY CONTENT FEED
                        _buildContentFeed(),
                        const SizedBox(height: 32),

                        // 5️⃣ AI CONTENT SOURCES PANEL
                        _buildExpandableInfoCard(
                          key: 'sources',
                          title: 'How Happy Corner Finds Content',
                          icon: Icons.search_outlined,
                          content: const Text(
                            'AI analyzes across WN Social posts, verified news, and live reels. Only content with high positivity scores is admitted.',
                            style: TextStyle(fontSize: 12, color: Colors.black54),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // 6️⃣ AI HAPPINESS DETECTION ENGINE (TRANSPARENCY)
                        _buildSectionLabel('AI Detection Engine'),
                        const SizedBox(height: 12),
                        _buildTransparencyModules(),
                        const SizedBox(height: 32),

                        // 7️⃣ WELLBEING MESSAGE
                        _buildWellbeingBanner(),
                        const SizedBox(height: 32),

                        // 8️⃣ FOOTER — USER CONTROL
                        _buildFeedbackFooter(),
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

  // --- Aesthetic Background ---

  Widget _buildBackgroundGlows(bool isDark) {
    return Positioned.fill(
      child: Stack(
        children: [
          Positioned(
            top: -100,
            left: -50,
            child: _blurSphere(isDark ? const Color(0xFF1E242C) : const Color(0xFFFFF4E0), 400),
          ),
          Positioned(
            bottom: -50,
            right: -50,
            child: _blurSphere(isDark ? const Color(0xFF1A141A) : const Color(0xFFFFE0D8), 350),
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
        gradient: RadialGradient(colors: [color, color.withOpacity(0)]),
      ),
    );
  }

  // --- Header ---

  Widget _buildStickyHeader(BuildContext context, bool isDark) {
    return SliverAppBar(
      pinned: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      flexibleSpace: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(color: (isDark ? Colors.black : Colors.white).withOpacity(0.7)),
        ),
      ),
      expandedHeight: 130,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_new, color: isDark ? Colors.white70 : Colors.black54, size: 18),
        onPressed: () => Get.back(),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '🌈 Happy Corner',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Color(0xFFFF8C00)),
          ),
          Row(
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
              ),
              const SizedBox(width: 4),
              Text(
                'AI-Verified Positive Content',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: isDark ? Colors.white38 : Colors.black38),
              ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.refresh, color: isDark ? Colors.white38 : Colors.black38, size: 20),
          onPressed: () {
            HapticFeedback.mediumImpact();
          },
        ),
        const SizedBox(width: 8),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: moods.map((m) => _buildMoodChip(m, isDark)).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildMoodChip(String label, bool isDark) {
    bool isSel = selectedMood == label;
    return GestureDetector(
      onTap: () => setState(() => selectedMood = label),
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSel ? const Color(0xFFFFB347) : (isDark ? Colors.white12 : Colors.white70),
          borderRadius: BorderRadius.circular(20),
          boxShadow: isSel ? [BoxShadow(color: Colors.orange.withOpacity(0.2), blurRadius: 8)] : [],
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isSel ? FontWeight.bold : FontWeight.normal,
            color: isSel ? Colors.white : (isDark ? Colors.white54 : Colors.black54),
          ),
        ),
      ),
    );
  }

  // --- Happiness Factor Meter ---

  Widget _buildHappinessFactorMeter() {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF14171A) : Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(color: Colors.orange.withOpacity(0.05), blurRadius: 40, offset: const Offset(0, 10)),
        ],
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 140,
                height: 140,
                child: CircularProgressIndicator(
                  value: 0.88,
                  strokeWidth: 8,
                  backgroundColor: Colors.orange.withOpacity(0.05),
                  valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFFFB347)),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text('88', style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900, color: Color(0xFFFF8C00))),
                  Text('HAPPINESS FACTOR', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.white24)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildExplanationChip('This content is ranked using AI happiness indicators.', isDark),
        ],
      ),
    );
  }

  Widget _buildExplanationChip(String text, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(color: isDark ? Colors.white.withOpacity(0.03) : const Color(0xFFFFF9F2), borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          const Icon(Icons.auto_awesome, size: 14, color: Color(0xFFFFB347)),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: TextStyle(fontSize: 11, color: isDark ? Colors.white70 : Colors.black54))),
        ],
      ),
    );
  }

  // --- Category Selector ---

  Widget _buildCategorySelector() {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: categories.map((c) => _buildCategoryChip(c, isDark)).toList(),
      ),
    );
  }

  Widget _buildCategoryChip(String label, bool isDark) {
    bool isSel = selectedCategory == label;
    return GestureDetector(
      onTap: () => setState(() => selectedCategory = label),
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: isSel ? const Color(0xFFFFB347).withOpacity(0.1) : (isDark ? Colors.white12 : Colors.white70),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: isSel ? const Color(0xFFFFB347) : Colors.transparent),
              ),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: isSel ? FontWeight.bold : FontWeight.normal,
                  color: isSel ? const Color(0xFFFF8C00) : (isDark ? Colors.white38 : Colors.black45),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Content Feed ---

  Widget _buildContentFeed() {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final happyPosts = [
      {
        'title': 'Golden Retriever adopts orphaned ducklings!',
        'cat': 'Animals',
        'hf': '94',
        'why': 'Smiles detected • Laughter detected • High social joy score',
        'img': Icons.pets_outlined,
      },
      {
        'title': 'Local community reaches 100% recycling goal.',
        'cat': 'Achievements',
        'hf': '87',
        'why': 'Positive language • Motivational tone • Community pride',
        'img': Icons.eco_outlined,
      },
    ];

    return Column(
      children: happyPosts.map((p) => _buildHappyCard(p, isDark)).toList(),
    );
  }

  Widget _buildHappyCard(Map<String, dynamic> p, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF14171A) : Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 20)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(backgroundColor: Colors.orange.withOpacity(0.1), child: Icon(p['img'] as IconData, size: 18, color: const Color(0xFFFFB347))),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(p['cat'] as String, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: isDark ? Colors.white24 : Colors.black26)),
                  Text('Verified News', style: TextStyle(fontSize: 11, color: isDark ? Colors.white54 : Colors.black54)),
                ],
              ),
              const Spacer(),
              _buildHFBadge(p['hf'] as String),
            ],
          ),
          const SizedBox(height: 20),
          Text(p['title'] as String, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, height: 1.3, color: isDark ? Colors.white : Colors.black87)),
          const SizedBox(height: 20),
          Divider(height: 1, color: isDark ? Colors.white10 : const Color(0xFFFFF9F2)),
          const SizedBox(height: 12),
          Text('WHY THIS IS HAPPY?', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.orange.withOpacity(0.6), letterSpacing: 0.5)),
          const SizedBox(height: 4),
          Text(p['why'] as String, style: TextStyle(fontSize: 11, color: isDark ? Colors.white38 : Colors.black38)),
          const SizedBox(height: 20),
          Row(
            children: [
              _buildJoyAction('Made me happy', Icons.sentiment_very_satisfied),
              const Spacer(),
              IconButton(icon: Icon(Icons.bookmark_border, size: 20, color: isDark ? Colors.white24 : Colors.black26), onPressed: () {}),
              IconButton(icon: Icon(Icons.share_outlined, size: 20, color: isDark ? Colors.white24 : Colors.black26), onPressed: () {}),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHFBadge(String score) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: const Color(0xFFC6FFD8).withOpacity(0.4), borderRadius: BorderRadius.circular(8)),
      child: Text('Happiness Factor: $score', style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Color(0xFF1B5E20))),
    );
  }

  Widget _buildJoyAction(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(color: const Color(0xFFFFB347).withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Icon(icon, size: 16, color: const Color(0xFFFF8C00)),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFFFF8C00))),
        ],
      ),
    );
  }

  // --- Transparency Modules ---

  Widget _buildTransparencyModules() {
    return Column(
      children: [
        _buildExpandableInfoCard(
          key: 'nlp',
          title: 'NLP Analysis',
          icon: Icons.text_fields_outlined,
          content: const Text('Detects positive language, happiness keywords, and motivational tones in text snippets.', style: TextStyle(fontSize: 11, color: Colors.black54)),
        ),
        _buildExpandableInfoCard(
          key: 'visual',
          title: 'Visual Joy Detection',
          icon: Icons.face_outlined,
          content: const Text('Analyzes images and videos for smile frequency, joyful expressions, and laughter cues.', style: TextStyle(fontSize: 11, color: Colors.black54)),
        ),
        _buildExpandableInfoCard(
          key: 'mlearn',
          title: 'Machine Learning',
          icon: Icons.psychology_outlined,
          content: const Text('Learns from your "Made me happy" feedback to refine content selection and ranking.', style: TextStyle(fontSize: 11, color: Colors.black54)),
        ),
      ],
    );
  }

  // --- Helpers ---

  Widget _buildExpandableInfoCard({required String key, required String title, required IconData icon, required Widget content}) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    bool isExp = _expansionStates[key] ?? false;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF14171A) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isDark ? Colors.white10 : Colors.black.withOpacity(0.02)),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () => _toggleExpansion(key),
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                children: [
                  Icon(icon, size: 18, color: isDark ? Colors.white38 : Colors.black38),
                  const SizedBox(width: 16),
                  Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: isDark ? Colors.white70 : Colors.black54)),
                  const Spacer(),
                  Icon(isExp ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, size: 16, color: isDark ? Colors.white24 : Colors.black26),
                ],
              ),
            ),
          ),
          if (isExp) Padding(padding: const EdgeInsets.fromLTRB(56, 0, 20, 20), child: content),
        ],
      ),
    );
  }

  Widget _buildWellbeingBanner() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF87CEEB), Color(0xFFA1E3FF)]),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          const Icon(Icons.spa_outlined, color: Colors.white, size: 30),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Happiness First', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Colors.white)),
                SizedBox(height: 4),
                Text(
                  'Happy Corner is designed to uplift, not overwhelm. Negativity is filtered by design.',
                  style: TextStyle(fontSize: 11, color: Colors.white, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeedbackFooter() {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        Text('HOW ACCURATE IS THIS AI?', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1.5, color: isDark ? Colors.white24 : Colors.black26)),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _footerBtn('Rate AI Accuracy', isDark),
            const SizedBox(width: 12),
            _footerBtn('Report Content', isDark),
          ],
        ),
        const SizedBox(height: 32),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            'Your emotional signals are never shared publicly. Happy Corner uses local processing for privacy-safe sentiment analysis.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 9, color: isDark ? Colors.white24 : Colors.black26, height: 1.5),
          ),
        ),
      ],
    );
  }

  Widget _footerBtn(String label, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(color: isDark ? Colors.white.withOpacity(0.05) : Colors.black.withOpacity(0.03), borderRadius: BorderRadius.circular(10)),
      child: Text(label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: isDark ? Colors.white38 : Colors.black38)),
    );
  }

  Widget _buildSectionLabel(String text) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Text(text.toUpperCase(), style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 1.5, color: isDark ? Colors.white24 : Colors.black26));
  }
}
