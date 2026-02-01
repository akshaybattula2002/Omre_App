import 'package:flutter/material.dart';
import '../../core/constants/app_assets.dart';
import 'package:get/get.dart';
import 'my_network_detail_screens.dart';
import 'job_detail_screen.dart';
import 'company_detail_screen.dart';
import 'link_tool_detail_screens.dart';

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
          _buildNetworkItem('Connections', '528', Icons.people, assetPath: AppAssets.friendsIcon3d, onTap: () => Get.to(() => const ConnectionsScreen())),
          _buildNetworkItem('Contacts', '1.2k', Icons.contact_page, onTap: () => Get.to(() => const ContactsScreen())),
          _buildNetworkItem('People | Follow', '150', Icons.person_add, assetPath: AppAssets.friendsIcon3d, onTap: () => Get.to(() => const PeopleFollowScreen())),
          _buildNetworkItem('Groups', '12', Icons.groups, assetPath: AppAssets.groupsIcon3d, onTap: () => Get.to(() => const LinkGroupsScreen())),
          _buildNetworkItem('Events', '3', Icons.event, onTap: () => Get.to(() => const LinkEventsScreen())),
          _buildNetworkItem('Pages', '45', Icons.article, assetPath: 'assets/images/news_icon_3d.png', onTap: () => Get.to(() => const LinkPagesScreen())),
          _buildNetworkItem('Newsletters', '8', Icons.newspaper, assetPath: 'assets/images/news_icon_3d.png', onTap: () => Get.to(() => const LinkNewslettersScreen())),
          _buildNetworkItem('Hashtags', '20', Icons.tag, onTap: () => Get.to(() => const LinkHashtagsScreen())),
        ],
      ),
    );
  }

  Widget _buildNetworkItem(String title, String count, IconData icon, {String? assetPath, VoidCallback? onTap}) {
    return ListTile(
      leading: assetPath != null
          ? Image.asset(assetPath, width: 24, height: 24)
          : Icon(icon, color: Colors.blue),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: Text(count, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      onTap: onTap,
    );
  }
}



class LinkJobSearchScreen extends StatefulWidget {
  const LinkJobSearchScreen({super.key});

  @override
  State<LinkJobSearchScreen> createState() => _LinkJobSearchScreenState();
}

class _LinkJobSearchScreenState extends State<LinkJobSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  List<String> _recentSearches = ['Flutter Developer', 'Senior UX Designer', 'Remote Google'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Search jobs, companies...',
            border: InputBorder.none,
          ),
          autofocus: true,
          style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
          onChanged: (val) {
             setState(() {
               _isSearching = val.isNotEmpty;
             });
          },
        ),
        actions: [
          if (_isSearching)
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                _searchController.clear();
                setState(() {
                  _isSearching = false;
                });
              },
            ),
        ],
      ),
      body: _isSearching ? _buildSearchResults() : _buildRecentAndSuggested(),
    );
  }

  Widget _buildRecentAndSuggested() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        if (_recentSearches.isNotEmpty) ...[
          const Text('Recent Searches', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 12),
          ..._recentSearches.map((search) => ListTile(
            leading: const Icon(Icons.history),
            title: Text(search),
            trailing: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                setState(() {
                  _recentSearches.remove(search);
                });
              },
            ),
            onTap: () {
              _searchController.text = search;
              setState(() {
                _isSearching = true;
              });
            },
          )),
          const Divider(height: 32),
        ],
        const Text('Suggested for you', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 12),
        _buildJobItem('Software Engineer', 'Tech Corp', 'New York (Remote)', '1 day ago'),
        _buildJobItem('Product Manager', 'Innovate Inc', 'San Francisco', '2 days ago'),
      ],
    );
  }

  Widget _buildSearchResults() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Text('Results for "${_searchController.text}"', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
        ),
        _buildJobItem('Senior ${_searchController.text}', 'Global Tech', 'Remote', 'Just now'),
        _buildJobItem('Junior ${_searchController.text}', 'StartUp Hub', 'Berlin', '2 hours ago'),
        _buildJobItem('Lead ${_searchController.text}', 'Enterprise Co', 'London', '5 hours ago'),
      ],
    );
  }

  Widget _buildJobItem(String title, String company, String location, String time) {
    return GestureDetector(
      onTap: () {
        Get.to(() => JobDetailScreen(title: title, company: company, location: location, time: time));
      },
      child: LinkJobListItem(title: title, company: company, location: location, time: time),
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
                       GestureDetector(
                         onTap: () => Get.to(() => const JobDetailScreen(
                            title: 'Product Manager',
                            company: 'Innovate Inc',
                            location: 'San Francisco',
                            time: 'Applied 2d ago',
                         )),
                         child: LinkJobListItem(
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
                       ),
                       GestureDetector(
                         onTap: () => Get.to(() => const JobDetailScreen(
                            title: 'Frontend Lead',
                            company: 'WebSolutions',
                            location: 'Remote',
                            time: 'Applied 1w ago',
                         )),
                         child: LinkJobListItem(
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
                       ),
                    ],
                  ),
                  ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                       GestureDetector(
                         onTap: () => Get.to(() => const JobDetailScreen(
                            title: 'Junior Developer',
                            company: 'StartUp A',
                            location: 'Remote',
                            time: 'Archived 1mo ago',
                         )),
                         child: LinkJobListItem(
                          title: 'Junior Developer', 
                          company: 'StartUp A', 
                          location: 'Remote', 
                          time: 'Archived 1mo ago',
                          trailing: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(color: Colors.grey.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
                            child: const Text('Closed', style: TextStyle(color: Colors.grey, fontSize: 12)),
                          ),
                         ),
                       ),
                       const SizedBox(height: 12),
                       GestureDetector(
                         onTap: () => Get.to(() => const JobDetailScreen(
                            title: 'QA Tester',
                            company: 'TestCorp',
                            location: 'Austin, TX',
                            time: 'Archived 2mo ago',
                         )),
                         child: LinkJobListItem(
                          title: 'QA Tester', 
                          company: 'TestCorp', 
                          location: 'Austin, TX', 
                          time: 'Archived 2mo ago',
                          trailing: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(color: Colors.red.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
                            child: const Text('Rejected', style: TextStyle(color: Colors.red, fontSize: 12)),
                          ),
                         ),
                       ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class LinkSavedJobsScreen extends StatefulWidget {
  const LinkSavedJobsScreen({super.key});

  @override
  State<LinkSavedJobsScreen> createState() => _LinkSavedJobsScreenState();
}

class _LinkSavedJobsScreenState extends State<LinkSavedJobsScreen> {
  final List<Map<String, String>> _savedJobs = [
    {'title': 'Backend Engineer', 'company': 'ServerSide', 'location': 'London', 'time': 'Posted 3d ago', 'icon': AppAssets.avatar1},
    {'title': 'Mobile App Developer', 'company': 'AppStudio', 'location': 'Berlin', 'time': 'Posted 5d ago', 'icon': AppAssets.avatar2},
    {'title': 'Data Scientist', 'company': 'AI Lab', 'location': 'Toronto', 'time': 'Posted 1w ago', 'icon': AppAssets.avatar3},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Saved Jobs')),
      body: _savedJobs.isEmpty 
          ? const Center(child: Text('No saved jobs'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _savedJobs.length,
              itemBuilder: (context, index) {
                final job = _savedJobs[index];
                return LinkJobListItem(
                  title: job['title']!,
                  company: job['company']!,
                  location: job['location']!,
                  time: job['time']!,
                  icon: job['icon']!,
                  trailing: IconButton(
                    icon: const Icon(Icons.bookmark, color: Colors.blue),
                    onPressed: () {
                      setState(() {
                         _savedJobs.removeAt(index);
                      });
                      Get.snackbar('Saved Jobs', 'Job removed from saved list');
                    },
                  ),
                );
              },
            ),
    );
  }
}

class LinkJobAlertsScreen extends StatefulWidget {
  const LinkJobAlertsScreen({super.key});

  @override
  State<LinkJobAlertsScreen> createState() => _LinkJobAlertsScreenState();
}

class _LinkJobAlertsScreenState extends State<LinkJobAlertsScreen> {
  bool _flutterDevAlert = true;
  bool _productDesignerAlert = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Job Alerts')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
           ListTile(
             title: const Text('Flutter Developer'),
             subtitle: const Text('Remote • Full-time'),
             trailing: Switch(
               value: _flutterDevAlert, 
               onChanged: (val) {
                 setState(() => _flutterDevAlert = val);
                 Get.snackbar('Job Alerts', val ? 'Alert enabled' : 'Alert disabled');
               }
             ),
           ),
           const Divider(),
           ListTile(
             title: const Text('Product Designer'),
             subtitle: const Text('New York • Hybrid'),
             trailing: Switch(
               value: _productDesignerAlert, 
               onChanged: (val) {
                  setState(() => _productDesignerAlert = val);
                  Get.snackbar('Job Alerts', val ? 'Alert enabled' : 'Alert disabled');
               }
             ),
           ),
        ],
      ),
    );
  }
}

class LinkCompanyPagesScreen extends StatefulWidget {
  const LinkCompanyPagesScreen({super.key});

  @override
  State<LinkCompanyPagesScreen> createState() => _LinkCompanyPagesScreenState();
}

class _LinkCompanyPagesScreenState extends State<LinkCompanyPagesScreen> {
  final List<Map<String, dynamic>> _companies = [
    {'name': 'Google', 'industry': 'Internet', 'employees': '100k+', 'logo': AppAssets.avatar1, 'isFollowing': true},
    {'name': 'Microsoft', 'industry': 'Software', 'employees': '100k+', 'logo': AppAssets.avatar2, 'isFollowing': false},
    {'name': 'Amazon', 'industry': 'Retail', 'employees': '100k+', 'logo': AppAssets.avatar3, 'isFollowing': true},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Companies')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _companies.length,
        itemBuilder: (context, index) {
          final company = _companies[index];
          return Column(
            children: [
              ListTile(
                leading: CircleAvatar(backgroundImage: AssetImage(company['logo'])),
                title: Text(company['name']),
                subtitle: Text('${company['industry']} • ${company['employees']} employees'),
                trailing: TextButton(
                  onPressed: () {
                    setState(() {
                      company['isFollowing'] = !company['isFollowing'];
                    });
                     Get.snackbar('Company', company['isFollowing'] ? 'You are now following ${company['name']}' : 'You unfollowed ${company['name']}');
                  },
                  child: Text(
                    company['isFollowing'] ? 'Following' : 'Follow',
                    style: TextStyle(
                      color: company['isFollowing'] ? Colors.blue : Colors.grey, 
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                onTap: () {
                  Get.to(() => CompanyDetailScreen(
                    name: company['name'],
                    industry: company['industry'],
                    employees: company['employees'],
                    logo: company['logo'],
                    initialIsFollowing: company['isFollowing'],
                  ));
                },
              ),
              if (index < _companies.length - 1) const Divider(),
            ],
          );
        },
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
        onTap: () => Get.to(() => SalaryDetailScreen(title: title, range: range)),
      ),
    );
  }
}

class LinkResumeBuilderScreen extends StatelessWidget {
  const LinkResumeBuilderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resume Builder')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildActionCard(
              context,
              title: 'Create from Scratch',
              icon: Icons.edit_document,
              color: Colors.blue,
              subtitle: 'Start with a blank template',
            ),
            const SizedBox(height: 16),
            _buildActionCard(
              context,
              title: 'Upload Existing Resume',
              icon: Icons.upload_file,
              color: Colors.green,
              subtitle: 'Auto-fill from your PDF/Word doc',
            ),
            const SizedBox(height: 16),
            _buildActionCard(
              context,
              title: 'Import from LinkedIn',
              icon: Icons.link,
              color: Colors.blueAccent,
              subtitle: 'Use your profile data',
            ),
            const SizedBox(height: 32),
            const Align(alignment: Alignment.centerLeft, child: Text('Saved Resumes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
            const SizedBox(height: 12),
            _buildResumeItem(context, 'Software Engineer CV', 'Last edited 2d ago', 0.8),
            _buildResumeItem(context, 'Product Manager Resume', 'Last edited 1w ago', 0.6),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard(BuildContext context, {required String title, required IconData icon, required Color color, required String subtitle}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
          child: Icon(icon, color: color, size: 28),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: () {
           if(title == 'Create from Scratch') {
             Get.to(() => const TemplateSelectionScreen());
           } else {
             Get.snackbar('Resume', 'Feature coming soon');
           }
        },
      ),
    );
  }

  Widget _buildResumeItem(BuildContext context, String name, String date, double completeness) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            const Icon(Icons.description, size: 40, color: Colors.redAccent),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(date, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(value: completeness, backgroundColor: Colors.grey[200], color: Colors.green, minHeight: 4),
                ],
              ),
            ),
            IconButton(icon: const Icon(Icons.edit), onPressed: () => Get.to(() => const ResumeEditorScreen())),
          ],
        ),
      ),
    );
  }
}

class LinkPortfolioCreateScreen extends StatelessWidget {
  const LinkPortfolioCreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Portfolio')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Portfolio Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const TextField(decoration: InputDecoration(labelText: 'Portfolio Title', border: OutlineInputBorder())),
            const SizedBox(height: 16),
            const TextField(decoration: InputDecoration(labelText: 'Short Bio', border: OutlineInputBorder(), hintText: 'Tell us about yourself...'), maxLines: 3),
            const SizedBox(height: 24),
            const Text('Projects', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(border: Border.all(color: Colors.grey.withOpacity(0.5), style: BorderStyle.solid), borderRadius: BorderRadius.circular(12)),
              child: const Column(children: [Icon(Icons.add_photo_alternate_outlined, size: 40, color: Colors.grey), SizedBox(height: 8), Text('Add Project')]),
            ),
            const SizedBox(height: 16),
            _buildProjectItem('E-commerce App', 'Flutter, Firebase'),
            _buildProjectItem('Personal Website', 'React, Next.js'),
          ],
        ),
      ),
      bottomNavigationBar: Padding(padding: const EdgeInsets.all(16), child: ElevatedButton(onPressed: () => Get.to(() => const PortfolioPreviewScreen()), style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50), backgroundColor: Colors.purple, foregroundColor: Colors.white), child: const Text('Preview Portfolio'))),
    );
  }

  Widget _buildProjectItem(String title, String tools) {
    return Card(margin: const EdgeInsets.only(bottom: 12), child: ListTile(leading: Container(width: 50, height: 50, color: Colors.grey[300], child: const Icon(Icons.image)), title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)), subtitle: Text(tools), trailing: const Icon(Icons.edit)));
  }
}

class LinkCreateCoverLetterScreen extends StatelessWidget {
  const LinkCreateCoverLetterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cover Letter Generator')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const TextField(decoration: InputDecoration(labelText: 'Job Title', border: OutlineInputBorder())),
            const SizedBox(height: 16),
            const TextField(decoration: InputDecoration(labelText: 'Company Name', border: OutlineInputBorder())),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Tone', border: OutlineInputBorder()),
              items: ['Professional', 'Creative', 'Enthusiastic', 'Confident'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (v) {},
            ),
            const SizedBox(height: 24),
            Expanded(child: Container(width: double.infinity, padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.grey.withOpacity(0.1), borderRadius: BorderRadius.circular(12)), child: const Text('Generated cover letter will appear here...', style: TextStyle(color: Colors.grey)))),
            const SizedBox(height: 16),
            SizedBox(width: double.infinity, height: 50, child: ElevatedButton.icon(onPressed: () => Get.to(() => const GeneratedCoverLetterScreen()), icon: const Icon(Icons.auto_awesome), label: const Text('Generate with AI'), style: ElevatedButton.styleFrom(backgroundColor: Colors.teal, foregroundColor: Colors.white))),
          ],
        ),
      ),
    );
  }
}

class LinkAiHeadshotScreen extends StatelessWidget {
  const LinkAiHeadshotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AI Headshot Generator')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.deepPurple.withOpacity(0.1), borderRadius: BorderRadius.circular(16)),
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.camera_enhance, size: 64, color: Colors.deepPurple), SizedBox(height: 16), Text('Identify your best angle', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.deepPurple))]),
            ),
            const SizedBox(height: 24),
            const Text('How it works', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _buildStep('1', 'Upload 5-10 selfies'),
            _buildStep('2', 'Select a style (Corporate, Casual, Artistic)'),
            _buildStep('3', 'Wait ~20 mins for processing'),
            const SizedBox(height: 32),
            SizedBox(width: double.infinity, height: 50, child: ElevatedButton(onPressed: () => Get.to(() => const AiHeadshotProcessingScreen()), style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple, foregroundColor: Colors.white), child: const Text('Start Generating'))),
          ],
        ),
      ),
    );
  }

  Widget _buildStep(String number, String text) {
    return Padding(padding: const EdgeInsets.only(bottom: 12), child: Row(children: [CircleAvatar(radius: 12, backgroundColor: Colors.deepPurple, child: Text(number, style: const TextStyle(color: Colors.white, fontSize: 12))), const SizedBox(width: 12), Text(text, style: const TextStyle(fontSize: 16))]));
  }
}

class LinkAtsCheckerScreen extends StatelessWidget {
  const LinkAtsCheckerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ATS Resume Checker')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: Colors.blue.withOpacity(0.05), border: Border.all(color: Colors.blue.withOpacity(0.3)), borderRadius: BorderRadius.circular(16)),
              child: Column(children: [const Text('Resume Score', style: TextStyle(fontSize: 16)), const SizedBox(height: 8), const Text('72/100', style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.blue)), const SizedBox(height: 16), LinearProgressIndicator(value: 0.72, backgroundColor: Colors.blue.withOpacity(0.1), color: Colors.blue, minHeight: 8)]),
            ),
            const SizedBox(height: 24),
            const Align(alignment: Alignment.centerLeft, child: Text('Issues found:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
            const SizedBox(height: 12),
            _buildIssueItem('Missing Keywords', 'Try adding "leadership", "agile", "sql"', Colors.red),
            _buildIssueItem('Formatting Error', 'Use standard bullet points', Colors.orange),
            _buildIssueItem('File Type', 'PDF is recommended (Current: .docx)', Colors.amber),
            const SizedBox(height: 24),
            SizedBox(width: double.infinity, height: 50, child: ElevatedButton.icon(onPressed: () => Get.to(() => const AtsResultScreen()), icon: const Icon(Icons.upload_file), label: const Text('Upload New Resume'), style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white))),
          ],
        ),
      ),
    );
  }

  Widget _buildIssueItem(String title, String subtitle, Color color) {
    return Card(margin: const EdgeInsets.only(bottom: 12), child: ListTile(leading: Icon(Icons.warning_amber_rounded, color: color), title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)), subtitle: Text(subtitle)));
  }
}
