import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/portfolio_data.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_theme.dart';
import 'hover_card.dart';
import 'section_header.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= AppTheme.kDesktopBreakpoint;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 64 : 24,
        vertical: isDesktop ? 60 : 36,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            badgeText: 'Competencies & Tools',
            title: 'Design Process & Core Skills',
            subtitle:
                'Combining user-centered design methodologies with modern prototyping software and computer science principles.',
          ),
          const SizedBox(height: 32),

          // UX Process Infographic Steps
          const _ProcessFlowWidget(),
          const SizedBox(height: 48),

          // Skill Category Cards Grid
          LayoutBuilder(
            builder: (context, constraints) {
              final gridCrossAxisCount = constraints.maxWidth > 900 ? 3 : (constraints.maxWidth > 600 ? 2 : 1);

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: PortfolioData.skillCategories.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: gridCrossAxisCount,
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 24,
                  childAspectRatio: gridCrossAxisCount == 1 ? 1.2 : 0.85,
                ),
                itemBuilder: (context, index) {
                  final category = PortfolioData.skillCategories[index];
                  return _SkillCategoryCard(category: category);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ProcessFlowWidget extends StatelessWidget {
  const _ProcessFlowWidget();

  static const steps = [
    {'step': '01', 'title': 'Empathize', 'sub': 'User Research & Persona'},
    {'step': '02', 'title': 'Define', 'sub': 'User Flows & IA'},
    {'step': '03', 'title': 'Ideate', 'sub': 'Wireframing & Layout'},
    {'step': '04', 'title': 'Prototype', 'sub': 'Figma Interactive UI'},
    {'step': '05', 'title': 'Test', 'sub': 'Usability Feedback'},
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= AppTheme.kDesktopBreakpoint;

    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.auto_awesome_rounded, color: AppColors.cyanAccent, size: 20),
              const SizedBox(width: 10),
              Text(
                'End-to-End Design Methodology',
                style: GoogleFonts.plusJakartaSans(
                  color: AppColors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          isDesktop
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: steps.map((s) {
                    final isLast = s == steps.last;
                    return Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: _ProcessItem(
                              step: s['step']!,
                              title: s['title']!,
                              sub: s['sub']!,
                            ),
                          ),
                          if (!isLast)
                            const Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 14,
                              color: AppColors.borderSubtle,
                            ),
                        ],
                      ),
                    );
                  }).toList(),
                )
              : Column(
                  children: steps.map((s) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _ProcessItem(
                        step: s['step']!,
                        title: s['title']!,
                        sub: s['sub']!,
                      ),
                    );
                  }).toList(),
                ),
        ],
      ),
    );
  }
}

class _ProcessItem extends StatelessWidget {
  final String step;
  final String title;
  final String sub;

  const _ProcessItem({
    required this.step,
    required this.title,
    required this.sub,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            step,
            style: GoogleFonts.plusJakartaSans(
              color: AppColors.cyanAccent,
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: GoogleFonts.plusJakartaSans(
              color: AppColors.textPrimary,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            sub,
            style: GoogleFonts.inter(
              color: AppColors.textSecondary,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class _SkillCategoryCard extends StatelessWidget {
  final SkillCategoryModel category;

  const _SkillCategoryCard({required this.category});

  FaIconData _getToolIcon(String toolName) {
    switch (toolName.toLowerCase()) {
      case 'figma':
        return FontAwesomeIcons.figma;
      case 'adobe xd':
        return FontAwesomeIcons.layerGroup;
      case 'notion':
        return FontAwesomeIcons.noteSticky;
      case 'adobe photoshop':
        return FontAwesomeIcons.image;
      case 'canva':
        return FontAwesomeIcons.paintbrush;
      default:
        return FontAwesomeIcons.circleCheck;
    }
  }

  @override
  Widget build(BuildContext context) {
    return HoverCard(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.cyanAccent.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(category.icon, color: AppColors.cyanAccent, size: 22),
                ),
                const SizedBox(width: 14),
                Text(
                  category.categoryTitle,
                  style: GoogleFonts.plusJakartaSans(
                    color: AppColors.textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: 8,
                  runSpacing: 10,
                  children: category.skills.map((skill) {
                    final toolIcon = _getToolIcon(skill);
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FaIcon(
                            toolIcon,
                            size: 13,
                            color: AppColors.cyanAccent,
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              skill,
                              style: GoogleFonts.inter(
                                color: AppColors.textPrimary,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
