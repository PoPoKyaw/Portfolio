import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/portfolio_data.dart';
import '../../providers/portfolio_providers.dart';
import '../../theme/app_colors.dart';

class MobileDrawer extends ConsumerWidget {
  final Function(String sectionKey) onNavTap;

  const MobileDrawer({
    super.key,
    required this.onNavTap,
  });

  Future<void> _launchUrl(String urlString) async {
    final Uri uri = Uri.parse(urlString);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeSection = ref.watch(activeSectionProvider);

    return Drawer(
      backgroundColor: AppColors.background,
      child: SafeArea(
        child: Column(
          children: [
            // Drawer Header
            Container(
              padding: const EdgeInsets.all(24),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.surface,
                border: Border(
                  bottom: BorderSide(color: AppColors.border),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          gradient: AppColors.primaryGradient,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Center(
                          child: Text(
                            'PK',
                            style: GoogleFonts.plusJakartaSans(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            PortfolioData.contactInfo.name,
                            style: GoogleFonts.plusJakartaSans(
                              color: AppColors.textPrimary,
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            PortfolioData.contactInfo.role,
                            style: GoogleFonts.inter(
                              color: AppColors.cyanAccent,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    PortfolioData.contactInfo.location,
                    style: GoogleFonts.inter(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),

            // Nav List
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 16),
                children: [
                  _DrawerTile(
                    icon: Icons.grid_view_rounded,
                    title: 'Projects',
                    isActive: activeSection == 'projects',
                    onTap: () {
                      Navigator.pop(context);
                      onNavTap('projects');
                    },
                  ),
                  _DrawerTile(
                    icon: Icons.psychology_outlined,
                    title: 'Process & Skills',
                    isActive: activeSection == 'skills',
                    onTap: () {
                      Navigator.pop(context);
                      onNavTap('skills');
                    },
                  ),
                  _DrawerTile(
                    icon: Icons.work_outline_rounded,
                    title: 'Work Experience',
                    isActive: activeSection == 'experience',
                    onTap: () {
                      Navigator.pop(context);
                      onNavTap('experience');
                    },
                  ),
                  _DrawerTile(
                    icon: Icons.school_outlined,
                    title: 'Education & Certs',
                    isActive: activeSection == 'education',
                    onTap: () {
                      Navigator.pop(context);
                      onNavTap('education');
                    },
                  ),
                  _DrawerTile(
                    icon: Icons.mail_outline_rounded,
                    title: 'Contact',
                    isActive: activeSection == 'contact',
                    onTap: () {
                      Navigator.pop(context);
                      onNavTap('contact');
                    },
                  ),
                ],
              ),
            ),

            // Socials & Download CV CTA
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        _launchUrl('mailto:${PortfolioData.contactInfo.email}');
                      },
                      icon: const FaIcon(FontAwesomeIcons.paperPlane, size: 14),
                      label: const Text('Contact Me'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.cyanAccent,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        textStyle: GoogleFonts.inter(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _SocialIconButton(
                        icon: FontAwesomeIcons.github,
                        onTap: () => _launchUrl(PortfolioData.contactInfo.githubUrl),
                      ),
                      const SizedBox(width: 16),
                      _SocialIconButton(
                        icon: FontAwesomeIcons.linkedinIn,
                        onTap: () => _launchUrl(PortfolioData.contactInfo.linkedinUrl),
                      ),
                      const SizedBox(width: 16),
                      _SocialIconButton(
                        icon: FontAwesomeIcons.behance,
                        onTap: () => _launchUrl(PortfolioData.contactInfo.behanceUrl),
                      ),
                      const SizedBox(width: 16),
                      _SocialIconButton(
                        icon: FontAwesomeIcons.figma,
                        onTap: () => _launchUrl(PortfolioData.contactInfo.figmaUrl),
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

class _DrawerTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isActive;
  final VoidCallback onTap;

  const _DrawerTile({
    required this.icon,
    required this.title,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: isActive ? AppColors.cyanAccent : AppColors.textSecondary,
      ),
      title: Text(
        title,
        style: GoogleFonts.inter(
          color: isActive ? AppColors.cyanAccent : AppColors.textPrimary,
          fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
        ),
      ),
      trailing: isActive
          ? Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: AppColors.cyanAccent,
                shape: BoxShape.circle,
              ),
            )
          : null,
      onTap: onTap,
    );
  }
}

class _SocialIconButton extends StatelessWidget {
  final FaIconData icon;
  final VoidCallback onTap;

  const _SocialIconButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: FaIcon(
        icon,
        size: 18,
        color: AppColors.textSecondary,
      ),
    );
  }
}
