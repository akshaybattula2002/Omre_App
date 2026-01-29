import 'package:flutter/material.dart';
import '../../core/constants/app_assets.dart';

// --- Shared Widgets ---

class LinkJobListItem extends StatelessWidget {
  final String title;
  final String company;
  final String location;
  final String time;
  final String icon;
  final Widget? trailing;

  const LinkJobListItem({
    super.key,
    required this.title,
    required this.company,
    required this.location,
    required this.time,
    this.icon = '',
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.grey[200],
          backgroundImage: icon.isNotEmpty ? AssetImage(icon) : null,
          child: icon.isEmpty ? const Icon(Icons.business, color: Colors.grey) : null,
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$company • $location'),
            const SizedBox(height: 4),
            Text(time, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
        trailing: trailing ?? const Icon(Icons.bookmark_border),
      ),
    );
  }
}

// --- Screens ---

class LinkMyNetworkScreen extends StatelessWidget {
  const LinkMyNetworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Network')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildNetworkItem('Connections', '528', Icons.people),
          _buildNetworkItem('Contacts', '1.2k', Icons.contact_page),
          _buildNetworkItem('People | Follow', '150', Icons.person_add),
          _buildNetworkItem('Groups', '12', Icons.groups),
          _buildNetworkItem('Events', '3', Icons.event),
          _buildNetworkItem('Pages', '45', Icons.article),
          _buildNetworkItem('Newsletters', '8', Icons.newspaper),
          _buildNetworkItem('Hashtags', '20', Icons.tag),
        ],
      ),
    );
  }

  Widget _buildNetworkItem(String title, String count, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: Text(count, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      onTap: () {},
    );
  }
}

class LinkJobSearchScreen extends StatelessWidget {
  const LinkJobSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: const InputDecoration(
            hintText: 'Search jobs, companies...',
            border: InputBorder.none,
          ),
          autofocus: true,
          style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Text('Recent Searches', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          SizedBox(height: 12),
          ListTile(leading: Icon(Icons.history), title: Text('Flutter Developer'), trailing: Icon(Icons.close)),
          ListTile(leading: Icon(Icons.history), title: Text('Senior UX Designer'), trailing: Icon(Icons.close)),
          ListTile(leading: Icon(Icons.history), title: Text('Remote Google'), trailing: Icon(Icons.close)),
          Divider(height: 32),
          Text('Suggested for you', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          SizedBox(height: 12),
          LinkJobListItem(title: 'Software Engineer', company: 'Tech Corp', location: 'New York (Remote)', time: '1 day ago'),
        ],
      ),
    );
  }
}

class LinkApplicationsScreen extends StatelessWidget {
  const LinkApplicationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Jobs')),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(text: 'Applied'),
                Tab(text: 'Archived'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      LinkJobListItem(
                        title: 'Product Manager', 
                        company: 'Innovate Inc', 
                        location: 'San Francisco', 
                        time: 'Applied 2d ago',
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(color: Colors.blue.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
                          child: const Text('In Review', style: TextStyle(color: Colors.blue, fontSize: 12)),
                        ),
                      ),
                       LinkJobListItem(
                        title: 'Frontend Lead', 
                        company: 'WebSolutions', 
                        location: 'Remote', 
                        time: 'Applied 1w ago',
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(color: Colors.green.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
                          child: const Text('Interview', style: TextStyle(color: Colors.green, fontSize: 12)),
                        ),
                      ),
                    ],
                  ),
                  const Center(child: Text('No archived jobs')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LinkSavedJobsScreen extends StatelessWidget {
  const LinkSavedJobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Saved Jobs')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          LinkJobListItem(title: 'Backend Engineer', company: 'ServerSide', location: 'London', time: 'Posted 3d ago', icon: AppAssets.avatar1),
          LinkJobListItem(title: 'Mobile App Developer', company: 'AppStudio', location: 'Berlin', time: 'Posted 5d ago', icon: AppAssets.avatar2),
          LinkJobListItem(title: 'Data Scientist', company: 'AI Lab', location: 'Toronto', time: 'Posted 1w ago', icon: AppAssets.avatar3),
        ],
      ),
    );
  }
}

class LinkJobAlertsScreen extends StatelessWidget {
  const LinkJobAlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Job Alerts')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
           ListTile(
             title: Text('Flutter Developer'),
             subtitle: Text('Remote • Full-time'),
             trailing: Switch(value: true, onChanged: null), // Dummy switch
           ),
           Divider(),
           ListTile(
             title: Text('Product Designer'),
             subtitle: Text('New York • Hybrid'),
             trailing: Switch(value: true, onChanged: null),
           ),
        ],
      ),
    );
  }
}

class LinkCompanyPagesScreen extends StatelessWidget {
  const LinkCompanyPagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Companies')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
           ListTile(
             leading: CircleAvatar(backgroundImage: AssetImage(AppAssets.avatar1)),
             title: Text('Google'),
             subtitle: Text('Internet • 100k+ employees'),
             trailing:  Text('Following', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
           ),
           Divider(),
           ListTile(
             leading: CircleAvatar(backgroundImage: AssetImage(AppAssets.avatar2)),
             title: Text('Microsoft'),
             subtitle: Text('Software • 100k+ employees'),
             trailing:  Text('Follow', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
           ),
           Divider(),
           ListTile(
             leading: CircleAvatar(backgroundImage: AssetImage(AppAssets.avatar3)),
             title: Text('Amazon'),
             subtitle: Text('Retail • 100k+ employees'),
             trailing:  Text('Following', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
           ),
        ],
      ),
    );
  }
}

class LinkSalaryInsightsScreen extends StatelessWidget {
  const LinkSalaryInsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Salary Insights')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search job title or location',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 24),
            const Text('Top paying jobs in your area', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _buildSalaryItem('Software Architect', '\$140k - \$200k/yr'),
             _buildSalaryItem('Data Scientist', '\$120k - \$180k/yr'),
             _buildSalaryItem('Product Manager', '\$110k - \$170k/yr'),
          ],
        ),
      ),
    );
  }
  
  Widget _buildSalaryItem(String title, String range) {
    return Card(
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('Average Base Salary', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
        trailing: Text(range, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.green)),
      ),
    );
  }
}
