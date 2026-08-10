import 'package:flutter/material.dart';

class ProjectModel {
  final String id;
  final String title;
  final String category;
  final String shortDescription;
  final String fullDescription;
  final List<String> tags;
  final String? playStoreUrl;
  final String? figmaUrl;
  final String? behanceUrl;
  final String keyImpact;
  final IconData icon;
  final List<Color> gradientColors;

  const ProjectModel({
    required this.id,
    required this.title,
    required this.category,
    required this.shortDescription,
    required this.fullDescription,
    required this.tags,
    this.playStoreUrl,
    this.figmaUrl,
    this.behanceUrl,
    required this.keyImpact,
    required this.icon,
    required this.gradientColors,
  });
}

class ExperienceModel {
  final String id;
  final String role;
  final String company;
  final String period;
  final String location;
  final List<String> bullets;

  const ExperienceModel({
    required this.id,
    required this.role,
    required this.company,
    required this.period,
    required this.location,
    required this.bullets,
  });
}

class SkillCategoryModel {
  final String categoryTitle;
  final IconData icon;
  final List<String> skills;

  const SkillCategoryModel({
    required this.categoryTitle,
    required this.icon,
    required this.skills,
  });
}

class EducationModel {
  final String degree;
  final String institution;
  final String period;

  const EducationModel({
    required this.degree,
    required this.institution,
    required this.period,
  });
}

class CertificationModel {
  final String title;
  final String issuer;
  final String iconBadge;

  const CertificationModel({
    required this.title,
    required this.issuer,
    required this.iconBadge,
  });
}

class ContactInfoModel {
  final String name;
  final String role;
  final String email;
  final String phone;
  final String location;
  final String summary;
  final String figmaUrl;
  final String linkedinUrl;
  final String behanceUrl;
  final String githubUrl;
  final String dribbbleUrl;

  const ContactInfoModel({
    required this.name,
    required this.role,
    required this.email,
    required this.phone,
    required this.location,
    required this.summary,
    required this.figmaUrl,
    required this.linkedinUrl,
    required this.behanceUrl,
    required this.githubUrl,
    required this.dribbbleUrl,
  });
}

/// Static Repository containing all data extracted from Po Po Kyaw's CV.
class PortfolioData {
  static const ContactInfoModel contactInfo = ContactInfoModel(
    name: 'PO PO KYAW',
    role: 'UI / UX Designer',
    email: 'popokyaw62@gmail.com',
    phone: '+959 778 498 086',
    location: 'Hlaing Township, Yangon',
    summary:
        'UI/UX Designer with hands-on experience designing user-centered web and mobile applications from research to high-fidelity UI. Skilled in wireframing, prototyping, and usability testing, with a Computer Science background that supports effective collaboration with developers and product teams.',
    figmaUrl: 'https://www.figma.com/@popokyaw',
    linkedinUrl: 'https://www.linkedin.com/in/popokyaw',
    behanceUrl: 'https://www.behance.net/popokyaw',
    githubUrl: 'https://github.com/popokyaw',
    dribbbleUrl: 'https://dribbble.com/popokyaw',
  );

  static final List<ProjectModel> projects = [
    const ProjectModel(
      id: 'ushop',
      title: 'U-Shop | E-commerce App',
      category: 'Mobile App',
      shortDescription:
          'UI/UX design for a real-world installment-based e-commerce mobile application available on Google Play.',
      fullDescription:
          'U-Shop simplifies installment buying for mobile users. The design focuses on streamlining product discovery, flexible payment plan selection, transparent interest calculations, and checkout clarity to boost user conversion.',
      tags: ['Figma', 'Mobile App', 'E-commerce', 'Usability Testing'],
      playStoreUrl: 'https://play.google.com/store/apps/details?id=com.ushop.app',
      keyImpact: 'Streamlined multi-tier installment selection & checkout clarity.',
      icon: Icons.shopping_bag_outlined,
      gradientColors: [Color(0xFF00F2FE), Color(0xFF4FACFE)],
    ),
    const ProjectModel(
      id: 'dreamify',
      title: 'Dreamify | Sleep Tracking App',
      category: 'Mobile App',
      shortDescription:
          'End-to-end UI/UX design of a sleep tracking and sleep assistant mobile application.',
      fullDescription:
          'Dreamify helps users establish healthier sleep habits through intuitive sleep data visualization, smart sleep cycle alarms, and habit-building daily check-ins with dark-mode optimized interface elements.',
      tags: ['Figma', 'Mobile App', 'Data Visualization', 'User Flow'],
      figmaUrl: 'https://www.figma.com/proto/dreamify-sleep-tracker-app',
      keyImpact: 'Intuitive sleep metric graphs & habit-building UX flows.',
      icon: Icons.nights_stay_outlined,
      gradientColors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
    ),
    const ProjectModel(
      id: 'connectify',
      title: 'Connectify | Social Connection App',
      category: 'Mobile App',
      shortDescription:
          'Onboarding, chat interfaces, and event planning flows for real-world social meetups.',
      fullDescription:
          'Connectify bridges the gap between online conversations and offline meetups. Designed frictionless onboarding, contextual location-based event invites, and real-time chat interactions.',
      tags: ['Figma', 'Mobile App', 'Social & Onboarding', 'UI/UX Design'],
      behanceUrl: 'https://www.behance.net/gallery/connectify-social-app',
      keyImpact: 'Interactive onboarding & event planning meetup UI.',
      icon: Icons.people_outline_rounded,
      gradientColors: [Color(0xFFFF512F), Color(0xFFDD2476)],
    ),
  ];

  static final List<ExperienceModel> experiences = [
    const ExperienceModel(
      id: 'ezy_pro',
      role: 'Freelance UI/UX Designer',
      company: 'Ezy Pro Company',
      period: 'February 2026 – July 2026',
      location: 'Yangon, Myanmar',
      bullets: [
        'Designed responsive web and mobile UI interfaces using Figma.',
        'Created comprehensive wireframes, user flows, and interactive prototypes.',
        'Collaborated with product owners to deliver user-centered design solutions.',
        'Improved overall product usability through clean layouts and intuitive experiences.',
      ],
    ),
    const ExperienceModel(
      id: 'nanolabs',
      role: 'UI/UX Designer',
      company: 'Nanolabs Company',
      period: 'April 2024 - February 2026',
      location: 'Yangon, Myanmar',
      bullets: [
        'Designed end-to-end UI/UX for web and mobile products, including user flows, wireframes, and high-fidelity prototypes in Figma.',
        'Partnered closely with developers and product managers to deliver feasible and production-ready design solutions.',
        'Conducted usability testing sessions and iteratively refined UI based on quantitative user feedback.',
        'Maintained visual consistency and design system principles across multi-platform projects.',
      ],
    ),
    const ExperienceModel(
      id: 'pyitsaya',
      role: 'Junior Graphic Designer',
      company: 'Pyitsaya Digital Marketing Agency',
      period: 'August 2022 - December 2022',
      location: 'Yangon, Myanmar',
      bullets: [
        'Designed high-engagement digital marketing assets including social media graphics and website banners.',
        'Maintained consistent client branding across diverse digital marketing campaigns.',
        'Refined visuals based on client feedback and design reviews.',
      ],
    ),
  ];

  static final List<SkillCategoryModel> skillCategories = [
    const SkillCategoryModel(
      categoryTitle: 'Design Skills',
      icon: Icons.design_services_outlined,
      skills: [
        'User Research',
        'Wireframing',
        'Prototyping',
        'User Flow',
        'Responsive Design',
        'Usability Testing',
        'Design Systems',
      ],
    ),
    const SkillCategoryModel(
      categoryTitle: 'Tools',
      icon: Icons.build_circle_outlined,
      skills: [
        'Figma',
        'Adobe XD',
        'Notion',
        'Adobe Photoshop',
        'Canva',
      ],
    ),
    const SkillCategoryModel(
      categoryTitle: 'Other Skills',
      icon: Icons.psychology_outlined,
      skills: [
        'Basic HTML/CSS',
        'Agile Teamwork',
        'Cross-functional Collaboration',
        'Communication',
        'Problem Solving',
        'Empathy',
      ],
    ),
  ];

  static const EducationModel education = EducationModel(
    degree: 'Bachelor of Computer Science',
    institution: 'University of Computer Studies, Thaton',
    period: '2016 - 2025',
  );

  static final List<CertificationModel> certifications = [
    const CertificationModel(
      title: 'Start the UX Design Process: Empathize, Define, and Ideate',
      issuer: 'Google UX',
      iconBadge: 'Google',
    ),
    const CertificationModel(
      title: 'Foundation of User Experience (UX) Design',
      issuer: 'Google UX',
      iconBadge: 'Google',
    ),
    const CertificationModel(
      title: 'Certificate in UI/UX Design',
      issuer: 'MM Project',
      iconBadge: 'MM Project',
    ),
  ];
}
