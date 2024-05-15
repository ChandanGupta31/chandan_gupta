import 'package:chandan_gupta/app/project/project.dart';
import 'package:chandan_gupta/web/project/project.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Project extends StatelessWidget {
  Project({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (_) => ProjectApp(),
      tablet: (_) => ProjectWeb(),
      desktop: (_) => ProjectWeb(),
    );
  }
}
