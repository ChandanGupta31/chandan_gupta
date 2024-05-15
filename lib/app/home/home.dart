import 'package:carousel_slider/carousel_slider.dart';
import 'package:chandan_gupta/app/home/project_item.dart';
import 'package:chandan_gupta/utils/firebase_data.dart';
import 'package:chandan_gupta/utils/my_app.dart';
import 'package:chandan_gupta/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeApp extends StatelessWidget {
  HomeApp({super.key});
  // Declaring variables
  var height;
  var width;
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
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Center(
                child: FirebaseData.photoLink != ""
                    ? Image.network(
                        FirebaseData.photoLink,
                        height: height * 0.25,
                      )
                    : CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Helllo, I am',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.normal),
            ),
            Text(
              'CHANDAN GUPTA',
              style: Style.headerTextStyle,
            ),
            ElevatedButton(
              onPressed: downloadResume,
              child: Text(
                'Download Resume',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                  width: width * 0.07,
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
                EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
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
                    height: MediaQuery.of(context).size.height * 0.5,
                    viewportFraction: 0.4,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(milliseconds: 1500),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.easeInOut,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.3,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SizedBox(
                  width: width * 0.07,
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
                          builder: (context) => MyApp(page: 1),
                        ));
                  }, // to jump on the project page
                  child: Text(
                    'View All',
                    style: Style.normalTextStyle,
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(
                  width: width * 0.07,
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
              height: 20,
            ),
            Row(
              children: [
                SizedBox(
                  width: width * 0.07,
                ),
                Text(
                  'Certificates',
                  style: Style.subHeaderTextStyle,
                  textAlign: TextAlign.left,
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyApp(page: 2),
                        ));
                  }, // to jump on the project page
                  child: Text(
                    'View All',
                    style: Style.normalTextStyle,
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(
                  width: width * 0.07,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.25 >
                      MediaQuery.of(context).size.width * 0.25
                  ? MediaQuery.of(context).size.height * 0.25
                  : MediaQuery.of(context).size.width * 0.25,
              margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
              child: CarouselSlider.builder(
                itemCount: FirebaseData.projects.length,
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) {
                  return InkWell(
                    onTap: () async {
                      if (!await launchUrl(
                        Uri.parse(FirebaseData.certificates[itemIndex]),
                        mode: LaunchMode.externalApplication,
                      )) {
                        throw Exception('Could not launch url');
                      }
                    },
                    child: Image.network(
                      FirebaseData.certificates[itemIndex],
                    ),
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
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SizedBox(
                  width: width * 0.07,
                ),
                Text(
                  'My Journey',
                  style: Style.subHeaderTextStyle,
                  textAlign: TextAlign.left,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.only(
                right: 20,
                left: 20,
              ),
              child: Column(
                children: [
                  // UIET, CSJM University
                  TimelineTile(
                    afterLineStyle:
                        LineStyle(color: Theme.of(context).primaryColor),
                    beforeLineStyle:
                        LineStyle(color: Theme.of(context).primaryColor),
                    alignment: TimelineAlign.start,
                    indicatorStyle: IndicatorStyle(
                      iconStyle: IconStyle(
                          iconData: Icons.school_rounded,
                          color: Colors.yellowAccent),
                      color: Theme.of(context).primaryColor,
                      width: 50,
                      height: 50,
                    ),
                    endChild: Container(
                      height: 150,
                      padding: EdgeInsets.only(left: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'UIET, CSJM University, Kanpur',
                            style: Style.subHeaderTextStyle,
                          ),
                          Text(
                            'B.Tech (ECE) : 2021-25',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 18,
                                fontWeight: FontWeight.normal),
                          ),
                          Text(
                            'CPI :- 7.77',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // BarberHood
                  TimelineTile(
                    afterLineStyle:
                    LineStyle(color: Theme.of(context).primaryColor),
                    beforeLineStyle:
                    LineStyle(color: Theme.of(context).primaryColor),
                    alignment: TimelineAlign.start,
                    indicatorStyle: IndicatorStyle(
                      iconStyle: IconStyle(
                          iconData: Icons.computer_rounded,
                          color: Colors.yellowAccent),
                      color: Theme.of(context).primaryColor,
                      width: 50,
                      height: 50,
                    ),
                    endChild: Container(
                      height: 150,
                      padding: EdgeInsets.only(left: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'BarberHood',
                            style: Style.subHeaderTextStyle,
                          ),
                          Text(
                            'Designed & Developed : 2023',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 18,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Dream Dev Infotech
                  TimelineTile(
                    afterLineStyle:
                        LineStyle(color: Theme.of(context).primaryColor),
                    beforeLineStyle:
                        LineStyle(color: Theme.of(context).primaryColor),
                    alignment: TimelineAlign.start,
                    indicatorStyle: IndicatorStyle(
                      iconStyle: IconStyle(
                          iconData: Icons.computer_rounded,
                          color: Colors.yellowAccent),
                      color: Theme.of(context).primaryColor,
                      width: 50,
                      height: 50,
                    ),
                    endChild: Container(
                      height: 150,
                      padding: EdgeInsets.only(left: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Dream Dev InfoTech',
                            style: Style.subHeaderTextStyle,
                          ),
                          Text(
                            'Flutter Developer Intern : 2023',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 18,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // MPGI Hackathon
                  TimelineTile(
                    afterLineStyle:
                        LineStyle(color: Theme.of(context).primaryColor),
                    beforeLineStyle:
                        LineStyle(color: Theme.of(context).primaryColor),
                    alignment: TimelineAlign.start,
                    indicatorStyle: IndicatorStyle(
                      iconStyle: IconStyle(
                          iconData: Icons.computer_rounded,
                          color: Colors.yellowAccent),
                      color: Theme.of(context).primaryColor,
                      width: 50,
                      height: 50,
                    ),
                    endChild: Container(
                      height: 150,
                      padding: EdgeInsets.only(left: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'MPGI, Kanpur',
                            style: Style.subHeaderTextStyle,
                          ),
                          Text(
                            'Hackathon : 2023',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 18,
                                fontWeight: FontWeight.normal),
                          ),
                          Text(
                            'Participated',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Python Programming - IIT Kanpur
                  TimelineTile(
                    afterLineStyle:
                        LineStyle(color: Theme.of(context).primaryColor),
                    beforeLineStyle:
                        LineStyle(color: Theme.of(context).primaryColor),
                    alignment: TimelineAlign.start,
                    indicatorStyle: IndicatorStyle(
                      iconStyle: IconStyle(
                          iconData: Icons.verified_rounded,
                          color: Colors.yellowAccent),
                      color: Theme.of(context).primaryColor,
                      width: 50,
                      height: 50,
                    ),
                    endChild: Container(
                      height: 150,
                      padding: EdgeInsets.only(left: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'IIT Kanpur',
                            style: Style.subHeaderTextStyle,
                          ),
                          Text(
                            'Python Programming : 2021',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 18,
                                fontWeight: FontWeight.normal),
                          ),
                          Text(
                            'Certified',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Kendriya Vidyalaya, AFS Memaura
                  TimelineTile(
                    afterLineStyle:
                        LineStyle(color: Theme.of(context).primaryColor),
                    beforeLineStyle:
                        LineStyle(color: Theme.of(context).primaryColor),
                    alignment: TimelineAlign.start,
                    indicatorStyle: IndicatorStyle(
                      iconStyle: IconStyle(
                          iconData: Icons.school_rounded,
                          color: Colors.yellowAccent),
                      color: Theme.of(context).primaryColor,
                      width: 50,
                      height: 50,
                    ),
                    endChild: Container(
                      height: 150,
                      padding: EdgeInsets.only(left: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Kendriya Vidyalaya, Lucknow',
                            style: Style.subHeaderTextStyle,
                          ),
                          Text(
                            'Intermediate : 2021',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 18,
                                fontWeight: FontWeight.normal),
                          ),
                          Text(
                            'Percentage : 94.2%',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Bhonwal Convent School
                  TimelineTile(
                    isLast: true,
                    afterLineStyle:
                        LineStyle(color: Theme.of(context).primaryColor),
                    beforeLineStyle:
                        LineStyle(color: Theme.of(context).primaryColor),
                    alignment: TimelineAlign.start,
                    indicatorStyle: IndicatorStyle(
                      iconStyle: IconStyle(
                          iconData: Icons.school_rounded,
                          color: Colors.yellowAccent),
                      color: Theme.of(context).primaryColor,
                      width: 50,
                      height: 50,
                    ),
                    endChild: Container(
                      height: 150,
                      padding: EdgeInsets.only(left: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Bhonwal Convent School, Lucknow',
                            style: Style.subHeaderTextStyle,
                          ),
                          Text(
                            'High School : 2019',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 18,
                                fontWeight: FontWeight.normal),
                          ),
                          Text(
                            'Percentage : 87.8%',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
