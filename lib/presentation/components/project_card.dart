import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math';

import '../../data/models/project_model.dart';
import '../../core/constants/colors.dart';
import '../../core/utils/responsive.dart';

class ProjectCard extends StatefulWidget {
  final Project project;

  const ProjectCard({super.key, required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isFront = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutBack),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Toggle Flip status
  void _toggleCard() {
    if (_isFront) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    setState(() => _isFront = !_isFront);
  }

  Future<void> _launchURL(String? urlString) async {
    if (urlString == null || urlString.isEmpty) return;
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Detect if we are on mobile to change interaction (Tap vs Hover)
    bool isMobile = Responsive.isMobile(context);

    return MouseRegion(
      // On Desktop: Hover triggers flip
      onEnter: isMobile ? null : (_) => _toggleCard(),
      onExit: isMobile ? null : (_) => _toggleCard(),
      child: GestureDetector(
        // On Mobile: Tap triggers flip
        onTap: isMobile ? _toggleCard : null,
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            // Calculate the rotation angle (0 to 180 degrees / pi)
            final angle = _animation.value * pi;
            
            // Check if we have rotated past 90 degrees to switch content
            final isBackVisible = angle >= (pi / 2);
            
            // Matrix4 for 3D Perspective
            final transform = Matrix4.identity()
              ..setEntry(3, 2, 0.001) // Perspective depth
              ..rotateY(angle); // Rotate around Y axis

            return Transform(
              transform: transform,
              alignment: Alignment.center,
              child: isBackVisible
                  ? Transform(
                      // Mirror the back side so text is readable
                      alignment: Alignment.center,
                      transform: Matrix4.identity()..rotateY(pi), 
                      child: _buildBack(),
                    )
                  : _buildFront(),
            );
          },
        ),
      ),
    );
  }

  // --- FRONT SIDE (Image + Title) ---
  Widget _buildFront() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Full Image
          if (widget.project.imageUrl != null && widget.project.imageUrl!.isNotEmpty)
            Image.network(
              widget.project.imageUrl!,
              fit: BoxFit.cover,
              errorBuilder: (ctx, err, stack) => Container(color: AppColors.surfaceLight),
            )
          else
            Container(color: AppColors.surfaceLight),

          // Black Gradient Overlay (Bottom to Top)
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.2),
                  Colors.black.withValues(alpha: 0.9)
                ],
                stops: const [0.4, 0.7, 1.0],
              ),
            ),
          ),

          // 3. Text Content (Bottom Left)
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.project.title,
                  style: GoogleFonts.robotoMono(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                // Tech Stack
                Text(
                  widget.project.technologies.take(5).join(" • "),
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- BACK SIDE (Description + Buttons) ---
  Widget _buildBack() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.1),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Title (Again, for context)
          Text(
            widget.project.title,
            style: GoogleFonts.robotoMono(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 16),

          // Description
          Text(
            widget.project.description,
            style: const TextStyle(
              color: AppColors.textSecondary,
              height: 1.5,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 24),

          // Action Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.project.githubUrl != null)
                _CircleButton(
                  icon: FontAwesomeIcons.github,
                  tooltip: 'View Code',
                  onTap: () => _launchURL(widget.project.githubUrl),
                ),
              
              if (widget.project.githubUrl != null && widget.project.liveUrl != null)
                const SizedBox(width: 20),

              if (widget.project.liveUrl != null)
                _CircleButton(
                  icon: FontAwesomeIcons.rocket,
                  tooltip: 'Live Demo',
                  onTap: () => _launchURL(widget.project.liveUrl),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

// Helper for Round Buttons on the Back
class _CircleButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;

  const _CircleButton({
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(50),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.background,
            border: Border.all(color: AppColors.primary),
          ),
          child: FaIcon(icon, color: AppColors.primary, size: 20),
        ),
      ),
    );
  }
}