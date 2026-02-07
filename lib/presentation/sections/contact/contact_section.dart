import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/strings.dart';
import '../../../core/utils/responsive.dart';
import '../../../data/services/firestore_service.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  
  // Controllers to capture user input
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  // Function to launch Email Client
  Future<void> _sendEmail(String myEmail) async {
    if (_formKey.currentState!.validate()) {
      final Uri emailLaunchUri = Uri(
        scheme: 'mailto',
        path: myEmail,
        query: _encodeQueryParameters(<String, String>{
          'subject': 'Portfolio: ${_subjectController.text} (from ${_nameController.text})',
          'body': _messageController.text,
        }),
      );

      if (!await launchUrl(emailLaunchUri)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not launch email client.')),
        );
      }
    }
  }

  // Helper to handle special characters in URLs
  String? _encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  Future<void> _launchSocial(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      color: AppColors.surface,
      child: FutureBuilder<Map<String, dynamic>?>(
        future: FirestoreService().getProfile(),
        builder: (context, snapshot) {
          // Default contact info
          String email = "chandankumarguptabgt@gmail.com";
          String? github = "https://github.com/ChandanGupta31";
          String? linkedin = "https://www.linkedin.com/in/erchandangupta";

          if (snapshot.hasData && snapshot.data != null) {
            email = snapshot.data!['email'] ?? email;
            github = snapshot.data!['github_url'] ?? github;
            linkedin = snapshot.data!['linkedin_url'] ?? linkedin;
          }

          return Column(
            children: [
              // Header
              Text(
                AppStrings.headerContact,
                style: GoogleFonts.robotoMono(
                  fontSize: 32, 
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: 60, 
                height: 4, 
                color: AppColors.primary
              ),
              const SizedBox(height: 50),

              // Content Layout (Form + Socials)
              Responsive(
                mobile: Column(
                  children: [
                    _buildSocials(email, github, linkedin),
                    const SizedBox(height: 40),
                    _buildForm(email),
                  ],
                ),
                desktop: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: _buildSocials(email, github, linkedin),
                    ),
                    const SizedBox(width: 60),
                    Expanded(
                      flex: 1,
                      child: _buildForm(email),
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

  Widget _buildSocials(String email, String? github, String? linkedin) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Let's Connect",
          style: GoogleFonts.robotoMono(
            fontSize: 24, 
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          "I'm currently looking for new opportunities. Whether you have a question or just want to say hi, I'll try my best to get back to you!",
          style: TextStyle(color: AppColors.textSecondary, height: 1.6),
        ),
        const SizedBox(height: 32),
        
        // Social Icons
        Row(
          children: [
            if (github != null)
              _SocialButton(
                icon: FontAwesomeIcons.github, 
                onTap: () => _launchSocial(github)
              ),
            if (linkedin != null)
              _SocialButton(
                icon: FontAwesomeIcons.linkedin, 
                onTap: () => _launchSocial(linkedin)
              ),
            _SocialButton(
              icon: FontAwesomeIcons.envelope, 
              onTap: () => _launchSocial("mailto:$email")
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildForm(String myEmail) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Name'),
            validator: (value) => value!.isEmpty ? 'Please enter your name' : null,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _subjectController,
            decoration: const InputDecoration(labelText: 'Subject'),
            validator: (value) => value!.isEmpty ? 'Please enter a subject' : null,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _messageController,
            decoration: const InputDecoration(labelText: 'Message', alignLabelWithHint: true),
            maxLines: 5,
            validator: (value) => value!.isEmpty ? 'Please enter a message' : null,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => _sendEmail(myEmail),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.background,
              padding: const EdgeInsets.symmetric(vertical: 20),
            ),
            child: const Text("Send Message"),
          ),
        ],
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _SocialButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.surfaceLight),
      ),
      child: IconButton(
        icon: FaIcon(icon, color: AppColors.primary, size: 22),
        onPressed: onTap,
        padding: const EdgeInsets.all(12),
      ),
    );
  }
}