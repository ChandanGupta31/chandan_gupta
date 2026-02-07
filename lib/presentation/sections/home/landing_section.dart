import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/strings.dart';
import '../../../core/utils/responsive.dart';
import '../../../data/services/firestore_service.dart';

class LandingSection extends StatelessWidget {
  final VoidCallback onScrollToProjects;
  final VoidCallback onScrollToContact;

  const LandingSection({
    super.key,
    required this.onScrollToProjects,
    required this.onScrollToContact,
  });

  @override
  Widget build(BuildContext context) {
    // fetching the profile data. 
    return FutureBuilder<Map<String, dynamic>?>(
      future: FirestoreService().getProfile(),
      builder: (context, snapshot) {
        // Default values (Fallbacks) if DB is empty
        String name = "Chandan Gupta";
        String role = "Flutter Developer";
        String bio = "Building scalable applications with Flutter, Firebase & Supabase.";

        if (snapshot.hasData && snapshot.data != null) {
          final data = snapshot.data!;
          name = data['name'] ?? name;
          role = data['role'] ?? role;
          bio = data['bio'] ?? bio;
        }

        return Container(
          // Ensure it takes at least the full screen height minus navbar
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height - 70,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Responsive(
            // Mobile Layout (Stacked)
            mobile: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildIllustration(), 
                const SizedBox(height: 30),
                _buildTextContent(name, role, bio, context),
              ],
            ),
            // Desktop Layout
            desktop: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: _buildTextContent(name, role, bio, context),
                ),
                Expanded(
                  flex: 2,
                  child: _buildIllustration(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextContent(String name, String role, String bio, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // 1. Greeting
        Text(
          "Hello, I'm",
          style: GoogleFonts.robotoMono(
            fontSize: 16,
            color: AppColors.primary,
          ),
        ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.2),

        const SizedBox(height: 10),

        // Name
        Text(
          name,
          style: GoogleFonts.inter(
            fontSize: Responsive.isMobile(context) ? 40 : 64,
            fontWeight: FontWeight.w800,
            height: 1.1,
            color: AppColors.textPrimary,
          ),
        ).animate().fadeIn(delay: 200.ms).moveY(begin: 20),

        // Role
        Text(
          role,
          style: GoogleFonts.inter(
            fontSize: Responsive.isMobile(context) ? 24 : 32,
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
          ),
        ).animate().fadeIn(delay: 400.ms),

        const SizedBox(height: 20),

        // Bio
        Text(
          bio,
          style: TextStyle(
            fontSize: 16,
            height: 1.6,
            color: AppColors.textSecondary.withValues(alpha: 0.8),
          ),
        ).animate().fadeIn(delay: 600.ms),

        const SizedBox(height: 40),

        // Buttons
        Row(
          children: [
            ElevatedButton(
              onPressed: onScrollToProjects,
              child: const Text(AppStrings.btnViewWork),
            ),
            const SizedBox(width: 20),
            OutlinedButton(
              onPressed: onScrollToContact,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: const BorderSide(color: AppColors.primary),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              ),
              child: const Text(AppStrings.btnContactMe),
            ),
          ],
        ).animate().fadeIn(delay: 800.ms).moveY(begin: 20),
      ],
    );
  }

  Widget _buildIllustration() {
    return Center(
      child: Container(
        width: 300,
        height: 300,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          // The Glow Effect
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.3),
              blurRadius: 30,
              spreadRadius: 5,
            ),
          ],
          border: Border.all(
            color: AppColors.primary.withValues(alpha: 0.8), 
            width: 3
          ),
        ),
        // The Image
        child: ClipOval(
          child: Image.asset(
            'assets/images/profile.png', // Make sure filename matches!
            fit: BoxFit.cover,
            // Fallback to icon if image fails to load
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: AppColors.surface,
                child: const Icon(Icons.person, size: 100, color: AppColors.textSecondary),
              );
            },
          ),
        ),
      ).animate()
       .scale(duration: 800.ms, curve: Curves.easeOutBack) // Fun pop-in animation
       .shimmer(delay: 1500.ms, duration: 2.seconds), // Shiny effect
    );
  }
}