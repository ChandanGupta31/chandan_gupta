import 'dart:convert';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:chandan_gupta/utils/my_web.dart';
import 'package:chandan_gupta/utils/styles.dart';
import 'package:chandan_gupta/web/home/project_item.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/firebase_data.dart';
import 'package:http/http.dart' as http;

class HomeWeb extends StatefulWidget {
  HomeWeb({super.key});

  @override
  State<HomeWeb> createState() => _HomeWebState();
}

class _HomeWebState extends State<HomeWeb> {
  // Variable declaration
  late GoogleSignIn _googleSignIn;
  late String _accessToken;
  late String _idToken;

  // Controller Declaration
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var messageController = TextEditingController();

  // Defining URLs
  var urlLinkedIn = Uri.parse(FirebaseData.linkedinLink);
  var urlGitHub = Uri.parse(FirebaseData.githubLink);
  var urlInstagram = Uri.parse(FirebaseData.instagramLink);
  var urlTwitter = Uri.parse(FirebaseData.twitterLink);
  var urlResume = Uri.parse(FirebaseData.resumeLink);

  // ****************** Defining Functions **********************
  void sendMail() async {
    // creating credential parameters
    final serviceID = 'service_vr5kq3b';
    final templateID = 'template_k8bylkf';
    final userID = 'ABABx6GtDCvIf8DI3';

    if (nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        messageController.text.isNotEmpty) {
      if (EmailValidator.validate(emailController.text.toString())) {
        try {
          // sending mail via post request
          final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
          final response = await http.post(
            url,
            headers: {
              'origin': 'http://localhost',
              'Content-Type': 'application/json',
            },
            body: json.encode({
              'service_id': serviceID,
              'template_id': templateID,
              'user_id': userID,
              'template_params': {
                'user_subject': 'Mail From Website',
                'user_name': nameController.text.toString(),
                'user_email': emailController.text.toString(),
                'user_mobile': 'Not Provided',
                'message': messageController.text.toString(),
              }
            }),
          );

          // showing success response
          if (response.statusCode == 200) {
            // clearing fields
            nameController.clear();
            emailController.clear();
            messageController.clear();

            // showing alert Dialog
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Success"),
                  content: Text(
                      "E-Mail sent Successfully\nGet back to you soon...."),
                  actions: [
                    ElevatedButton(
                      child: Text("OK"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                  alignment: Alignment.topCenter,
                  backgroundColor: Colors.green,
                );
              },
            );
          }

          // showing failure response
          else {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Error"),
                  content: Text(
                      "Unable to Send E-Mail\nTry sending by yourself at Given E-Mail"),
                  actions: [
                    ElevatedButton(
                      child: Text("OK"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                  alignment: Alignment.topCenter,
                  backgroundColor: Colors.redAccent.shade200,
                );
              },
            );
          }
        } catch (ex) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Error"),
                content: Text(
                    "Unable to Send E-Mail\nTry sending by yourself at Given E-Mail"),
                actions: [
                  ElevatedButton(
                    child: Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
                alignment: Alignment.topCenter,
                backgroundColor: Colors.redAccent.shade200,
              );
            },
          );
        }
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Invalid E-Mail ID"),
              content: Text("Enter a Valid E-mail"),
              actions: [
                ElevatedButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
              alignment: Alignment.topCenter,
              backgroundColor: Colors.redAccent.shade200,
            );
          },
        );
      }
    }

    // user has not provided sufficient data
    else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Insufficient Data"),
            content: Text("Fill All the Details"),
            actions: [
              ElevatedButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
            alignment: Alignment.topCenter,
            backgroundColor: Colors.redAccent.shade200,
          );
        },
      );
    }
  }

  // Launching URLs or download resume
  void launchURL(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  // Copying Data
  void copyText(String text) {
    Clipboard.setData(ClipboardData(text: text));
    EasyLoading.showToast(
      'Copied !',
      toastPosition: EasyLoadingToastPosition.bottom,
      duration: Duration(seconds: 1),
    );
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
                                onPressed: () {
                                  launchURL(urlResume);
                                },
                                child: Text(
                                  'Resume',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.01,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MyWeb(page: 3),
                                      ));
                                },
                                child: Text(
                                  'Contact',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
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
              margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
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
                  width: MediaQuery.of(context).size.width * 0.01,
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
                  width: MediaQuery.of(context).size.width * 0.02,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.15 >
                      MediaQuery.of(context).size.width * 0.15
                  ? MediaQuery.of(context).size.height * 0.15
                  : MediaQuery.of(context).size.width * 0.15,
              margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
              child: CarouselSlider.builder(
                itemCount: FirebaseData.projects.length,
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) {
                  return HomeProjectItem(
                    index: itemIndex,
                  );
                },
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height * 0.35,
                  viewportFraction: 0.5,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
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
                  width: MediaQuery.of(context).size.width * 0.01,
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
                          builder: (context) => MyWeb(page: 1),
                        ));
                  }, // to jump on the project page
                  child: Text(
                    'View All',
                    style: Style.normalTextStyle,
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.02,
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
                  viewportFraction: 0.5,
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
              height: 25,
            ),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.01,
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
                          iconData: Icons.school, color: Colors.yellowAccent),
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
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
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
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
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
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
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
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
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
                          iconData: Icons.verified, color: Colors.yellowAccent),
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
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
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
                          iconData: Icons.school, color: Colors.yellowAccent),
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
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
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
                          iconData: Icons.school, color: Colors.yellowAccent),
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
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
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
            SizedBox(
              height: 25,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.65,
              decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  )),
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Contact Me',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.email_rounded,
                              color: Theme.of(context).primaryColor,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            GestureDetector(
                              onTap: () {
                                copyText(FirebaseData.email);
                              },
                              child: Text(
                                FirebaseData.email,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.call,
                              color: Theme.of(context).primaryColor,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            GestureDetector(
                              onTap: () {
                                copyText(FirebaseData.number);
                              },
                              child: Text(
                                FirebaseData.number,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_rounded,
                              color: Theme.of(context).primaryColor,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              FirebaseData.address,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Divider(
                          color: Colors.grey.shade700,
                          endIndent: MediaQuery.of(context).size.width * 0.1,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                launchURL(urlLinkedIn);
                              },
                              icon: Image.asset(
                                'assets/images/linkedin.png',
                                color: Theme.of(context).primaryColor,
                              ),
                              constraints: BoxConstraints(
                                minWidth: 45,
                                maxHeight: 45,
                                maxWidth: 45,
                                minHeight: 45,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                launchURL(urlGitHub);
                              },
                              icon: Image.asset(
                                'assets/images/github.png',
                                color: Theme.of(context).primaryColor,
                              ),
                              constraints: BoxConstraints(
                                minWidth: 45,
                                maxHeight: 45,
                                maxWidth: 45,
                                minHeight: 45,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                launchURL(urlInstagram);
                              },
                              icon: Image.asset(
                                'assets/images/instagram.png',
                                color: Theme.of(context).primaryColor,
                              ),
                              constraints: BoxConstraints(
                                minWidth: 45,
                                maxHeight: 45,
                                maxWidth: 45,
                                minHeight: 45,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                launchURL(urlTwitter);
                              },
                              icon: Image.asset(
                                'assets/images/twitter.png',
                                color: Theme.of(context).primaryColor,
                              ),
                              constraints: BoxConstraints(
                                minWidth: 45,
                                maxHeight: 45,
                                maxWidth: 45,
                                minHeight: 45,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Full Name',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey.shade600),
                        ),
                        TextFormField(
                          controller: nameController,
                          maxLines: 1,
                          keyboardType: TextInputType.name,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Chandan Gupta',
                            hintStyle: TextStyle(color: Colors.grey),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Theme.of(context).primaryColor,
                                )),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Colors.grey,
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'E-mail ID',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey.shade600),
                        ),
                        TextFormField(
                          controller: emailController,
                          maxLines: 1,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            hintText: 'ckgbgt@gmail.com',
                            hintStyle: TextStyle(color: Colors.grey),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Theme.of(context).primaryColor,
                                )),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Colors.grey,
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Message',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey.shade600),
                        ),
                        TextFormField(
                          controller: messageController,
                          maxLines: 5,
                          keyboardType: TextInputType.name,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Message',
                            hintStyle: TextStyle(color: Colors.grey),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Theme.of(context).primaryColor,
                                )),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Colors.grey,
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: ElevatedButton(
                            onPressed: sendMail,
                            child: Text(
                              'Send Message',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ],
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
