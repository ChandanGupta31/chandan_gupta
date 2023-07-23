import 'package:chandan_gupta/widgets/home_column.dart';
import 'package:chandan_gupta/widgets/home_row.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: MediaQuery.of(context).size.width <= 667 ? HomeColumn() : HomeRow(),
    );
  }
}
