import 'dart:convert';

import 'package:chandan_gupta/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/firebase_data.dart';
import 'package:http/http.dart' as http;

class ContactApp extends StatefulWidget {
  ContactApp({super.key});

  @override
  State<ContactApp> createState() => _ContactAppState();
}

class _ContactAppState extends State<ContactApp> {
  // Variable declaration
  var width;
  var height;

  late GoogleSignIn _googleSignIn;
  late String _accessToken;
  late String _idToken;

  // Controller Declaration
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var mobileController = TextEditingController();
  var subjectController = TextEditingController();
  var messageController = TextEditingController();

  // Defining URLs
  var urlLinkedIn = Uri.parse(FirebaseData.linkedinLink);
  var urlGitHub = Uri.parse(FirebaseData.githubLink);
  var urlInstagram = Uri.parse(FirebaseData.instagramLink);
  var urlTwitter = Uri.parse(FirebaseData.twitterLink);

  // ****************** Defining Functions **********************

  // Sending Mail
  void sendMail() async {
    // creating credential parameters
    final serviceID = 'service_vr5kq3b';
    final templateID = 'template_k8bylkf';
    final userID = 'ABABx6GtDCvIf8DI3';

    if(nameController.text.isNotEmpty && emailController.text.isNotEmpty && subjectController.text.isNotEmpty && messageController.text.isNotEmpty){
      try{
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
              'user_subject': subjectController.text.toString(),
              'user_name': nameController.text.toString(),
              'user_email': emailController.text.toString(),
              'user_mobile' : mobileController.text.toString(),
              'message': messageController.text.toString(),
            }
          }),
        );

        // showing success response
        if (response.statusCode == 200) {
          // clearing fields
          nameController.clear();
          emailController.clear();
          mobileController.clear();
          subjectController.clear();
          messageController.clear();

          // showing snackBar
          final snackBar = SnackBar(
            content: Text(
              'E-Mail sent Successfully\n Get back to you soon....',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            backgroundColor: Colors.greenAccent,
            padding: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }

        // showing failure response
        else {
          final snackBar = SnackBar(
            content: Text(
              'Some Error Occured\nTry Again....',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            backgroundColor: Colors.redAccent,
            padding: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }catch(ex){
        final snackBar = SnackBar(
          content: Text(
            'Some Error Occured\nTry Again....',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          backgroundColor: Colors.redAccent,
          padding: EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }

    // user has not provided sufficient data
    else{
      final snackBar = SnackBar(
        content: Text(
          'Fill All the Details',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        backgroundColor: Colors.redAccent,
        padding: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }


  }

  // Launching URLs
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
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: height * 0.05,
              ),
              Text(
                'Let\'s Stay Connected',
                style: Style.headerTextStyle,
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Container(
                width: width * 0.85,
                padding: EdgeInsets.all(15),
                decoration: Style.boxStyle,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Full Name *',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey.shade600),
                    ),
                    TextFormField(
                      controller: nameController,
                      maxLines: 1,
                      keyboardType: TextInputType.name,
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
                      height: height * 0.02,
                    ),
                    Text(
                      'E-mail ID *',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey.shade600),
                    ),
                    TextFormField(
                      controller: emailController,
                      maxLines: 1,
                      keyboardType: TextInputType.emailAddress,
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
                      height: height * 0.02,
                    ),
                    Text(
                      'Mobile Number',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey.shade600),
                    ),
                    TextFormField(
                      controller: mobileController,
                      maxLines: 1,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: '+91 7048879904',
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
                      height: height * 0.02,
                    ),
                    Text(
                      'Subject *',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey.shade600),
                    ),
                    TextFormField(
                      controller: subjectController,
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'Type Your Subject',
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
                      height: height * 0.02,
                    ),
                    Text(
                      'Message *',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey.shade600),
                    ),
                    TextFormField(
                      controller: messageController,
                      maxLines: 8,
                      keyboardType: TextInputType.name,
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
                      height: height * 0.02,
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: sendMail,
                        child: Text(
                          'Send Message',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18,
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
              SizedBox(
                height: height * 0.02,
              ),
              Container(
                width: width * 0.85,
                padding: EdgeInsets.all(15),
                decoration: Style.boxStyle,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email Address',
                      style: Style.headingText,
                    ),
                    GestureDetector(
                      onTap: () {
                        copyText(FirebaseData.email);
                      },
                      child: Text(
                        FirebaseData.email,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey.shade700),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Text(
                      'Address',
                      style: Style.headingText,
                    ),
                    Text(
                      FirebaseData.address,
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey.shade700),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Text(
                      'Phone Number',
                      style: Style.headingText,
                    ),
                    GestureDetector(
                      onTap: () {
                        copyText(FirebaseData.number);
                      },
                      child: Text(
                        FirebaseData.number,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey.shade700),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Divider(
                      color: Colors.grey.shade700,
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Text(
                      'Social Media',
                      style: Style.headingText,
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            launchURL(urlLinkedIn);
                          },
                          icon: Image.asset(
                            'assets/images/linkedin.png',
                            color: Colors.grey.shade700,
                          ),
                          constraints: BoxConstraints(
                            minWidth: 70,
                            maxHeight: 70,
                            maxWidth: 70,
                            minHeight: 70
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            launchURL(urlGitHub);
                          },
                          icon: Image.asset(
                            'assets/images/github.png',
                            color: Colors.grey.shade700,
                          ),
                          constraints: BoxConstraints(
                              minWidth: 70,
                              maxHeight: 70,
                              maxWidth: 70,
                              minHeight: 70
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            launchURL(urlInstagram);
                          },
                          icon: Image.asset(
                            'assets/images/instagram.png',
                            color: Colors.grey.shade700,
                          ),
                          constraints: BoxConstraints(
                              minWidth: 70,
                              maxHeight: 70,
                              maxWidth: 70,
                              minHeight: 70
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            launchURL(urlTwitter);
                          },
                          icon: Image.asset(
                            'assets/images/twitter.png',
                            color: Colors.grey.shade700,
                          ),
                          constraints: BoxConstraints(
                              minWidth: 70,
                              maxHeight: 70,
                              maxWidth: 70,
                              minHeight: 70
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
