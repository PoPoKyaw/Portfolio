import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/portfolio_data.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_theme.dart';
import 'hover_card.dart';
import 'section_header.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final projects = PortfolioData.projects;
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= AppTheme.kDesktopBreakpoint;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 64 : 24,
        vertical: isDesktop ? 48 : 32,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            badgeText: 'Portfolio Showcase',
            title: 'Selected Projects & Case Studies',
            subtitle:
                'Explore real-world mobile & web product design solutions crafted with user research, interactive prototypes, and usability testing.',
          ),
          const SizedBox(height: 24),

          // Responsive Grid View displaying compact project cards
          LayoutBuilder(
            builder: (context, constraints) {
              final gridCrossAxisCount = constraints.maxWidth > 1100
                  ? 3
                  : (constraints.maxWidth > 700 ? 2 : 1);

              final childAspectRatio = gridCrossAxisCount == 3
                  ? 1.3
                  : (gridCrossAxisCount == 2 ? 1.25 : 1.15);

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: projects.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: gridCrossAxisCount,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: childAspectRatio,
                ),
                itemBuilder: (context, index) {
                  final project = projects[index];
                  return _ProjectCard(project: project);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatelessWidget {
  final ProjectModel project;

  const _ProjectCard({required this.project});

  Future<void> _launchUrl(String? urlString) async {
    if (urlString == null) return;
    final Uri uri = Uri.parse(urlString);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  void _showDetailDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => _ProjectDetailModal(project: project),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredTags = project.tags.where((tag) => tag.toLowerCase() != 'figma').take(3).toList();

    return HoverCard(
      onTap: () => _showDetailDialog(context),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border, width: 1),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Compact Artwork Header
            Container(
              height: 95,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: project.gradientColors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      color: Colors.black.withValues(alpha: 0.15),
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          project.icon,
                          size: 32,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.35),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            project.category.toUpperCase(),
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 9.5,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Compact Card Body
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          project.title,
                          style: GoogleFonts.plusJakartaSans(
                            color: AppColors.textPrimary,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          project.shortDescription,
                          style: GoogleFonts.inter(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                            height: 1.3,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),

                        // Tags Chips
                        Wrap(
                          spacing: 6,
                          runSpacing: 4,
                          children: filteredTags.map((tag) {
                            return Container(
                              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppColors.background,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: AppColors.border),
                              ),
                              child: Text(
                                tag,
                                style: GoogleFonts.inter(
                                  color: AppColors.textMuted,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),

                    // Action Buttons Footer
                    Row(
                      children: [
                        if (project.playStoreUrl != null)
                          IconButton(
                            onPressed: () => _launchUrl(project.playStoreUrl),
                            tooltip: 'View on Google Play Store',
                            constraints: const BoxConstraints(),
                            padding: const EdgeInsets.only(right: 10),
                            icon: const FaIcon(FontAwesomeIcons.googlePlay, size: 14, color: AppColors.cyanAccent),
                          ),
                        if (project.behanceUrl != null)
                          IconButton(
                            onPressed: () => _launchUrl(project.behanceUrl),
                            tooltip: 'View on Behance',
                            constraints: const BoxConstraints(),
                            padding: const EdgeInsets.only(right: 10),
                            icon: const FaIcon(FontAwesomeIcons.behance, size: 14, color: AppColors.blueAccent),
                          ),
                        const Spacer(),
                        TextButton.icon(
                          onPressed: () => _showDetailDialog(context),
                          label: const Text('View Case Study'),
                          icon: const Icon(Icons.arrow_forward_rounded, size: 12),
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.cyanAccent,
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            textStyle: GoogleFonts.inter(
                              fontWeight: FontWeight.bold,
                              fontSize: 11.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProjectDetailModal extends StatelessWidget {
  final ProjectModel project;

  const _ProjectDetailModal({required this.project});

  Future<void> _launch(String? url) async {
    if (url == null) return;
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredTags = project.tags.where((tag) => tag.toLowerCase() != 'figma').toList();

    return Dialog(
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600),
        padding: const EdgeInsets.all(28),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      project.title,
                      style: GoogleFonts.plusJakartaSans(
                        color: AppColors.textPrimary,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close_rounded, color: AppColors.textSecondary),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.cyanAccent.withValues(alpha: 0.3)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.stars_rounded, color: AppColors.cyanAccent, size: 20),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        project.keyImpact,
                        style: GoogleFonts.inter(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                          fontSize: 12.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              Text(
                'Overview & Case Study Summary',
                style: GoogleFonts.plusJakartaSans(
                  color: AppColors.textPrimary,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                project.fullDescription,
                style: GoogleFonts.inter(
                  color: AppColors.textSecondary,
                  fontSize: 13.5,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Deliverables & Tools',
                style: GoogleFonts.plusJakartaSans(
                  color: AppColors.textPrimary,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: filteredTags.map((tag) {
                  return Chip(
                    label: Text(
                      tag,
                      style: GoogleFonts.inter(fontSize: 12),
                    ),
                    backgroundColor: AppColors.background,
                    side: const BorderSide(color: AppColors.border),
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    visualDensity: VisualDensity.compact,
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (project.playStoreUrl != null)
                    ElevatedButton.icon(
                      onPressed: () => _launch(project.playStoreUrl),
                      icon: const FaIcon(FontAwesomeIcons.googlePlay, size: 14),
                      label: const Text('View On Play Store'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.cyanAccent,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  if (project.behanceUrl != null) ...[
                    if (project.playStoreUrl != null) const SizedBox(width: 10),
                    ElevatedButton.icon(
                      onPressed: () => _launch(project.behanceUrl),
                      icon: const FaIcon(FontAwesomeIcons.behance, size: 14),
                      label: const Text('View On Behance'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.blueAccent,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
