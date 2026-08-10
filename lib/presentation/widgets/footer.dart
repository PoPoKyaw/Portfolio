import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/portfolio_data.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_theme.dart';

class Footer extends StatelessWidget {
  final Function(String key) onNavTap;

  const Footer({
    super.key,
    required this.onNavTap,
  });

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= AppTheme.kDesktopBreakpoint;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 64 : 24,
        vertical: 40,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(
          top: BorderSide(color: AppColors.border),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Logo
              Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'P',
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'PO PO KYAW',
                    style: GoogleFonts.plusJakartaSans(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),

              // Back to Top Button
              IconButton(
                onPressed: () => onNavTap('hero'),
                tooltip: 'Back to Top',
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.border),
                  ),
                  child: const Icon(Icons.arrow_upward_rounded, color: AppColors.cyanAccent, size: 20),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Divider(color: AppColors.border),
          const SizedBox(height: 24),
          isDesktop
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '© 2026 Po Po Kyaw. All rights reserved. Built with Flutter Web & Riverpod.',
                      style: GoogleFonts.inter(
                        color: AppColors.textMuted,
                        fontSize: 13,
                      ),
                    ),
                    Row(
                      children: [
                        _FooterSocialIcon(
                          icon: FontAwesomeIcons.figma,
                          onTap: () => _launchUrl(PortfolioData.contactInfo.figmaUrl),
                        ),
                        const SizedBox(width: 16),
                        _FooterSocialIcon(
                          icon: FontAwesomeIcons.linkedinIn,
                          onTap: () => _launchUrl(PortfolioData.contactInfo.linkedinUrl),
                        ),
                        const SizedBox(width: 16),
                        _FooterSocialIcon(
                          icon: FontAwesomeIcons.behance,
                          onTap: () => _launchUrl(PortfolioData.contactInfo.behanceUrl),
                        ),
                        const SizedBox(width: 16),
                        _FooterSocialIcon(
                          icon: FontAwesomeIcons.github,
                          onTap: () => _launchUrl(PortfolioData.contactInfo.githubUrl),
                        ),
                      ],
                    ),
                  ],
                )
              : Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _FooterSocialIcon(
                          icon: FontAwesomeIcons.figma,
                          onTap: () => _launchUrl(PortfolioData.contactInfo.figmaUrl),
                        ),
                        const SizedBox(width: 16),
                        _FooterSocialIcon(
                          icon: FontAwesomeIcons.linkedinIn,
                          onTap: () => _launchUrl(PortfolioData.contactInfo.linkedinUrl),
                        ),
                        const SizedBox(width: 16),
                        _FooterSocialIcon(
                          icon: FontAwesomeIcons.behance,
                          onTap: () => _launchUrl(PortfolioData.contactInfo.behanceUrl),
                        ),
                        const SizedBox(width: 16),
                        _FooterSocialIcon(
                          icon: FontAwesomeIcons.github,
                          onTap: () => _launchUrl(PortfolioData.contactInfo.githubUrl),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '© 2026 Po Po Kyaw. All rights reserved.',
                      style: GoogleFonts.inter(
                        color: AppColors.textMuted,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}

class _FooterSocialIcon extends StatelessWidget {
  final FaIconData icon;
  final VoidCallback onTap;

  const _FooterSocialIcon({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: FaIcon(icon, size: 16, color: AppColors.textSecondary),
    );
  }
}
