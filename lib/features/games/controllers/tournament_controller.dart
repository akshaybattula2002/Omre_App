import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TournamentController extends GetxController {
  final currentFilter = 'Upcoming'.obs;
  final filters = ['Upcoming', 'Live', 'Past'];

  // Form Controllers for Hosting
  final tournamentNameController = TextEditingController();
  final prizePoolController = TextEditingController();
  final maxTeamsController = TextEditingController();
  final entryFeeController = TextEditingController();
  final startDateController = TextEditingController();
  final selectedGame = '8 Ball Pool'.obs;
  
  final availableGames = ['8 Ball Pool', 'Ludo Club', 'UNO', 'PUBG Mobile', 'Free Fire'];

  final tournaments = <Map<String, dynamic>>[
    {
      'status': 'Upcoming',
      'name': 'Sunday Showdown',
      'game': '8 Ball Pool',
      'prizePool': '\$5,000',
      'date': 'Sun, 2:00 PM',
      'teams': '32 / 64 Teams',
    },
    {
      'status': 'Live',
      'name': 'Blitz Master',
      'game': 'Chess',
      'prizePool': '\$1,200',
      'date': 'Started 20m ago',
      'teams': '16 / 16 Teams',
    },
    {
      'status': 'Upcoming',
      'name': 'Ludo King Derby',
      'game': 'Ludo Club',
      'prizePool': '\$3,000',
      'date': 'Mon, 10:00 AM',
      'teams': '128 / 256 Teams',
    },
    {
      'status': 'Past',
      'name': 'Pro League Finals',
      'game': 'Elden Ring',
      'prizePool': '\$10,000',
      'date': 'Finished yesterday',
      'teams': '64 / 64 Teams',
    },
  ].obs;

  List<Map<String, dynamic>> get filteredTournaments {
    return tournaments.where((t) => t['status'] == currentFilter.value).toList();
  }

  void setFilter(String filter) {
    currentFilter.value = filter;
  }

  void joinTournament(String name) {
    Get.snackbar(
      'Joined',
      'You have successfully joined $name',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  void createTournament() {
    if (tournamentNameController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter tournament name', backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }
    
    tournaments.add({
      'status': 'Upcoming',
      'name': tournamentNameController.text,
      'game': selectedGame.value,
      'prizePool': '\$${prizePoolController.text}',
      'date': 'Scheduling...',
      'teams': '0 / ${maxTeamsController.text} Teams',
    });

    Get.back(); // Close modal
    Get.snackbar(
      'Success',
      'Tournament created successfully',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.amber,
      colorText: Colors.black,
    );
    
    // Clear form
    tournamentNameController.clear();
    prizePoolController.clear();
    maxTeamsController.clear();
    entryFeeController.clear();
  }

  @override
  void onClose() {
    tournamentNameController.dispose();
    prizePoolController.dispose();
    maxTeamsController.dispose();
    entryFeeController.dispose();
    startDateController.dispose();
    super.onClose();
  }
}
