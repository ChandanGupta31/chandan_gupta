import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';

import 'firebase_options.dart';
import 'core/theme/app_theme.dart';
import 'core/constants/colors.dart';
import 'core/constants/strings.dart';
import 'presentation/components/nav_bar.dart';
import 'presentation/sections/home/landing_section.dart';
import 'presentation/sections/about/about_section.dart';
import 'presentation/sections/projects/projects_section.dart';
import 'presentation/sections/contact/contact_section.dart';
import 'package:portfolio/presentation/components/footer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase connection
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portfolio | Chandan Gupta',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme, // Apply our custom dark theme
      home: const PortfolioHome(),
    );
  }
}

class PortfolioHome extends StatefulWidget {
  const PortfolioHome({super.key});

  @override
  State<PortfolioHome> createState() => _PortfolioHomeState();
}

class _PortfolioHomeState extends State<PortfolioHome> {
  // Create Keys to identify each section
  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  // Scroll Logic: Smoothly scroll to the widget with the given key
  void _scrollToSection(GlobalKey key) {
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOutQuart,
    );
    // If on mobile (drawer is open), close it after clicking
    if (Scaffold.of(context).isEndDrawerOpen) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      
      //  Mobile Navigation Drawer (Hidden on Desktop)
      endDrawer: _buildMobileDrawer(),
      
      body: Stack(
        children: [
          // The Scrollable Content
          SingleChildScrollView(
            child: Column(
              children: [
                // We wrap each section in a SizedBox with its Key
                SizedBox(
                  key: _homeKey, 
                  child: LandingSection(
                    onScrollToProjects: () => _scrollToSection(_projectsKey),
                    onScrollToContact: () => _scrollToSection(_contactKey),
                  ),
                ),
                SizedBox(key: _aboutKey, child: const AboutSection()),
                SizedBox(key: _projectsKey, child: const ProjectsSection()),
                SizedBox(key: _contactKey, child: const ContactSection()),
                const Footer(),
                const SizedBox(height: 50),
              ],
            ),
          ),

          // The Floating Navbar 
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: NavBar(
              onHomeTap: () => _scrollToSection(_homeKey),
              onAboutTap: () => _scrollToSection(_aboutKey),
              onProjectsTap: () => _scrollToSection(_projectsKey),
              onContactTap: () => _scrollToSection(_contactKey),
            ),
          ),
        ],
      ),
    );
  }

  // The Mobile Slide-out Menu
  Widget _buildMobileDrawer() {
    return Drawer(
      backgroundColor: AppColors.surface,
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        children: [
          Center(
            child: Text(
              "MENU",
              style: GoogleFonts.robotoMono(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
                letterSpacing: 2.0,
              ),
            ),
          ),
          const SizedBox(height: 40),
          _DrawerItem(title: AppStrings.navHome, onTap: () => _scrollToSection(_homeKey)),
          _DrawerItem(title: AppStrings.navAbout, onTap: () => _scrollToSection(_aboutKey)),
          _DrawerItem(title: AppStrings.navProjects, onTap: () => _scrollToSection(_projectsKey)),
          _DrawerItem(title: AppStrings.navContact, onTap: () => _scrollToSection(_contactKey)),
        ],
      ),
    );
  }
}

// Individual Drawer Item
class _DrawerItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _DrawerItem({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(fontSize: 18, color: AppColors.textPrimary),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.primary),
      onTap: () {
        Navigator.of(context).pop();
        onTap();
      },
      contentPadding: const EdgeInsets.symmetric(vertical: 8),
    );
  }
}