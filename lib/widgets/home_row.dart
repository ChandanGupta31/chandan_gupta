import 'package:carousel_slider/carousel_slider.dart';
import 'package:chandan_gupta/services/firebase_data.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../screens/container.dart';

class HomeRow extends StatefulWidget {
  HomeRow({super.key});

  @override
  State<HomeRow> createState() => _HomeRowState();
}

class _HomeRowState extends State<HomeRow> {

  Uri url = Uri.parse(FirebaseData.resumeURL);

  void contact(){
    ContainerScreen.index = 3;
    Navigator.pushNamed(context, 'container');
  }

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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),
                  width: MediaQuery.of(context).size.width*0.58,
                  height: MediaQuery.of(context).size.height*0.75,
                  padding: EdgeInsets.all(15),
                  child: ListView.builder(
                    itemCount: FirebaseData.introduction.length,
                    itemBuilder: (context, index){
                      return Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 5,
                                spreadRadius: -1,
                                offset: Offset(3, 3),
                              )
                            ]
                        ),
                        child: Text(
                          FirebaseData.introduction[index],
                          style: TextStyle(
                            fontFamily: 'JMH',
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5,
                        spreadRadius: -1,
                        offset: Offset(3, 3),
                      )
                    ]
                  ),
                  width: MediaQuery.of(context).size.width*0.38,
                  padding: EdgeInsets.all(15),
                  margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          FirebaseData.profilePhoto,
                          width: MediaQuery.of(context).size.width*0.22,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Name : ',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.black
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Chandan Gupta',
                              style: TextStyle(
                                fontFamily: 'JMH',
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Age : ',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: FirebaseData.age,
                              style: TextStyle(
                                  fontFamily: 'JMH',
                                  fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Experience : ',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.black
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: FirebaseData.experience,
                              style: TextStyle(
                                fontFamily: 'JMH',
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Profession : ',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: FirebaseData.profession,
                              style: TextStyle(
                                  fontFamily: 'JMH',
                                  fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Qualification : ',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: FirebaseData.qualification,
                              style: TextStyle(
                                  fontFamily: 'JMH',
                                  fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height*0.07,
                  width: MediaQuery.of(context).size.width*0.4,
                  child: ElevatedButton(
                    onPressed: downloadResume,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.file_download_outlined),
                        SizedBox(width: 10,),
                        Text(
                          'Download Resume',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        maximumSize: Size(
                          MediaQuery.of(context).size.width*0.9,
                          MediaQuery.of(context).size.height*0.07,
                        )
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Container(
                  height: MediaQuery.of(context).size.height*0.07,
                  width: MediaQuery.of(context).size.width*0.4,
                  child: ElevatedButton(
                    onPressed: contact,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.call),
                        SizedBox(width: 10,),
                        Text(
                          'Contact',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        maximumSize: Size(
                          MediaQuery.of(context).size.width*0.9,
                          MediaQuery.of(context).size.height*0.07,
                        )
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width*0.05,
                top: MediaQuery.of(context).size.height*0.03,
              ),
              child: Text(
                'Certificates',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    fontFamily: 'JMH',
                    color: Theme.of(context).primaryColor
                ),
              ),
            ),
            Center(
              child: Container(
                  height: MediaQuery.of(context).size.height*0.5,
                  margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.05),
                  child: CarouselSlider.builder(
                    itemCount: FirebaseData.certificateList.length,
                    itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                        Image.network(
                            FirebaseData.certificateList[itemIndex],
                        ),
                    options: CarouselOptions(
                      height: MediaQuery.of(context).size.height*0.5,
                      aspectRatio: 16/9,
                      viewportFraction: 1,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.3,
                      scrollDirection: Axis.horizontal,
                    ),
                  )
              ),
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height*0.1,
            )
          ],
        ),
      ),
    );
  }
}
