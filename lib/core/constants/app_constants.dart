class AppConstants {
  AppConstants._();

  // Company Info
  static const String companyName = 'AIgent softwares';
  static const String tagline =
      'AI-First Software Development | We automate workflows, reduce manual effort, and ship AI-powered apps & web that scale with your business from day one.';
  static const String taglineShort =
      'We automate workflows, reduce manual effort, and ship AI-powered apps that scale.';
  static const String contactEmail = 'contact@aigentsoftwares.com';
  static const String websiteUrl = 'https://aigentsoftwares.com';

  // Nav Links
  static const List<Map<String, String>> navLinks = [
    {'label': 'Home', 'route': '/'},
    {'label': 'Services', 'route': '/services'},
    {'label': 'Portfolio', 'route': '/portfolio'},
    {'label': 'About', 'route': '/about'},
    {'label': 'Contact', 'route': '/contact'},
  ];

  // Stats
  static const List<Map<String, String>> stats = [
    {'number': '50', 'suffix': '+', 'label': 'Projects Delivered'},
    {'number': '30', 'suffix': '+', 'label': 'Happy Clients'},
    {'number': '3', 'suffix': '', 'label': 'Core Services'},
    {'number': '100', 'suffix': '%', 'label': 'AI-Powered'},
  ];

  // Services
  static const List<Map<String, dynamic>> services = [
    {
      'title': 'App Development',
      'subtitle': 'Cross-Platform Excellence',
      'description':
          'We build stunning iOS, Android, and cross-platform Flutter apps that deliver native performance with a single codebase. From MVPs to enterprise-scale apps — we make your idea real.',
      'features': [
        'iOS & Android',
        'Flutter Cross-Platform',
        'UI/UX Design',
        'App Store Launch'
      ],
      'icon': 'mobile',
    },
    {
      'title': 'Web Development',
      'subtitle': 'Stunning Digital Experiences',
      'description':
          'Animated websites, immersive 3D experiences, and Progressive Web Apps built with modern frameworks. We turn your brand into a digital destination that converts.',
      'features': [
        '3D Experiences',
        'PWA & SPA',
        'Performance Optimized',
        'SEO-First'
      ],
      'icon': 'web',
    },
    {
      'title': 'AI Workflow Agents',
      'subtitle': 'Intelligent Automation',
      'description':
          'Custom AI agents that automate repetitive business workflows, power CRM pipelines, handle sales follow-ups, and deliver data insights — so your team can focus on what matters.',
      'features': [
        'CRM Automation',
        'AI Sales Bots',
        'Data Pipelines',
        'Custom LLM Agents'
      ],
      'icon': 'ai',
    },
  ];

  // Why Choose Us
  static const List<Map<String, String>> whyChooseUs = [
    {
      'icon': '🧠',
      'title': 'AI-First Approach',
      'desc':
          'Every solution is built with artificial intelligence at its core, not as an afterthought.',
    },
    {
      'icon': '🏗️',
      'title': 'Scalable Architecture',
      'desc':
          'Clean, modular codebases that grow with your business from day one to million users.',
    },
    {
      'icon': '⚡',
      'title': 'Fast Delivery',
      'desc':
          'Rapid development cycles with continuous delivery. From concept to launch in weeks.',
    },
    {
      'icon': '🤖',
      'title': 'Custom AI Agents',
      'desc':
          'Bespoke intelligent agents trained on your data and integrated into your workflow.',
    },
    {
      'icon': '📱',
      'title': 'Cross-Platform',
      'desc':
          'One codebase, every platform. Web, iOS, Android — pixel-perfect on all screens.',
    },
    {
      'icon': '🔧',
      'title': 'End-to-End Support',
      'desc':
          'From discovery to deployment and beyond — we\'re your long-term technology partner.',
    },
  ];

  // Portfolio Projects
  static const List<Map<String, dynamic>> portfolio = [
    {
      'title': 'Learning Management System — EdTech Platform',
      'description':
          'We partnered with a well-known education platform to design and develop a full-featured Learning Management System that transforms the way students learn and educators teach. Built with a focus on simplicity, performance, and real impact, this LMS brings the entire learning journey into one seamless digital experience.',
      'tags': [
        'Available on Play Store & App Store',
        '10,000+ Downloads',
        'High User Retention'
      ],
      'image':
          'https://cdn.dribbble.com/userupload/13811157/file/original-f07a44ab0627c61aa5880a95e78ba1be.png?resize=2048x1690&vertical=center',
      'category': 'EdTech',
    },
    {
      'title': 'HealthTrack Flutter App',
      'description':
          'Cross-platform health monitoring app with AI-powered insights, real-time vitals tracking, and personalized recommendations.',
      'tags': ['Flutter', 'AI', 'Mobile'],
      'image':
          'https://images.unsplash.com/photo-1576091160399-112ba8d25d1d?w=600&q=80',
      'category': 'App Dev',
    },
    {
      'title': 'E-Commerce Web Platform',
      'description':
          'High-conversion e-commerce web app with 3D product previews, AI recommendations, and seamless checkout flow.',
      'tags': ['Web', 'Flutter', '3D'],
      'image':
          'https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?w=600&q=80',
      'category': 'Web Dev',
    },
    {
      'title': 'Smart Inventory Agent',
      'description':
          'AI agent that monitors stock levels, predicts demand, auto-raises purchase orders, and generates supplier reports.',
      'tags': ['AI', 'Automation', 'Analytics'],
      'image':
          'https://images.unsplash.com/photo-1586528116311-ad8dd3c8310d?w=600&q=80',
      'category': 'AI Agent',
    },
  ];

  // Process Steps
  static const List<Map<String, String>> processSteps = [
    {
      'step': '01',
      'title': 'Discovery',
      'desc':
          'We deep-dive into your business goals, pain points, and vision to define the perfect solution.',
    },
    {
      'step': '02',
      'title': 'Design',
      'desc':
          'Wire-frames, UI mockups, and interactive prototypes — all aligned with your brand.',
    },
    {
      'step': '03',
      'title': 'Build',
      'desc':
          'Agile sprints, clean code, continuous integration — shipping features fast and reliably.',
    },
    {
      'step': '04',
      'title': 'Test',
      'desc':
          'Rigorous QA, performance testing, and AI validation before anything touches production.',
    },
    {
      'step': '05',
      'title': 'Launch',
      'desc':
          'Deployment, monitoring setup, and 30-day post-launch support included.',
    },
  ];

  // Team Members
  static const List<Map<String, String>> team = [
    {
      'name': 'Ahmed Al-Rashidi',
      'role': 'Founder & AI Lead',
      'bio':
          'AI engineer with 8+ years building intelligent systems for enterprises across MENA and Europe.',
      'avatar':
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=300&q=80',
    },
    {
      'name': 'Sara Khalid',
      'role': 'Head of Flutter Development',
      'bio':
          'Flutter expert and Google Developer Expert with 50+ shipped cross-platform apps.',
      'avatar':
          'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=300&q=80',
    },
    {
      'name': 'Omar Yusuf',
      'role': 'Full-Stack Web Architect',
      'bio':
          'Specializes in 3D web experiences, performance optimization, and scalable backend systems.',
      'avatar':
          'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=300&q=80',
    },
  ];
}
