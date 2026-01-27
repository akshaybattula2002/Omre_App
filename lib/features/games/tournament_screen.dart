import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/tournament_controller.dart';

class TournamentScreen extends StatelessWidget {
  const TournamentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TournamentController());
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const neonYellow = Color(0xFFFFD700);
    const neonBlue = Color(0xFF00BFFF);
    const neonGreen = Color(0xFF32CD32);
    final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0D0D0D) : Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            // Fixed Header
            _buildHeader(context, controller, textColor, neonYellow),
            
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  children: [
                    // Stats Section
                    _buildStatsCards(isDark, neonBlue, neonGreen),
                    
                    const SizedBox(height: 24),
                    
                    // Filter Tabs
                    _buildFilterTabs(controller, isDark, textColor, neonBlue),
                    
                    const SizedBox(height: 16),
                    
                    // Tournament List
                    _buildTournamentList(controller, isDark, textColor, neonGreen, neonBlue),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, TournamentController controller, Color textColor, Color neonYellow) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => Get.back(),
                child: Row(
                  children: [
                    Icon(Icons.arrow_back_ios, size: 16, color: textColor),
                    const SizedBox(width: 4),
                    Text('Back to GameVerse', style: TextStyle(color: textColor.withOpacity(0.7), fontSize: 14)),
                  ],
                ),
              ),
              const Spacer(),
              _buildHostButton(context, controller, neonYellow),
            ],
          ),
          const SizedBox(height: 16),
          Text('Tournaments', style: TextStyle(color: textColor, fontSize: 28, fontWeight: FontWeight.bold)),
          Text('Join competitive events and win amazing prizes', 
            style: TextStyle(color: textColor.withOpacity(0.5), fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildHostButton(BuildContext context, TournamentController controller, Color neonYellow) {
    return GestureDetector(
      onTap: () => _showHostModal(context, controller),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [neonYellow, neonYellow.withOpacity(0.7)]),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [BoxShadow(color: neonYellow.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 4))],
        ),
        child: const Row(
          children: [
            Icon(Icons.add, color: Colors.black, size: 20),
            SizedBox(width: 4),
            Text('Host Tournament', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 13)),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsCards(bool isDark, Color neonBlue, Color neonGreen) {
    return Column(
      children: [
        _buildStatCard('Prize Pool', '\$15,400', 'This month\'s prize pool', Icons.emoji_events, Colors.amber, isDark),
        const SizedBox(height: 12),
        _buildStatCard('Events', '12 Events', 'Running this week', Icons.calendar_today, neonBlue, isDark),
        const SizedBox(height: 12),
        _buildStatCard('Join Now', 'Join Now', 'No entry fee required', Icons.filter_alt, neonGreen, isDark),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, String subtitle, IconData icon, Color accentColor, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1A1A) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: accentColor.withOpacity(0.1)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: accentColor.withOpacity(0.1), shape: BoxShape.circle),
            child: Icon(icon, color: accentColor, size: 28),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value, style: TextStyle(color: isDark ? Colors.white : Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
              Text(subtitle, style: TextStyle(color: (isDark ? Colors.white : Colors.black).withOpacity(0.5), fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTabs(TournamentController controller, bool isDark, Color textColor, Color neonBlue) {
    return Obx(() => Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1A1A) : Colors.grey[200],
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: controller.filters.map((filter) {
          final isSelected = controller.currentFilter.value == filter;
          return Expanded(
            child: GestureDetector(
              onTap: () => controller.setFilter(filter),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? neonBlue : Colors.transparent,
                  borderRadius: BorderRadius.circular(26),
                ),
                child: Center(
                  child: Text(
                    filter,
                    style: TextStyle(
                      color: isSelected ? Colors.white : textColor.withOpacity(0.6),
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    ));
  }

  Widget _buildTournamentList(TournamentController controller, bool isDark, Color textColor, Color neonGreen, Color neonBlue) {
    return Obx(() => ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.filteredTournaments.length,
      itemBuilder: (context, index) {
        final t = controller.filteredTournaments[index];
        return _buildTournamentCard(t, controller, isDark, textColor, neonGreen, neonBlue);
      },
    ));
  }

  Widget _buildTournamentCard(Map<String, dynamic> t, TournamentController controller, bool isDark, Color textColor, Color neonGreen, Color neonBlue) {
    final statusColor = t['status'] == 'Live' ? Colors.red : (t['status'] == 'Upcoming' ? neonBlue : Colors.grey);
    final canJoin = t['status'] != 'Past';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1A1A) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -10, bottom: -10,
            child: Icon(Icons.emoji_events, size: 80, color: (isDark ? Colors.white12 : Colors.grey[200])),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: statusColor.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                child: Text(t['status'].toUpperCase(), style: TextStyle(color: statusColor, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 12),
              Text(t['name'], style: TextStyle(color: textColor, fontSize: 18, fontWeight: FontWeight.bold)),
              Text(t['game'], style: TextStyle(color: textColor.withOpacity(0.6), fontSize: 14)),
              const SizedBox(height: 16),
              Row(
                children: [
                  _buildIconInfo(Icons.emoji_events, t['prizePool'], Colors.amber),
                  const SizedBox(width: 16),
                  _buildIconInfo(Icons.schedule, t['date'], Colors.grey),
                ],
              ),
              const SizedBox(height: 8),
              _buildIconInfo(Icons.groups, t['teams'], neonBlue),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: canJoin ? () => controller.joinTournament(t['name']) : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: neonGreen,
                    foregroundColor: Colors.black,
                    disabledBackgroundColor: Colors.grey[800],
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text(canJoin ? 'Join Tournament' : 'Tournament Ended', style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIconInfo(IconData icon, String text, Color color) {
    return Row(
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }

  void _showHostModal(BuildContext context, TournamentController controller) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;

    Get.dialog(
      Dialog(
        backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Host Tournament', style: TextStyle(color: textColor, fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),
              _buildModalField('Tournament Name', controller.tournamentNameController, isDark),
              const SizedBox(height: 16),
              Text('Select Game', style: TextStyle(color: textColor.withOpacity(0.7), fontSize: 14)),
              const SizedBox(height: 8),
              Obx(() => Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: isDark ? Colors.black.withOpacity(0.3) : Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: controller.selectedGame.value,
                    isExpanded: true,
                    dropdownColor: isDark ? const Color(0xFF2A2A2A) : Colors.white,
                    style: TextStyle(color: textColor),
                    items: controller.availableGames.map((game) {
                      return DropdownMenuItem(value: game, child: Text(game));
                    }).toList(),
                    onChanged: (val) => controller.selectedGame.value = val!,
                  ),
                ),
              )),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: _buildModalField('Prize Pool', controller.prizePoolController, isDark, keyboardType: TextInputType.number)),
                  const SizedBox(width: 16),
                  Expanded(child: _buildModalField('Max Teams', controller.maxTeamsController, isDark, keyboardType: TextInputType.number)),
                ],
              ),
              const SizedBox(height: 16),
              _buildModalField('Entry Fee (Optional)', controller.entryFeeController, isDark, keyboardType: TextInputType.number),
              const SizedBox(height: 16),
              _buildModalField('Start Date & Time', controller.startDateController, isDark),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => controller.createTournament(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFD700),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text('Create Tournament', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 12),
              TextButton(onPressed: () => Get.back(), child: const Center(child: Text('Cancel', style: TextStyle(color: Colors.grey)))),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModalField(String label, TextEditingController controller, bool isDark, {TextInputType? keyboardType}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: (isDark ? Colors.white : Colors.black).withOpacity(0.7), fontSize: 14)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          style: TextStyle(color: isDark ? Colors.white : Colors.black, fontSize: 14),
          decoration: InputDecoration(
            filled: true,
            fillColor: isDark ? Colors.black.withOpacity(0.3) : Colors.grey[100],
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ],
    );
  }
}
