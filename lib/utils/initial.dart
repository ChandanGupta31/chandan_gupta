import 'package:chandan_gupta/utils/my_app.dart';
import 'package:chandan_gupta/utils/my_web.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Initial extends StatelessWidget {
  Initial({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (_) => MyApp(page: 0),
      tablet: (_) => MyWeb(page: 0),
      desktop: (_) => MyWeb(page: 0),
    );
  }
}
