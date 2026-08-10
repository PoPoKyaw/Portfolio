import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../providers/portfolio_providers.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_theme.dart';
import '../../models/portfolio_data.dart';

class NavHeader extends ConsumerWidget implements PreferredSizeWidget {
  final VoidCallback? onOpenDrawer;
  final Function(String sectionKey) onNavTap;

  const NavHeader({
    super.key,
    this.onOpenDrawer,
    required this.onNavTap,
  });

  @override
  Size get preferredSize => const Size.fromHeight(80);

  Future<void> _downloadCv(BuildContext context) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: PortfolioData.contactInfo.email,
      queryParameters: {
        'subject': 'Request CV / Portfolio Inquiry - Po Po Kyaw',
        'body': 'Hi Po Po,\n\nI reviewed your UI/UX portfolio and would like to request your full resume / discuss an opportunity.',
      },
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Contact: popokyaw62@gmail.com (+959 778 498 086)'),
            backgroundColor: AppColors.surface,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= AppTheme.kDesktopBreakpoint;
    final activeSection = ref.watch(activeSectionProvider);

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          height: 80,
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 48 : 20,
          ),
          decoration: BoxDecoration(
            color: AppColors.background.withValues(alpha: 0.8),
            border: const Border(
              bottom: BorderSide(color: AppColors.border, width: 1),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Logo / Brand Name
              InkWell(
                onTap: () => onNavTap('hero'),
                borderRadius: BorderRadius.circular(8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.cyanAccent.withValues(alpha: 0.3),
                            blurRadius: 12,
                          )
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'P',
                          style: GoogleFonts.plusJakartaSans(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'PO PO KYAW',
                              style: GoogleFonts.plusJakartaSans(
                                color: AppColors.textPrimary,
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.5,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: AppColors.cyanAccent,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'UI / UX DESIGNER',
                          style: GoogleFonts.inter(
                            color: AppColors.cyanAccent,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Desktop Navigation Items
              if (isDesktop)
                Row(
                  children: [
                    _NavLink(
                      label: 'Projects',
                      isActive: activeSection == 'projects',
                      onTap: () => onNavTap('projects'),
                    ),
                    _NavLink(
                      label: 'Process & Skills',
                      isActive: activeSection == 'skills',
                      onTap: () => onNavTap('skills'),
                    ),
                    _NavLink(
                      label: 'Experience',
                      isActive: activeSection == 'experience',
                      onTap: () => onNavTap('experience'),
                    ),
                    _NavLink(
                      label: 'Education',
                      isActive: activeSection == 'education',
                      onTap: () => onNavTap('education'),
                    ),
                    _NavLink(
                      label: 'Contact',
                      isActive: activeSection == 'contact',
                      onTap: () => onNavTap('contact'),
                    ),
                    const SizedBox(width: 24),
                    // Action button Download CV
                    ElevatedButton.icon(
                      onPressed: () => _downloadCv(context),
                      icon: const FaIcon(FontAwesomeIcons.download, size: 14),
                      label: const Text('Download CV'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        foregroundColor: AppColors.cyanAccent,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        side: const BorderSide(color: AppColors.cyanAccent, width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        textStyle: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                )
              else
                // Mobile Menu Button
                IconButton(
                  onPressed: onOpenDrawer,
                  icon: const Icon(
                    Icons.menu_rounded,
                    color: AppColors.textPrimary,
                    size: 28,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavLink extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavLink({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: GoogleFonts.inter(
                  color: isActive ? AppColors.cyanAccent : AppColors.textSecondary,
                  fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 2,
                width: isActive ? 20 : 0,
                decoration: BoxDecoration(
                  color: AppColors.cyanAccent,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
