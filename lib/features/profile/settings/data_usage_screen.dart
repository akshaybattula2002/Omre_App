import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/palette.dart';
import '../../../core/constants/app_assets.dart';
import 'data_usage_controller.dart';

class DataUsageScreen extends StatelessWidget {
  const DataUsageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DataUsageController());
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final downloadOptions = ['Never', 'Wi-Fi only', 'Wi-Fi and Cellular'];
    final autoplayOptions = ['Never', 'On Wi-Fi only', 'On Wi-Fi and Cellular'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Usage', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Image.asset(AppAssets.dataUsageIcon3d, width: 28, height: 28),
          ),
        ],
      ),
      body: ListView(
        children: [
          _buildSection('Mobile Data', [
            Obx(() => _buildToggle(
              'Use Less Mobile Data', 
              controller.useLessMobileData.value, 
              'Lower resolution for videos and images when on cellular.',
              controller.toggleUseLessMobileData,
            )),
            Obx(() => _buildToggle(
              'High-Quality Uploads', 
              controller.highQualityUploads.value, 
              'Always upload photos and videos in highest quality.',
              controller.toggleHighQualityUploads,
            )),
          ]),
          _buildSection('Media Auto-Download', [
            Obx(() => _buildTile(
              'Photos', 
              controller.photosDownload.value,
              () => controller.showSelectionDialog('Photos', controller.photosDownload, downloadOptions),
            )),
            Obx(() => _buildTile(
              'Audio', 
              controller.audioDownload.value,
              () => controller.showSelectionDialog('Audio', controller.audioDownload, downloadOptions),
            )),
            Obx(() => _buildTile(
              'Videos', 
              controller.videosDownload.value,
              () => controller.showSelectionDialog('Videos', controller.videosDownload, downloadOptions),
            )),
            Obx(() => _buildTile(
              'Documents', 
              controller.documentsDownload.value,
              () => controller.showSelectionDialog('Documents', controller.documentsDownload, downloadOptions),
            )),
          ]),
          _buildSection('Video Autoplay', [
            Obx(() => _buildTile(
              'Autoplay', 
              controller.autoplay.value,
              () => controller.showSelectionDialog('Autoplay', controller.autoplay, autoplayOptions),
            )),
          ]),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
          child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppPalette.accentBlue)),
        ),
        ...children,
      ],
    );
  }

  Widget _buildToggle(String title, bool value, String subtitle, Function(bool) onChanged) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: AppPalette.accentBlue,
      ),
    );
  }

  Widget _buildTile(String title, String value, VoidCallback onTap) {
    return ListTile(
      title: Text(title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(value, style: const TextStyle(color: Colors.grey, fontSize: 14)),
          const Icon(Icons.chevron_right, size: 20, color: Colors.grey),
        ],
      ),
      onTap: onTap,
    );
  }
}
