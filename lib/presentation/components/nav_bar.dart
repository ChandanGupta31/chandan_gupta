import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/strings.dart';
import '../../core/utils/responsive.dart';

class NavBar extends StatelessWidget {
  final VoidCallback onHomeTap;
  final VoidCallback onAboutTap;
  final VoidCallback onProjectsTap;
  final VoidCallback onContactTap;

  const NavBar({
    super.key,
    required this.onHomeTap,
    required this.onAboutTap,
    required this.onProjectsTap,
    required this.onContactTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: 0.9),
        border: const Border(
          bottom: BorderSide(color: AppColors.surfaceLight, width: 0.5),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.code, color: AppColors.primary, size: 28),
              const SizedBox(width: 8),
              Text(
                "PORTFOLIO",
                style: GoogleFonts.robotoMono(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),

          // Desktop Menu
          if (!Responsive.isMobile(context))
            Row(
              children: [
                _NavButton(title: AppStrings.navHome, onTap: onHomeTap),
                _NavButton(title: AppStrings.navAbout, onTap: onAboutTap),
                _NavButton(title: AppStrings.navProjects, onTap: onProjectsTap),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: onContactTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.background,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  child: const Text(AppStrings.navContact),
                ),
              ],
            ),

          // 3. Mobile Menu Trigger
          if (Responsive.isMobile(context))
             IconButton(
               icon: const Icon(Icons.menu, color: AppColors.textPrimary),
               onPressed: () {
                 Scaffold.of(context).openEndDrawer();
               },
             ),
        ],
      ),
    );
  }
}

// Helper for the text buttons
class _NavButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _NavButton({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: TextButton(
        onPressed: onTap,
        child: Text(
          title,
          style: const TextStyle(
            color: AppColors.textPrimary, 
            fontWeight: FontWeight.w500
          ),
        ),
      ),
    );
  }
}