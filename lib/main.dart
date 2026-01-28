import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app.dart';
import 'core/services/state_providers.dart';
import 'features/social/controllers/home_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(AppController());
  Get.put(HomeController());
  runApp(const OmreApp());
}