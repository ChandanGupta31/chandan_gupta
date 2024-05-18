import 'package:chandan_gupta/project/certificate.dart';
import 'package:chandan_gupta/project/contact.dart';
import 'package:chandan_gupta/project/home.dart';
import 'package:chandan_gupta/project/project.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class MyWeb extends StatefulWidget {
  int page;

  MyWeb({
    required this.page,
  });

  @override
  _MyWebState createState() => _MyWebState();
}

class _MyWebState extends State<MyWeb> {
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  var pages = [
    Home(),
    Certificate(),
    Project(),
    Contact(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: InkWell(
            onTap: (){
              widget.page = 0;
              setState(() {

              });
            },
            child: Text(
              'Chandan Gupta',
            ),
          ),
          titleTextStyle: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w500,
            color: Colors.white,
            fontFamily: 'BlackOps',
          ),
          actions: [
            TextButton(
              onPressed: () {
                widget.page = 0;
                setState(() {

                });
              },
              child: Text(
                'Home',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            TextButton(
              onPressed: () {
                widget.page = 1;
                setState(() {

                });
              },
              child: Text(
                'Certificates',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            TextButton(
              onPressed: () {
                widget.page = 2;
                setState(() {

                });
              },
              child: Text(
                'Projects',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            TextButton(
              onPressed: () {
                widget.page = 3;
                setState(() {

                });
              },
              child: Text(
                'Contact',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        extendBody: true,
        body: pages[widget.page]);
  }
}
