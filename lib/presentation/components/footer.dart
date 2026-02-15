import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/colors.dart';
import '../../core/utils/responsive.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  Future<void> _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 24),
      child: Column(
        children: [
          // Separator Line
          Divider(color: AppColors.surfaceLight.withValues(alpha: 0.5), thickness: 0.5),
          
          const SizedBox(height: 30),

          // Responsive Layout (Row on Desktop, Column on Mobile)
          Responsive(
            mobile: Column(
              children: [
                _buildCopyright(),
                const SizedBox(height: 20),
                _buildSocials(),
              ],
            ),
            desktop: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCopyright(),
                _buildSocials(),
              ],
            ),
          ),
          
          const SizedBox(height: 30),
          
          // "Designed in India" - Always Centered
          Center(
            child: Text(
              "Designed in India 🇮🇳",
              style: GoogleFonts.robotoMono(
                color: AppColors.primary.withValues(alpha: 0.5),
                fontSize: 10,
                letterSpacing: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Copyright Text
  Widget _buildCopyright() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // On mobile, we might want to center this text too
      children: [
        Text(
          "© 2026 Chandan Gupta",
          style: GoogleFonts.robotoMono(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        const Text(
          "Built with Flutter & Firebase",
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  // Helper Widget: Social Icons
  Widget _buildSocials() {
    return Row(
      mainAxisSize: MainAxisSize.min, // shrink to fit icons
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _FooterIcon(
          icon: FontAwesomeIcons.github, 
          onTap: () => _launchURL("https://github.com/ChandanGupta31")
        ),
        const SizedBox(width: 15),
        _FooterIcon(
          icon: FontAwesomeIcons.linkedin, 
          onTap: () => _launchURL("https://linkedin.com/in/erchandangupta")
        ),
        const SizedBox(width: 15),
        _FooterIcon(
          icon: FontAwesomeIcons.twitter, 
          onTap: () => _launchURL("https://twitter.com/Chandan06564490")
        ),
      ],
    );
  }
}

class _FooterIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _FooterIcon({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FaIcon(
          icon,
          size: 20,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}