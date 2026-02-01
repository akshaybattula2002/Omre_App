import 'package:flutter/material.dart';
import '../../core/constants/app_assets.dart';
import 'package:get/get.dart';

// --- CONNECTIONS ---
class ConnectionsScreen extends StatelessWidget {
  const ConnectionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Connections')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _ConnectionItem(name: 'Alice Johnson', job: 'Product Designer at Google', avatar: AppAssets.avatar1),
          _ConnectionItem(name: 'Bob Smith', job: 'Software Engineer at Meta', avatar: AppAssets.avatar2),
          _ConnectionItem(name: 'Charlie Brown', job: 'Recruiter at Amazon', avatar: AppAssets.avatar3),
        ],
      ),
    );
  }
}

class _ConnectionItem extends StatelessWidget {
  final String name;
  final String job;
  final String avatar;

  const _ConnectionItem({required this.name, required this.job, required this.avatar});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(backgroundImage: AssetImage(avatar)),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(job),
        trailing: IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () {
            Get.bottomSheet(
               Container(
                 color: Theme.of(context).scaffoldBackgroundColor,
                 child: Wrap(
                   children: [
                     ListTile(leading: const Icon(Icons.message), title: const Text('Message'), onTap: () => Get.back()),
                     ListTile(leading: const Icon(Icons.delete, color: Colors.red), title: const Text('Remove Connection', style: TextStyle(color: Colors.red)), onTap: () => Get.back()),
                   ],
                 ),
               )
            );
          },
        ),
      ),
    );
  }
}

// --- CONTACTS ---
class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contacts')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(child: Text('C${index + 1}')),
            title: Text('Contact ${index + 1}'),
            subtitle: Text('+1 555 123 456$index'),
            trailing: OutlinedButton(
              onPressed: () {
                Get.snackbar('Invite', 'Invitation sent to Contact ${index + 1}');
              },
              child: const Text('Invite'),
            ),
          );
        },
      ),
    );
  }
}

// --- PEOPLE | FOLLOW ---
class PeopleFollowScreen extends StatelessWidget {
  const PeopleFollowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('People You May Know')),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.8,
        children: const [
          _SuggestionCard(name: 'Emily Davis', job: 'UX Researcher', avatar: AppAssets.avatar1),
          _SuggestionCard(name: 'Frank Miller', job: 'Data Analyst', avatar: AppAssets.avatar2),
          _SuggestionCard(name: 'Grace Lee', job: 'Marketing Lead', avatar: AppAssets.avatar3),
          _SuggestionCard(name: 'Henry Wilson', job: 'Full Stack Dev', avatar: AppAssets.avatar1),
        ],
      ),
    );
  }
}

class _SuggestionCard extends StatefulWidget {
  final String name;
  final String job;
  final String avatar;

  const _SuggestionCard({required this.name, required this.job, required this.avatar});

  @override
  State<_SuggestionCard> createState() => _SuggestionCardState();
}

class _SuggestionCardState extends State<_SuggestionCard> {
  bool isFollowing = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(backgroundImage: AssetImage(widget.avatar), radius: 32),
          const SizedBox(height: 12),
          Text(widget.name, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(widget.job, textAlign: TextAlign.center, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              setState(() {
                isFollowing = !isFollowing;
              });
              if (isFollowing) {
                 Get.snackbar('Follow', 'You are now following ${widget.name}');
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: isFollowing ? Colors.grey : Colors.blue,
              foregroundColor: Colors.white,
            ),
            child: Text(isFollowing ? 'Following' : 'Follow'),
          ),
        ],
      ),
    );
  }
}

// --- GROUPS ---
class LinkGroupsScreen extends StatelessWidget {
  const LinkGroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Groups')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ListTile(leading: Icon(Icons.group, size: 40, color: Colors.blue), title: Text('Flutter Developers'), subtitle: Text('125k members'), trailing: Icon(Icons.chevron_right)),
          ListTile(leading: Icon(Icons.group, size: 40, color: Colors.green), title: Text('Startup Founders'), subtitle: Text('45k members'), trailing: Icon(Icons.chevron_right)),
          ListTile(leading: Icon(Icons.group, size: 40, color: Colors.orange), title: Text('Digital Nomads'), subtitle: Text('89k members'), trailing: Icon(Icons.chevron_right)),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {}, child: const Icon(Icons.add)),
    );
  }
}

// --- EVENTS ---
class LinkEventsScreen extends StatelessWidget {
  const LinkEventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Events')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Card(child: ListTile(title: Text('Tech Conference 2024'), subtitle: Text('Sat, Jun 15 • San Francisco'), leading: Icon(Icons.event, color: Colors.purple))),
          Card(child: ListTile(title: Text('Networking Mixer'), subtitle: Text('Thu, Jul 2 • Virtual'), leading: Icon(Icons.event, color: Colors.purple))),
        ],
      ),
    );
  }
}

// --- PAGES ---
class LinkPagesScreen extends StatelessWidget {
  const LinkPagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Followed Pages')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ListTile(leading: Icon(Icons.business, size: 36), title: Text('Microsoft'), trailing: Icon(Icons.check_circle, color: Colors.blue)),
          ListTile(leading: Icon(Icons.business, size: 36), title: Text('Google'), trailing: Icon(Icons.check_circle, color: Colors.blue)),
        ],
      ),
    );
  }
}

// --- NEWSLETTERS ---
class LinkNewslettersScreen extends StatelessWidget {
  const LinkNewslettersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Newsletters')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildItem('Daily Tech News', 'Latest updates in tech world'),
          _buildItem('The Startup', 'Tips for entrepreneurs'),
        ],
      ),
    );
  }

   Widget _buildItem(String title, String subtitle) {
    return Card(child: ListTile(leading: const Icon(Icons.newspaper), title: Text(title), subtitle: Text(subtitle)));
  }
}

// --- HASHTAGS ---
class LinkHashtagsScreen extends StatelessWidget {
  const LinkHashtagsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Followed Hashtags')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: const [
            Chip(label: Text('#flutter')),
            Chip(label: Text('#coding')),
            Chip(label: Text('#technology')),
            Chip(label: Text('#innovation')),
            Chip(label: Text('#startup')),
          ],
        ),
      ),
    );
  }
}
