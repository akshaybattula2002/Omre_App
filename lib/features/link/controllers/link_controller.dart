import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JobModel {
  final String id;
  final String title;
  final String company;
  final String location;
  final String salary;
  final String type; // Remote, Full-time, etc.
  final String description;
  final Color themeColor;
  final String postedAgo;
  final List<String> requirements;
  final String companyDescription;

  JobModel({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.salary,
    required this.type,
    required this.description,
    required this.themeColor,
    required this.postedAgo,
    this.requirements = const [
      '3+ years of experience in the field',
      'Excellent communication skills',
      'Bachelor degree in related field'
    ],
    this.companyDescription = 'A forward-thinking company dedicated to innovation and excellence in their field.',
  });
}

class ServiceModel {
  final String id;
  final String title;
  final String provider;
  final String price;
  final String rating;
  final String category;
  final String description;
  final Color themeColor;

  ServiceModel({
    required this.id,
    required this.title,
    required this.provider,
    required this.price,
    required this.rating,
    required this.category,
    required this.description,
    required this.themeColor,
  });
}

class LinkController extends GetxController {
  final isJobsSelected = true.obs;
  final searchQuery = ''.obs;
  final locationQuery = ''.obs;
  final marketplaceSearchQuery = ''.obs;

  final List<JobModel> allJobs = [
    JobModel(
      id: '34',
      title: 'Project Coordinator',
      company: 'BuildIt Solutions',
      location: 'Remote',
      salary: '\$90k - \$115k',
      type: 'Full-time',
      description: 'We are looking for an organized and motivated Project Coordinator to assist our project management team. You will be responsible for tracking project progress, scheduling meetings, managing documentation, and ensuring seamless communication between departments. Ideal for someone with strong attention to detail and a passion for efficiency.',
      themeColor: Colors.teal,
      postedAgo: '1h ago',
      requirements: [
        '2+ years of experience in project coordination or management',
        'Proficiency with Jira, Asana, or Trello',
        'Strong organizational and time-management skills',
        'Excellent verbal and written communication',
        'Ability to handle multiple projects simultaneously',
        'Bachelor\'s degree in Business or related field'
      ],
      companyDescription: 'BuildIt Solutions provides cutting-edge project management software for construction and engineering firms worldwide.',
    ),
    JobModel(
      id: '31',
      title: 'Senior Frontend Engineer',
      company: 'TechFlow',
      location: 'Remote',
      salary: '\$140k - \$180k',
      type: 'Full-time',
      description: 'We are seeking a talented Senior Frontend Engineer to lead our web development initiatives. You will be responsible for building high-performance, scalable web applications using React, TypeScript, and modern state management libraries. The ideal candidate has a passion for UI/UX, clean code, and mentoring junior developers.',
      themeColor: Colors.blueAccent,
      postedAgo: '3:37 PM',
      requirements: [
        '5+ years of experience with React and TypeScript',
        'Strong understanding of state management (Redux, MobX, or Context API)',
        'Experience with Next.js or similar SSR frameworks',
        'Proficiency in CSS/SCSS and TailwindCSS',
        'Familiarity with CI/CD pipelines and testing frameworks (Jest, Cypress)',
        'Ability to mentor junior developers and conduct code reviews'
      ],
      companyDescription: 'TechFlow is a fintech unicorn revolutionizing digital payments with secure, seamless, and scalable solutions.',
    ),
    JobModel(
      id: '32',
      title: 'Product Designer',
      company: 'Creative Studio',
      location: 'New York, NY',
      salary: '\$60 - \$90 /hr',
      type: 'Contract',
      description: 'Creative Studio is looking for a contract Product Designer to join our fast-paced creative team. You will be working on end-to-end design projects for high-profile clients. We value visual excellence and user-centric design thinking.',
      themeColor: Colors.purpleAccent,
      postedAgo: '5:37 PM',
      requirements: [
        'Portfolio demonstrating strong UI/UX skills',
        'Proficiency in Figma, Sketch, and Adobe Creative Suite',
        'Experience working with design systems',
        'Ability to prototype and communicate design concepts effectively',
        'Strong understanding of typography, color, and layout',
        'Previous experience in an agency environment is a plus'
      ],
      companyDescription: 'Creative Studio is an award-winning design agency known for crafting immersive digital experiences for global brands.',
    ),
    JobModel(
      id: '33',
      title: 'Marketing Manager',
      company: 'GrowthUp',
      location: 'San Francisco, CA',
      salary: '\$110k - \$130k',
      type: 'Full-time',
      description: 'GrowthUp is seeking a results-oriented Marketing Manager to drive our growth strategies. You will lead campaigns across multiple channels, analyze performance metrics, and collaborate with product teams to optimize user acquisition and retention.',
      themeColor: Colors.orangeAccent,
      postedAgo: '12:37 PM',
      requirements: [
        '4+ years of experience in digital marketing',
        'Proven track record of managing successful ad campaigns',
        'Strong analytical skills and proficiency with Google Analytics',
        'Experience with content marketing and SEO',
        'Excellent written and verbal communication skills',
        'Ability to lead a small team and manage budgets'
      ],
      companyDescription: 'GrowthUp helps startups scale faster with data-driven marketing tools and expert consultancy.',
    ),
    JobModel(
      id: '1',
      title: 'Product Designer',
      company: 'Design Co',
      location: 'New York, NY',
      salary: '\$40hr',
      type: 'Remote',
      description: 'We are looking for a passionate Product Designer to join our team...',
      themeColor: Colors.blue,
      postedAgo: '1d ago',
    ),
    JobModel(
      id: '2',
      title: 'Senior Developer',
      company: 'Tech Solutions',
      location: 'San Francisco, CA',
      salary: '\$120k',
      type: 'Full-time',
      description: 'Join our engineering team to build the next generation of web apps...',
      themeColor: Colors.purple,
      postedAgo: '3h ago',
    ),
    JobModel(
      id: '3',
      title: 'Marketing Head',
      company: 'Growth Apps',
      location: 'Austin, TX',
      salary: '\$50hr',
      type: 'Hybrid',
      description: 'Lead our marketing strategy and grow our user base globally...',
      themeColor: Colors.green,
      postedAgo: '2d ago',
    ),
    JobModel(
      id: '4',
      title: 'CTO',
      company: 'AI Startup',
      location: 'Remote',
      salary: '\$180k',
      type: 'Remote',
      description: 'Looking for a visionary CTO to lead our AI research and development...',
      themeColor: Colors.orange,
      postedAgo: '5h ago',
    ),
    JobModel(
      id: '5',
      title: 'Backend Engineer',
      company: 'Cloud Scale',
      location: 'Remote',
      salary: '\$150k',
      type: 'Full-time',
      description: 'Expertise in Go/Python and distributed systems needed. Join our core infrastructure team to build scalable services.',
      themeColor: Colors.teal,
      postedAgo: 'Recent',
    ),
    JobModel(
      id: '6',
      title: 'ML Engineer',
      company: 'Future AI',
      location: 'San Jose, CA',
      salary: '\$200k',
      type: 'Hybrid',
      description: 'Join our research team to implement cutting edge AI models. Strong background in PyTorch or TensorFlow required.',
      themeColor: Colors.indigo,
      postedAgo: '2d ago',
    ),
    JobModel(
      id: '7',
      title: 'DevOps Specialist',
      company: 'Automate Inc',
      location: 'Remote',
      salary: '\$140k',
      type: 'Remote',
      description: 'Scaling our Kubernetes clusters and improving CI/CD pipelines. Experience with Terraform and AWS is a must.',
      themeColor: Colors.cyan,
      postedAgo: '1w ago',
    ),
    JobModel(
      id: '8',
      title: 'Full Stack Developer',
      company: 'App Master',
      location: 'Remote',
      salary: '\$130k',
      type: 'Full-time',
      description: 'Building beautiful and performant web applications using modern tech stacks...',
      themeColor: Colors.deepPurple,
      postedAgo: '3h ago',
    ),
    JobModel(
      id: '9',
      title: 'iOS Engineer',
      company: 'Fruit Tech',
      location: 'Cupertino, CA',
      salary: '\$170k',
      type: 'On-site',
      description: 'Join our mobile team to create the next generation of iOS experiences...',
      themeColor: Colors.blueGrey,
      postedAgo: '1d ago',
    ),
    JobModel(
      id: '10',
      title: 'Frontend Engineer',
      company: 'Pixel Perfect',
      location: 'Remote',
      salary: '\$125k',
      type: 'Remote',
      description: 'React/Next.js expert needed to lead our dashboard redesign...',
      themeColor: Colors.pinkAccent,
      postedAgo: '4h ago',
    ),
    JobModel(
      id: '11',
      title: 'Sales Executive',
      company: 'GrowFast',
      location: 'New York, NY',
      salary: '\$90k + Commission',
      type: 'Full-time',
      description: 'Looking for a results-driven Sales Executive to join our growing team...',
      themeColor: Colors.green,
      postedAgo: '1d ago',
    ),
    JobModel(
      id: '12',
      title: 'HR Manager',
      company: 'People First',
      location: 'Chicago, IL',
      salary: '\$110k',
      type: 'On-site',
      description: 'Lead our HR initiatives and maintain a positive company culture...',
      themeColor: Colors.redAccent,
      postedAgo: '2d ago',
    ),
    JobModel(
      id: '13',
      title: 'Marketing Specialist',
      company: 'AdVantage',
      location: 'Remote',
      salary: '\$85k',
      type: 'Remote',
      description: 'Manage our social media and digital marketing campaigns...',
      themeColor: Colors.orange,
      postedAgo: '5h ago',
    ),
    JobModel(
      id: '14',
      title: 'Financial Analyst',
      company: 'Wealth Corp',
      location: 'San Francisco, CA',
      salary: '\$130k',
      type: 'Hybrid',
      description: 'Analyze financial data and provide strategic recommendations...',
      themeColor: Colors.purple,
      postedAgo: '1w ago',
    ),
    JobModel(
      id: '15',
      title: 'Customer Support Lead',
      company: 'HelpHero',
      location: 'Remote',
      salary: '\$75k',
      type: 'Remote',
      description: 'Manage our customer support team and ensure high satisfaction...',
      themeColor: Colors.indigo,
      postedAgo: '3h ago',
    ),
    JobModel(
      id: '16',
      title: 'Sales Manager',
      company: 'TechFlow',
      location: 'Bangalore, India',
      salary: '₹18L - 25L',
      type: 'Full-time',
      description: 'Drive sales growth in the APAC region by leading a high-performing sales team.',
      themeColor: Colors.green,
      postedAgo: '4h ago',
    ),
    JobModel(
      id: '17',
      title: 'Finance Manager',
      company: 'FinStack',
      location: 'Mumbai, India',
      salary: '₹22L - 30L',
      type: 'Full-time',
      description: 'Oversee financial planning and analysis to ensure long-term profitability.',
      themeColor: Colors.purple,
      postedAgo: '1d ago',
    ),
    JobModel(
      id: '18',
      title: 'Project Coordinator',
      company: 'BuildIt Solutions',
      location: 'Remote',
      salary: '\$95k',
      type: 'Remote',
      description: 'Help manage project timelines and cross-functional team communication.',
      themeColor: Colors.cyan,
      postedAgo: '2d ago',
    ),
    JobModel(
      id: '19',
      title: 'HR Specialist',
      company: 'TalentHub',
      location: 'Hyderabad, India',
      salary: '₹12L - 18L',
      type: 'Hybrid',
      description: 'Focus on recruitment and employee engagement initiatives.',
      themeColor: Colors.redAccent,
      postedAgo: '5h ago',
    ),
    JobModel(
      id: '20',
      title: 'Growth Marketer',
      company: 'ViralBits',
      location: 'Remote',
      salary: '\$110k',
      type: 'Remote',
      description: 'Scale our user base through data-driven marketing experiments.',
      themeColor: Colors.orange,
      postedAgo: '1d ago',
    ),
    JobModel(
      id: '21',
      title: 'Service Operations Manager',
      company: 'ClientFirst',
      location: 'New York, NY',
      salary: '\$120k',
      type: 'On-site',
      description: 'Optimize service delivery processes and improve client metrics.',
      themeColor: Colors.indigo,
      postedAgo: '3d ago',
    ),
    JobModel(
      id: '22',
      title: 'Data Scientist',
      company: 'Insight AI',
      location: 'San Francisco, CA',
      salary: '\$185k',
      type: 'Full-time',
      description: 'Apply advanced statistical techniques and ML to solve complex problems.',
      themeColor: Colors.blue,
      postedAgo: 'Recent',
    ),
    JobModel(
      id: '23',
      title: 'Senior Project Manager',
      company: 'ScaleUp Corp',
      location: 'Remote',
      salary: '\$155k',
      type: 'Remote',
      description: 'Lead high-impact projects from conception to successful delivery.',
      themeColor: Colors.cyan,
      postedAgo: '1w ago',
    ),
    JobModel(
      id: '24',
      title: 'DevOps Engineer (L3)',
      company: 'CloudOps',
      location: 'Remote',
      salary: '\$165k',
      type: 'Remote',
      description: 'Manage multi-cloud infrastructure and automate deployments at scale.',
      themeColor: Colors.teal,
      postedAgo: '2h ago',
    ),
    JobModel(
      id: '25',
      title: 'UI Developer',
      company: 'WebCraft',
      location: 'London, UK',
      salary: '£75k - £90k',
      type: 'Hybrid',
      description: 'Build responsive and accessible web interfaces using React and Tailwind.',
      themeColor: Colors.pinkAccent,
      postedAgo: '1d ago',
    ),
    JobModel(
      id: '26',
      title: 'Elementary Teacher',
      company: 'Green Valley School',
      location: 'Austin, TX',
      salary: '\$55k',
      type: 'On-site',
      description: 'Looking for a passionate elementary teacher to join our faculty...',
      themeColor: Colors.blue,
      postedAgo: '4h ago',
    ),
    JobModel(
      id: '27',
      title: 'Operations Manager',
      company: 'Logistics Pro',
      location: 'Remote',
      salary: '\$105k',
      type: 'Remote',
      description: 'Optimize our supply chain and internal operations...',
      themeColor: Colors.indigo,
      postedAgo: '2d ago',
    ),
    JobModel(
      id: '28',
      title: 'Product Manager',
      company: 'Innovate AI',
      location: 'San Francisco, CA',
      salary: '\$145k',
      type: 'Hybrid',
      description: 'Lead the vision and lifecycle of our core AI products...',
      themeColor: Colors.orange,
      postedAgo: '1d ago',
    ),
    JobModel(
      id: '29',
      title: 'Education Consultant',
      company: 'EduScale',
      location: 'Remote',
      salary: '\$80k',
      type: 'Remote',
      description: 'Help institutions implement digital learning solutions...',
      themeColor: Colors.blue,
      postedAgo: '3d ago',
    ),
    JobModel(
      id: '30',
      title: 'Operations Analyst',
      company: 'Core Systems',
      location: 'New York, NY',
      salary: '\$90k',
      type: 'Full-time',
      description: 'Analyze and improve business processes for efficiency...',
      themeColor: Colors.indigo,
      postedAgo: '5h ago',
    ),
    JobModel(
      id: '31',
      title: 'Senior Frontend Engineer',
      company: 'TechFlow',
      location: 'Remote',
      salary: '\$140k - \$180k',
      type: 'Full-time',
      description: 'We are seeking a talented Senior Frontend Engineer to lead our web development initiatives. You will be responsible for building high-performance, scalable web applications using React, TypeScript, and modern state management libraries. The ideal candidate has a passion for UI/UX, clean code, and mentoring junior developers.',
      themeColor: Colors.blueAccent,
      postedAgo: '3:37 PM',
      requirements: [
        '5+ years of experience with React and TypeScript',
        'Strong understanding of state management (Redux, MobX, or Context API)',
        'Experience with Next.js or similar SSR frameworks',
        'Proficiency in CSS/SCSS and TailwindCSS',
        'Familiarity with CI/CD pipelines and testing frameworks (Jest, Cypress)',
        'Ability to mentor junior developers and conduct code reviews'
      ],
    ),
    JobModel(
      id: '32',
      title: 'Product Designer',
      company: 'Creative Studio',
      location: 'New York, NY',
      salary: '\$60 - \$90 /hr',
      type: 'Contract',
      description: 'Creative Studio is looking for a contract Product Designer to join our fast-paced creative team. You will be working on end-to-end design projects for high-profile clients. We value visual excellence and user-centric design thinking.',
      themeColor: Colors.purpleAccent,
      postedAgo: '5:37 PM',
      requirements: [
        'Portfolio demonstrating strong UI/UX skills',
        'Proficiency in Figma, Sketch, and Adobe Creative Suite',
        'Experience working with design systems',
        'Ability to prototype and communicate design concepts effectively',
        'Strong understanding of typography, color, and layout',
        'Previous experience in an agency environment is a plus'
      ],
    ),
    JobModel(
      id: '33',
      title: 'Marketing Manager',
      company: 'GrowthUp',
      location: 'San Francisco, CA',
      salary: '\$110k - \$130k',
      type: 'Full-time',
      description: 'GrowthUp is seeking a results-oriented Marketing Manager to drive our growth strategies. You will lead campaigns across multiple channels, analyze performance metrics, and collaborate with product teams to optimize user acquisition and retention.',
      themeColor: Colors.orangeAccent,
      postedAgo: '12:37 PM',
      requirements: [
        '4+ years of experience in digital marketing',
        'Proven track record of managing successful ad campaigns',
        'Strong analytical skills and proficiency with Google Analytics',
        'Experience with content marketing and SEO',
        'Excellent written and verbal communication skills',
        'Ability to lead a small team and manage budgets'
      ],
    ),
  ];

  final List<ServiceModel> allServices = [
    ServiceModel(
      id: '1',
      title: 'UI/UX Design for Mobile',
      provider: 'Alex Rivera',
      price: 'Starting at \$50',
      rating: '4.9',
      category: 'Design',
      description: 'I will create a modern and intuitive mobile app design...',
      themeColor: Colors.blue,
    ),
    ServiceModel(
      id: '2',
      title: 'Full Stack Web App Development',
      provider: 'Sarah Chen',
      price: 'Starting at \$150',
      rating: '5.0',
      category: 'Development',
      description: 'Expert in React, Node.js and MongoDB...',
      themeColor: Colors.indigo,
    ),
    ServiceModel(
      id: '3',
      title: 'Brand Identity & Logo Design',
      provider: 'Michael Scott',
      price: 'Starting at \$80',
      rating: '4.8',
      category: 'Design',
      description: 'Create a unique brand identity for your business...',
      themeColor: Colors.amber,
    ),
    ServiceModel(
      id: '4',
      title: 'SEO & Content Marketing',
      provider: 'Emma Wilson',
      price: 'Starting at \$40',
      rating: '4.7',
      category: 'Marketing',
      description: 'Get your website ranked higher on Google...',
      themeColor: Colors.green,
    ),
    ServiceModel(
      id: '5',
      title: 'Cloud Infrastructure Setup',
      provider: 'John Doe',
      price: 'Starting at \$100',
      rating: '4.9',
      category: 'DevOps',
      description: 'AWS, GCP, or Azure infrastructure setup...',
      themeColor: Colors.teal,
    ),
  ];

  var filteredJobs = <JobModel>[].obs;
  var filteredServices = <ServiceModel>[].obs;

  var savedJobIds = <String>{}.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize with all data
    filteredJobs.assignAll(allJobs);
    filteredServices.assignAll(allServices);
    
    // Listen to search changes
    debounce(searchQuery, (_) => searchJobs(), time: const Duration(milliseconds: 300));
    debounce(locationQuery, (_) => searchJobs(), time: const Duration(milliseconds: 300));
    debounce(marketplaceSearchQuery, (_) => searchServices(), time: const Duration(milliseconds: 300));
  }

  void switchTab(bool jobsSelected) {
    isJobsSelected.value = jobsSelected;
  }

  void searchJobs() {
    filteredJobs.assignAll(
      allJobs.where((job) {
        final matchesQuery = job.title.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
                            job.company.toLowerCase().contains(searchQuery.value.toLowerCase());
        final matchesLocation = job.location.toLowerCase().contains(locationQuery.value.toLowerCase());
        return matchesQuery && matchesLocation;
      }).toList(),
    );
  }

  void searchServices() {
    filteredServices.assignAll(
      allServices.where((service) {
        final matchesQuery = service.title.toLowerCase().contains(marketplaceSearchQuery.value.toLowerCase()) ||
                            service.provider.toLowerCase().contains(marketplaceSearchQuery.value.toLowerCase()) ||
                            service.category.toLowerCase().contains(marketplaceSearchQuery.value.toLowerCase());
        return matchesQuery;
      }).toList(),
    );
  }

  void filterByTag(String tag) {
    searchQuery.value = tag;
    searchJobs();
  }

  void filterServiceByCategory(String category) {
    marketplaceSearchQuery.value = category;
    searchServices();
  }

  void toggleSaveJob(String jobId) {
    if (savedJobIds.contains(jobId)) {
      savedJobIds.remove(jobId);
      Get.snackbar('Removed', 'Job removed from saved items', snackPosition: SnackPosition.BOTTOM);
    } else {
      savedJobIds.add(jobId);
      Get.snackbar('Saved', 'Job saved to your profile', snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green.withOpacity(0.1), colorText: Colors.green);
    }
  }

  void addJob(JobModel job) {
    allJobs.insert(0, job);
    searchJobs(); // Update filtered list
    Get.snackbar('Success', 'Job posted successfully!', snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green, colorText: Colors.white);
  }

  // Dynamic Stats
  int get activeJobsCount => filteredJobs.length;
  int get companiesCount => filteredJobs.map((j) => j.company).toSet().length;
  int get remoteJobsCount => filteredJobs.where((j) => j.type.toLowerCase().contains('remote') || j.location.toLowerCase().contains('remote')).length;
  String get avgSalary {
    // Mock calculation or basic parsing
    if (filteredJobs.isEmpty) return '\$0k';
    return '\$120k'; // Retaining mock for complexity reasons unless requested
  }
}
