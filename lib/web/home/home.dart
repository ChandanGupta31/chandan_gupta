import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:chandan_gupta/utils/my_web.dart';
import 'package:chandan_gupta/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app/home/project_item.dart';
import '../../utils/firebase_data.dart';

class HomeWeb extends StatelessWidget {
  HomeWeb({super.key});

  Uri url = Uri.parse(FirebaseData.resumeLink);

  // To download Resume
  Future<void> downloadResume() async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height - 56,
              width: MediaQuery.of(context).size.width,
              color: Color(0xffceeeee),
              child: Row(
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              'Hello,\n'
                              'I\'m Chandan Gupta\n'
                              'A Flutter Developer',
                              style: Style.headerTextStyle,
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: downloadResume,
                                child: Text(
                                  'Resume',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                    color: Colors.white
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(context).primaryColor,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width*0.01,
                              ),
                              ElevatedButton(
                                onPressed: (){
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyWeb(page: 3),));
                                },
                                child: Text(
                                  'Contact',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(context).primaryColor,
                                ),
                              ),
                            ],
                          )
                        ],
                      )),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height *
                              0.5, // Adjust height as needed
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey
                                    .withOpacity(0.5), // Shadow color
                                spreadRadius: 5, // Spread radius
                                blurRadius: 7, // Blur radius
                                offset: Offset(0, 3), // Offset
                              ),
                            ],
                          ),
                          child: ClipOval(
                            child: Center(
                              child: FirebaseData.photoLink != ""
                                  ? Image.network(
                                      FirebaseData.photoLink,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.5,
                                    )
                                  : CircularProgressIndicator(
                                      color: Theme.of(context).primaryColor,
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.01,
                ),
                Text(
                  'Technology Stacks',
                  style: Style.subHeaderTextStyle,
                  textAlign: TextAlign.left,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                height: MediaQuery.of(context).size.height * 0.175 >
                    MediaQuery.of(context).size.width * 0.175
                    ? MediaQuery.of(context).size.height * 0.175
                    : MediaQuery.of(context).size.width * 0.175,
                margin:
                EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
                child: CarouselSlider.builder(
                  itemCount: FirebaseData.technologyStack.length,
                  itemBuilder:
                      (BuildContext context, int itemIndex, int pageViewIndex) {
                    return Column(
                      children: [
                        Image.network(
                          FirebaseData.technologyStack[itemIndex]['image'],
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          FirebaseData.technologyStack[itemIndex]['name'],
                          textAlign: TextAlign.center,
                        ),
                      ],
                    );
                  },
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height * 0.3,
                    viewportFraction: 0.2,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(milliseconds: 1500),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.easeInOut,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.2,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.07,
                ),
                Text(
                  'Projects',
                  style: Style.subHeaderTextStyle,
                  textAlign: TextAlign.left,
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyWeb(page: 2),
                        ));
                  }, // to jump on the project page
                  child: Text(
                    'View All',
                    style: Style.normalTextStyle,
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.07,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                height: MediaQuery.of(context).size.height * 0.175 >
                    MediaQuery.of(context).size.width * 0.175
                    ? MediaQuery.of(context).size.height * 0.175
                    : MediaQuery.of(context).size.width * 0.175,
                margin:
                EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
                child: CarouselSlider.builder(
                  itemCount: FirebaseData.projects.length,
                  itemBuilder:
                      (BuildContext context, int itemIndex, int pageViewIndex) {
                    return HomeProjectItem(
                      index: itemIndex,
                    );
                  },
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height * 0.5,
                    viewportFraction: 1,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.easeInOut,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.3,
                    scrollDirection: Axis.horizontal,
                  ),
                )),
            SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}
