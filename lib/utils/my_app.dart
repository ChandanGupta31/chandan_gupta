import 'package:chandan_gupta/project/certificate.dart';
import 'package:chandan_gupta/project/contact.dart';
import 'package:chandan_gupta/project/home.dart';
import 'package:chandan_gupta/project/project.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class MyApp extends StatefulWidget {

  int page;

  MyApp({
    required this.page,
});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  var pages = [
    Home(),
    Project(),
    Certificate(),
    Contact(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: widget.page,
          height: 60.0,
          items: <Widget>[
            Image.asset('assets/images/Home.png'),
            Image.asset('assets/images/Project.png'),
            Image.asset('assets/images/Certificate.png'),
            Image.asset('assets/images/Contact.png'),
          ],
          color: Theme.of(context).primaryColor,
          buttonBackgroundColor: Theme.of(context).primaryColor,
          backgroundColor: Colors.transparent,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 500),
          onTap: (index) {
            setState(() {
              widget.page = index;
            });
          },
          letIndexChange: (index) => true,
        ),
        body: pages[widget.page]
    );
  }
}