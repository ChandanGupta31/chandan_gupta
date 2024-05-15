import 'package:chandan_gupta/app/home/home.dart';
import 'package:chandan_gupta/web/home/home.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Home extends StatelessWidget {
  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (_) => HomeApp(),
      tablet: (_) => HomeWeb(),
      desktop: (_) => HomeWeb(),
    );
  }
}
