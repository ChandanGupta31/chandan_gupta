import 'package:chandan_gupta/screens/certificate.dart';
import 'package:chandan_gupta/screens/contact.dart';
import 'package:chandan_gupta/screens/home.dart';
import 'package:chandan_gupta/screens/project.dart';
import 'package:chandan_gupta/services/firebase_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class ContainerScreen extends StatefulWidget {
  static var index = 0;
  ContainerScreen({super.key});

  @override
  State<ContainerScreen> createState() => _ContainerScreenState();
}

class _ContainerScreenState extends State<ContainerScreen> {

  var screenList = [
    HomeScreen(),
    ProjectScreen(),
    CertificateScreen(),
    ContactScreen(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Chandan Gupta'),
        titleTextStyle: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          fontFamily: 'JMH',
          color: Theme.of(context).primaryColor,
        ),
      ),

      extendBody: true,

      body: screenList[ContainerScreen.index],

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey.shade300,
              hoverColor: Colors.grey.shade100,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 22,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 200),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.white,
              tabs: [
                GButton(
                  icon: Icons.home_filled,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.checklist_rounded,
                  text: 'Project',
                ),
                GButton(
                  icon: Icons.grading_rounded,
                  text: 'Certificate',
                ),
                GButton(
                  icon: Icons.contact_phone_rounded,
                  text: 'Contact',
                ),
              ],
              selectedIndex: ContainerScreen.index,
              onTabChange: (Index) {
                setState(() {
                  ContainerScreen.index = Index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
