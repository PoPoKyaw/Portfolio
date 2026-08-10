import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/portfolio_data.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_theme.dart';
import 'hover_card.dart';

class HeroSection extends StatelessWidget {
  final Function(String key) onNavTap;

  const HeroSection({
    super.key,
    required this.onNavTap,
  });

  Future<void> _launchCv() async {
    
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= AppTheme.kDesktopBreakpoint;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 64 : 24,
        vertical: isDesktop ? 80 : 40,
      ),
      child: isDesktop
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 6,
                  child: _HeroContent(onNavTap: onNavTap, onLaunchCv: _launchCv),
                ),
                // const SizedBox(width: 48),
                // Expanded(
                //   flex: 5,
                //   child: _HeroVisualCard(),
                // ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _HeroContent(onNavTap: onNavTap, onLaunchCv: _launchCv),
                // const SizedBox(height: 40),
                // _HeroVisualCard(),
              ],
            ),
    );
  }
}

class _HeroContent extends StatelessWidget {
  final Function(String key) onNavTap;
  final VoidCallback onLaunchCv;

  const _HeroContent({
    required this.onNavTap,
    required this.onLaunchCv,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Status Badge Pill
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.cyanAccent.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: AppColors.cyanAccent.withValues(alpha: 0.3)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Color(0xFF00E676),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Available for UI/UX Design Opportunities',
                style: GoogleFonts.inter(
                  color: AppColors.textPrimary,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Main Headline
        RichText(
          text: TextSpan(
            style: GoogleFonts.plusJakartaSans(
              color: AppColors.textPrimary,
              fontSize: isMobile ? 32 : 48,
              fontWeight: FontWeight.w800,
              height: 1.15,
              letterSpacing: -1.0,
            ),
            children: [
              const TextSpan(text: 'Crafting '),
              TextSpan(
                text: 'User-Centered',
                style: TextStyle(
                  foreground: Paint()
                    ..shader = AppColors.primaryGradient.createShader(
                      const Rect.fromLTWH(0, 0, 300, 50),
                    ),
                ),
              ),
              const TextSpan(text: '\nMobile & Web Experiences.'),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Subtitle / Bio summary
        Text(
          PortfolioData.contactInfo.summary,
          style: GoogleFonts.inter(
            color: AppColors.textSecondary,
            fontSize: isMobile ? 15 : 17,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 32),

        // Key Focus Area Chips
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: const [
            _SkillChip(label: 'Figma Prototyping', icon: FontAwesomeIcons.figma),
            _SkillChip(label: 'Usability Testing', icon: FontAwesomeIcons.vial),
            _SkillChip(label: 'Design Systems', icon: FontAwesomeIcons.layerGroup),
            _SkillChip(label: 'Computer Science B.Sc.', icon: FontAwesomeIcons.graduationCap),
          ],
        ),
        const SizedBox(height: 36),

        // CTA Buttons
        Wrap(
          spacing: 16,
          runSpacing: 16,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () => onNavTap('projects'),
              icon: const Icon(Icons.arrow_downward_rounded, size: 18),
              label: const Text('View Selected Work'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.cyanAccent,
                foregroundColor: Colors.white,
                elevation: 8,
                shadowColor: AppColors.cyanAccent.withValues(alpha: 0.4),
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                textStyle: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            OutlinedButton.icon(
              onPressed: () => onNavTap('contact'),
              icon: const Icon(Icons.mail_outline_rounded, size: 18),
              label: const Text('Contact Me'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.textPrimary,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                side: const BorderSide(color: AppColors.borderSubtle, width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                textStyle: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 48),

        // Metrics Row
        const _MetricsBanner(),
      ],
    );
  }
}

class _SkillChip extends StatelessWidget {
  final String label;
  final FaIconData icon;

  const _SkillChip({
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FaIcon(icon, size: 13, color: AppColors.cyanAccent),
          const SizedBox(width: 8),
          Text(
            label,
            style: GoogleFonts.inter(
              color: AppColors.textPrimary,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricsBanner extends StatelessWidget {
  const _MetricsBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          _MetricItem(number: '3+', label: 'Commercial Roles'),
          _DividerLine(),
          _MetricItem(number: '3', label: 'Featured Apps'),
          _DividerLine(),
          _MetricItem(number: '100%', label: 'User Centric'),
        ],
      ),
    );
  }
}

class _MetricItem extends StatelessWidget {
  final String number;
  final String label;

  const _MetricItem({
    required this.number,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ShaderMask(
          shaderCallback: (bounds) => AppColors.primaryGradient.createShader(bounds),
          child: Text(
            number,
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.inter(
            color: AppColors.textSecondary,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _DividerLine extends StatelessWidget {
  const _DividerLine();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      width: 1,
      color: AppColors.border,
    );
  }
}

class _HeroVisualCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HoverCard(
      hoverScale: 1.02,
      child: Container(
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.border, width: 1.5),
          gradient: const LinearGradient(
            colors: [
              AppColors.surface,
              AppColors.cardSurface,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.purpleAccent.withValues(alpha: 0.15),
              blurRadius: 40,
              spreadRadius: 2,
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Figma Window Mockup Header
            Row(
              children: [
                Row(
                  children: const [
                    _WindowDot(color: Color(0xFFFF5F56)),
                    SizedBox(width: 8),
                    _WindowDot(color: Color(0xFFFFBD2E)),
                    SizedBox(width: 8),
                    _WindowDot(color: Color(0xFF27C93F)),
                  ],
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    children: [
                      const FaIcon(FontAwesomeIcons.figma, size: 12, color: AppColors.cyanAccent),
                      const SizedBox(width: 6),
                      Text(
                        'Figma Design Canvas',
                        style: GoogleFonts.inter(
                          color: AppColors.textSecondary,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Mockup Card Content Showcase
            Container(
              height: 220,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.background.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.glassBorder),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Design System Components',
                            style: GoogleFonts.plusJakartaSans(
                              color: AppColors.textPrimary,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Mobile & Web UI Kit',
                            style: GoogleFonts.inter(
                              color: AppColors.textSecondary,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.cyanAccent.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'v2.4 Active',
                          style: GoogleFonts.inter(
                            color: AppColors.cyanAccent,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _MiniComponentCard(
                          title: 'Wireframes',
                          subtitle: 'User Flows & Low-Fi',
                          icon: Icons.alt_route_rounded,
                          color: AppColors.cyanAccent,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _MiniComponentCard(
                          title: 'High-Fi UI',
                          subtitle: 'Figma Interactive',
                          icon: Icons.palette_outlined,
                          color: AppColors.purpleAccent,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Profile highlight bar
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: AppColors.cyanAccent,
                  child: Text(
                    'PK',
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Po Po Kyaw',
                      style: GoogleFonts.plusJakartaSans(
                        color: AppColors.textPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Graduate of UCS Thaton (Computer Science)',
                      style: GoogleFonts.inter(
                        color: AppColors.textMuted,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _WindowDot extends StatelessWidget {
  final Color color;

  const _WindowDot({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}

class _MiniComponentCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  const _MiniComponentCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(height: 8),
          Text(
            title,
            style: GoogleFonts.inter(
              color: AppColors.textPrimary,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            subtitle,
            style: GoogleFonts.inter(
              color: AppColors.textSecondary,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
