import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/strings.dart';
import '../../../data/models/project_model.dart';
import '../../../data/services/firestore_service.dart';
import '../../components/project_card.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      width: double.infinity,
      color: AppColors.background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          Text(
            AppStrings.headerProjects,
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
          ).animate().fadeIn(delay: 200.ms).scaleX(end: 1.0, begin: 0.0),

          const SizedBox(height: 50),

          // Project Grid
          StreamBuilder<List<Project>>(
            stream: FirestoreService().getProjects(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator(color: AppColors.primary));
              }

              if (snapshot.hasError) {
                return const Center(child: Text(AppStrings.error, style: TextStyle(color: AppColors.error)));
              }

              final projects = snapshot.data ?? [];

              if (projects.isEmpty) {
                return const Center(
                  child: Text(
                    AppStrings.noProjects,
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                );
              }

              // Responsive Grid Logic
              // Mobile: ListView (1 column)
              // Desktop: GridView (2 or 3 columns)
              return LayoutBuilder(
                builder: (context, constraints) {
                  // Determine column count based on width
                  int crossAxisCount = constraints.maxWidth > 1100 ? 3 : (constraints.maxWidth > 700 ? 2 : 1);
                  return Wrap(
                    spacing: 24,
                    runSpacing: 24,
                    children: projects.map((project) {
                      // Calculate width for each card
                      double cardWidth = (constraints.maxWidth - (24 * (crossAxisCount - 1))) / crossAxisCount;
                      
                      return SizedBox(
                        width: cardWidth,
                        height: 320, 
                        child: ProjectCard(project: project),
                      ).animate().fadeIn(duration: 500.ms).scale(begin: const Offset(0.9, 0.9));
                    }).toList(),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}