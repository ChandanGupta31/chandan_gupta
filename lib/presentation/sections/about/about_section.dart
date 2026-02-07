import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/strings.dart';
import '../../../core/utils/responsive.dart';
import '../../../data/services/firestore_service.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  Future<void> _launchResume(String? url) async {
    if (url != null && await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      color:
          AppColors.surface,
      child: FutureBuilder<Map<String, dynamic>?>(
        future: FirestoreService().getProfile(),
        builder: (context, snapshot) {
          // Default Data
          String bio =
              "I am a passionate Flutter developer with a knack for building beautiful, high-performance applications. I specialize in mobile development and backend integration.";
          String? resumeUrl;
          List<String> skills = [
            "Flutter",
            "Dart",
            "Firebase",
            "Supabase",
            "Git",
            "REST APIs",
            "Provider",
            "Riverpod"
          ];

          if (snapshot.hasData && snapshot.data != null) {
            bio = snapshot.data!['about'] ?? bio;
            resumeUrl = snapshot.data!['resume_url'];
            if (snapshot.data!['skills'] != null) {
              skills = List<String>.from(snapshot.data!['skills']);
            }
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                AppStrings.headerAbout,
                style: GoogleFonts.robotoMono(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ).animate().fadeIn(duration: 500.ms).slideX(begin: -0.1),

              const SizedBox(height: 10),
              Container(
                width: 60,
                height: 4,
                color: AppColors.primary,
              ).animate().fadeIn(delay: 200.ms).scaleX(),

              const SizedBox(height: 50),

              // Content (Responsive)
              Responsive(
                mobile: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildBioText(bio),
                    const SizedBox(height: 30),
                    _buildSkills(skills),
                    const SizedBox(height: 40),
                    _buildResumeButton(resumeUrl),
                  ],
                ),
                desktop: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left Column: Bio & Button
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildBioText(bio),
                          const SizedBox(height: 40),
                          _buildResumeButton(resumeUrl),
                        ],
                      ),
                    ),
                    const SizedBox(width: 60),
                    // Right Column: Skills
                    Expanded(
                      flex: 2,
                      child: _buildSkills(skills),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBioText(String bio) {
    return Text(
      bio,
      style: const TextStyle(
        fontSize: 16,
        height: 1.8,
        color: AppColors.textSecondary,
      ),
    ).animate().fadeIn(delay: 300.ms);
  }

  Widget _buildSkills(List<String> skills) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Tech Stack",
          style: GoogleFonts.robotoMono(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: skills.map((skill) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.surfaceLight),
              ),
              child: Text(
                skill,
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }).toList(),
        ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2),
      ],
    );
  }

  Widget _buildResumeButton(String? url) {
    if (url == null || url.isEmpty) return const SizedBox.shrink();

    return ElevatedButton.icon(
      onPressed: () => _launchResume(url),
      icon: const Icon(Icons.download),
      label: const Text("Download Resume"),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.background,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
      ),
    ).animate().fadeIn(delay: 500.ms).scale();
  }
}
