import 'package:chandan_gupta/app/contact/contact.dart';
import 'package:chandan_gupta/web/contact/contact.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Contact extends StatelessWidget {
  Contact({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (_) => ContactApp(),
      tablet: (_) => ContactWeb(),
      desktop: (_) => ContactWeb(),
    );
  }
}
