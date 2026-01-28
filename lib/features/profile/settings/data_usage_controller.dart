import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DataUsageController extends GetxController {
  var useLessMobileData = true.obs;
  var highQualityUploads = false.obs;

  var photosDownload = 'Wi-Fi and Cellular'.obs;
  var audioDownload = 'Wi-Fi only'.obs;
  var videosDownload = 'Wi-Fi only'.obs;
  var documentsDownload = 'Wi-Fi only'.obs;

  var autoplay = 'On Wi-Fi only'.obs;

  void toggleUseLessMobileData(bool val) => useLessMobileData.value = val;
  void toggleHighQualityUploads(bool val) => highQualityUploads.value = val;

  void showSelectionDialog(String title, RxString observer, List<String> options) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: Get.isDarkMode ? Colors.grey[900] : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(),
            ...options.map((option) => ListTile(
              title: Text(option),
              trailing: observer.value == option 
                  ? const Icon(Icons.check_circle, color: Color(0xFF4285F4))
                  : null,
              onTap: () {
                observer.value = option;
                Get.back();
              },
            )),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
