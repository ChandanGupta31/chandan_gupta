import 'package:chandan_gupta/services/firebase_data.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactRow extends StatefulWidget {
  ContactRow({super.key});

  @override
  State<ContactRow> createState() => _ContactRowState();
}

class _ContactRowState extends State<ContactRow> {

  var nameController = TextEditingController();
  var contactController = TextEditingController();
  var messageController = TextEditingController();
  var urlLinkedIn = Uri.parse(FirebaseData.linkedin);
  var urlGitHub= Uri.parse(FirebaseData.github);
  var urlEmail= Uri.parse('mailto:${FirebaseData.email}');
  var urlPhone = Uri.parse('callto:${FirebaseData.phone}');

  void linkedIn() async {
    if (!await launchUrl(
      urlLinkedIn,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $urlLinkedIn');
    }
  }

  void github() async {
    if (!await launchUrl(
      urlGitHub,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $urlGitHub');
    }
  }

  void email() async {
    if (!await launchUrl(
      urlEmail,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $urlEmail');
    }
  }

  void phone() async {
    if (!await launchUrl(
      urlPhone,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $urlPhone');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: MediaQuery.of(context).size.width*0.05,
          ),
          child: Column(
            children: [
              Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width*0.53,
                  child: Column(
                    children: [
                      Text(
                        'Message Me ...',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'JMH',
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(
                            hintText: 'Your Name ...',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 0.5,
                                )),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 0.5,
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 0.5,
                                )),
                          ),
                          cursorColor: Theme.of(context).primaryColor,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: TextFormField(
                          controller: contactController,
                          decoration: InputDecoration(
                            hintText: 'Phone No./ Email ID',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 0.5,
                                )),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 0.5,
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 0.5,
                                )),
                          ),
                          cursorColor: Theme.of(context).primaryColor,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.35,
                        child: TextFormField(
                          controller: messageController,
                          minLines: 7,
                          maxLines: 7,
                          decoration: InputDecoration(
                            hintText: 'Type Your Message Here ...',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 0.5,
                                )),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 0.5,
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 0.5,
                                )),
                          ),
                          cursorColor: Theme.of(context).primaryColor,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.08,
                        width: MediaQuery.of(context).size.width * 0.3,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Send',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.send_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),

                      SizedBox(
                        height: MediaQuery.of(context).size.height*0.1,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.04,
                ),
                Container(
                  width: MediaQuery.of(context).size.width*0.33,
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          'Contact Details',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'JMH',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/user.png',
                            color: Theme.of(context).primaryColor,
                            height: 23,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Chandan Gupta',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      GestureDetector(
                        onTap: phone,
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/telephone.png',
                              color: Theme.of(context).primaryColor,
                              height: 23,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              FirebaseData.phone,
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      GestureDetector(
                        onTap: email,
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/email_round.png',
                              color: Theme.of(context).primaryColor,
                              height: 23,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              FirebaseData.email,
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      GestureDetector(
                        onTap: linkedIn,
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/linkedin.png',
                              color: Theme.of(context).primaryColor,
                              height: 23,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'LinkedIn Profile',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      GestureDetector(
                        onTap: github,
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/github.png',
                              color: Theme.of(context).primaryColor,
                              height: 23,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'GitHub Profile',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),

                      SizedBox(
                        height: MediaQuery.of(context).size.height*0.1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            ]
          ),
        ),
      ),
    );
  }
}
