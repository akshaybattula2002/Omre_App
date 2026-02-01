import 'package:flutter/material.dart';
import '../../core/constants/app_assets.dart';
import 'package:get/get.dart';

class CompanyDetailScreen extends StatefulWidget {
  final String name;
  final String employees;
  final String industry;
  final String logo;
  final bool initialIsFollowing;

  const CompanyDetailScreen({
    super.key,
    required this.name,
    required this.employees,
    required this.industry,
    required this.logo,
    this.initialIsFollowing = false,
  });

  @override
  State<CompanyDetailScreen> createState() => _CompanyDetailScreenState();
}

class _CompanyDetailScreenState extends State<CompanyDetailScreen> {
  late bool isFollowing;

  @override
  void initState() {
    super.initState();
    isFollowing = widget.initialIsFollowing;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.name)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 150,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppAssets.cover1), // Using a generic placeholder for cover
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                        child: CircleAvatar(radius: 32, backgroundImage: AssetImage(widget.logo)),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                            Text('${widget.industry} • ${widget.employees}', style: TextStyle(color: Colors.grey[600])),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isFollowing = !isFollowing;
                        });
                        Get.snackbar('Company', isFollowing ? 'You are now following ${widget.name}' : 'You unfollowed ${widget.name}');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isFollowing ? Colors.grey[200] : Colors.blue,
                        foregroundColor: isFollowing ? Colors.black : Colors.white,
                      ),
                      child: Text(isFollowing ? 'Following' : 'Follow'),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text('About', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(
                    '${widget.name} is a leading company in the ${widget.industry} sector. We are committed to innovation and excellence. Join us to be part of a dynamic team.',
                    style: const TextStyle(height: 1.5),
                  ),
                  const SizedBox(height: 24),
                  const Text('Recent Updates', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  _buildUpdateItem('We are hiring! Check out our careers page.', '2h ago'),
                  _buildUpdateItem('Excited to announce our new product launch.', '1d ago'),
                  _buildUpdateItem('Quarterly results are out. Thanks to our amazing team.', '1w ago'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpdateItem(String text, String time) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(text, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text(time, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
