import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/portfolio_data.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_theme.dart';
import 'hover_card.dart';
import 'section_header.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isSending = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSending = true);

    final Uri mailUri = Uri(
      scheme: 'mailto',
      path: PortfolioData.contactInfo.email,
      queryParameters: {
        'subject': _subjectController.text.isEmpty
            ? 'Portfolio Contact: Message from ${_nameController.text}'
            : _subjectController.text,
        'body': 'Name: ${_nameController.text}\nEmail: ${_emailController.text}\n\nMessage:\n${_messageController.text}',
      },
    );

    if (await canLaunchUrl(mailUri)) {
      await launchUrl(mailUri);
    }

    if (mounted) {
      setState(() => _isSending = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: const [
              Icon(Icons.check_circle_outline_rounded, color: AppColors.cyanAccent),
              SizedBox(width: 12),
              Text('Opening email client to send message...'),
            ],
          ),
          backgroundColor: AppColors.surface,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
      _nameController.clear();
      _emailController.clear();
      _subjectController.clear();
      _messageController.clear();
    }
  }

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
            badgeText: "Let's Connect",
            title: 'Get In Touch & Collaborate',
            subtitle:
                'Whether you have a product design inquiry, freelance project, or full-time UI/UX role opportunity, feel free to drop a message.',
          ),
          const SizedBox(height: 36),

          isDesktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 5,
                      child: _ContactInfoCard(onLaunchUrl: _launchUrl),
                    ),
                    const SizedBox(width: 36),
                    Expanded(
                      flex: 7,
                      child: _ContactFormCard(
                        formKey: _formKey,
                        nameController: _nameController,
                        emailController: _emailController,
                        subjectController: _subjectController,
                        messageController: _messageController,
                        isSending: _isSending,
                        onSubmit: _submitForm,
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    _ContactInfoCard(onLaunchUrl: _launchUrl),
                    const SizedBox(height: 24),
                    _ContactFormCard(
                      formKey: _formKey,
                      nameController: _nameController,
                      emailController: _emailController,
                      subjectController: _subjectController,
                      messageController: _messageController,
                      isSending: _isSending,
                      onSubmit: _submitForm,
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}

class _ContactInfoCard extends StatelessWidget {
  final Function(String url) onLaunchUrl;

  const _ContactInfoCard({required this.onLaunchUrl});

  @override
  Widget build(BuildContext context) {
    final info = PortfolioData.contactInfo;

    return HoverCard(
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Contact Information',
              style: GoogleFonts.plusJakartaSans(
                color: AppColors.textPrimary,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Reach out directly via email, phone, or design platforms.',
              style: GoogleFonts.inter(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 32),

            // Email item
            _ContactDetailTile(
              icon: Icons.mail_outline_rounded,
              label: 'Direct Email',
              value: info.email,
              onTap: () => onLaunchUrl('mailto:${info.email}'),
            ),
            const SizedBox(height: 20),

            // Phone item
            _ContactDetailTile(
              icon: Icons.phone_outlined,
              label: 'Phone / WhatsApp',
              value: info.phone,
              onTap: () => onLaunchUrl('tel:${info.phone}'),
            ),
            const SizedBox(height: 20),

            // Location item
            _ContactDetailTile(
              icon: Icons.location_on_outlined,
              label: 'Location',
              value: info.location,
            ),
            const SizedBox(height: 36),

            Text(
              'Connect on Design Platforms',
              style: GoogleFonts.inter(
                color: AppColors.textMuted,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _SocialChip(
                  icon: FontAwesomeIcons.figma,
                  label: 'Figma',
                  onTap: () => onLaunchUrl(info.figmaUrl),
                ),
                _SocialChip(
                  icon: FontAwesomeIcons.behance,
                  label: 'Behance',
                  onTap: () => onLaunchUrl(info.behanceUrl),
                ),
                _SocialChip(
                  icon: FontAwesomeIcons.linkedinIn,
                  label: 'LinkedIn',
                  onTap: () => onLaunchUrl(info.linkedinUrl),
                ),
                _SocialChip(
                  icon: FontAwesomeIcons.github,
                  label: 'GitHub',
                  onTap: () => onLaunchUrl(info.githubUrl),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactDetailTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback? onTap;

  const _ContactDetailTile({
    required this.icon,
    required this.label,
    required this.value,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.cyanAccent.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppColors.cyanAccent, size: 22),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.inter(
                    color: AppColors.textMuted,
                    fontSize: 12,
                  ),
                ),
                Text(
                  value,
                  style: GoogleFonts.inter(
                    color: AppColors.textPrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SocialChip extends StatelessWidget {
  final FaIconData icon;
  final String label;
  final VoidCallback onTap;

  const _SocialChip({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      avatar: FaIcon(icon, size: 14, color: AppColors.cyanAccent),
      label: Text(label),
      onPressed: onTap,
      backgroundColor: AppColors.background,
      labelStyle: GoogleFonts.inter(
        color: AppColors.textPrimary,
        fontSize: 13,
        fontWeight: FontWeight.w500,
      ),
      side: const BorderSide(color: AppColors.border),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}

class _ContactFormCard extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController subjectController;
  final TextEditingController messageController;
  final bool isSending;
  final VoidCallback onSubmit;

  const _ContactFormCard({
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.subjectController,
    required this.messageController,
    required this.isSending,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border),
      ),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Send a Message',
              style: GoogleFonts.plusJakartaSans(
                color: AppColors.textPrimary,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: _CustomTextField(
                    controller: nameController,
                    label: 'Your Name',
                    hint: 'e.g. Alex Morgan',
                    validator: (v) => v == null || v.isEmpty ? 'Name required' : null,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _CustomTextField(
                    controller: emailController,
                    label: 'Your Email',
                    hint: 'alex@example.com',
                    keyboardType: TextInputType.emailAddress,
                    validator: (v) => v == null || !v.contains('@') ? 'Valid email required' : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _CustomTextField(
              controller: subjectController,
              label: 'Subject',
              hint: 'Project Inquiry / Job Opportunity',
            ),
            const SizedBox(height: 16),
            _CustomTextField(
              controller: messageController,
              label: 'Message',
              hint: 'Describe your project requirements or question...',
              maxLines: 4,
              validator: (v) => v == null || v.length < 5 ? 'Please enter a detailed message' : null,
            ),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: isSending ? null : onSubmit,
                icon: isSending
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.background,
                        ),
                      )
                    : const Icon(Icons.send_rounded, size: 18),
                label: Text(isSending ? 'Sending...' : 'Send Message'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.cyanAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  textStyle: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final int maxLines;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const _CustomTextField({
    required this.controller,
    required this.label,
    required this.hint,
    this.maxLines = 1,
    this.keyboardType,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: AppColors.textPrimary,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          validator: validator,
          style: GoogleFonts.inter(color: AppColors.textPrimary, fontSize: 14),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.inter(color: AppColors.textMuted, fontSize: 13),
            filled: true,
            fillColor: AppColors.background,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.cyanAccent, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}
