import 'package:chandan_gupta/app/certificate/certificate.dart';
import 'package:chandan_gupta/web/certificate/certificate.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Certificate extends StatelessWidget {
  Certificate({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (_) => CertificateApp(),
      tablet: (_) => CertificateWeb(),
      desktop: (_) => CertificateWeb(),
    );
  }
}
