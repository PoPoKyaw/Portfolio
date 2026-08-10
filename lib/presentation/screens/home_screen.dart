import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/portfolio_providers.dart';
import '../../theme/app_colors.dart';
import '../widgets/contact_section.dart';
import '../widgets/education_certs_section.dart';
import '../widgets/experience_section.dart';
import '../widgets/footer.dart';
import '../widgets/hero_section.dart';
import '../widgets/mobile_drawer.dart';
import '../widgets/nav_header.dart';
import '../widgets/projects_section.dart';
import '../widgets/skills_section.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final Map<String, GlobalKey> _sectionKeys = {
    'hero': GlobalKey(),
    'projects': GlobalKey(),
    'skills': GlobalKey(),
    'experience': GlobalKey(),
    'education': GlobalKey(),
    'contact': GlobalKey(),
  };

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    // Dynamically calculate active section based on scroll offset
    for (final entry in _sectionKeys.entries) {
      final keyContext = entry.value.currentContext;
      if (keyContext != null) {
        final box = keyContext.findRenderObject() as RenderBox?;
        if (box != null) {
          final position = box.localToGlobal(Offset.zero);
          if (position.dy >= -200 && position.dy <= 300) {
            ref.read(activeSectionProvider.notifier).state = entry.key;
            break;
          }
        }
      }
    }
  }

  void _scrollToSection(String key) {
    ref.read(activeSectionProvider.notifier).state = key;
    final targetContext = _sectionKeys[key]?.currentContext;
    if (targetContext != null) {
      Scrollable.ensureVisible(
        targetContext,
        duration: const Duration(milliseconds: 650),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.background,
      endDrawer: MobileDrawer(onNavTap: _scrollToSection),
      appBar: NavHeader(
        onOpenDrawer: () => _scaffoldKey.currentState?.openEndDrawer(),
        onNavTap: _scrollToSection,
      ),
      body: SelectionArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              // Hero Section
              Container(
                key: _sectionKeys['hero'],
                child: HeroSection(onNavTap: _scrollToSection),
              ),

              // Projects Section
              Container(
                key: _sectionKeys['projects'],
                child: const ProjectsSection(),
              ),

              // Skills & Design Process Section
              Container(
                key: _sectionKeys['skills'],
                child: const SkillsSection(),
              ),

              // Experience Section
              Container(
                key: _sectionKeys['experience'],
                child: const ExperienceSection(),
              ),

              // Education & Certs Section
              Container(
                key: _sectionKeys['education'],
                child: const EducationCertsSection(),
              ),

              // Contact Section
              Container(
                key: _sectionKeys['contact'],
                child: const ContactSection(),
              ),

              // Footer
              Footer(onNavTap: _scrollToSection),
            ],
          ),
        ),
      ),
    );
  }
}
