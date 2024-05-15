import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FirebaseData {
  static var photoLink = "";
  static var resumeLink = "";
  static var linkedinLink = "";
  static var githubLink = "";
  static var twitterLink = "";
  static var instagramLink = "";
  static var email = "";
  static var number = "";
  static var address = "";
  static var achievements = [];
  static var certificates = [];
  static List<Map<String, dynamic>> projects = [];
  static List<Map<String, dynamic>> technologyStack = [];

  static Future<String> getDataFromFirebase() async {

    // Getting Personal Details
    await FirebaseFirestore.instance
        .collection('details')
        .doc('fantEMpvwAc8b3glDT8x')
        .get()
        .then((value) => {
              photoLink = value['profile-photo'],
              resumeLink = value['resume-url'],
              email = value['e-mail'],
              number = value['number'],
              address = value['address'],
              linkedinLink = value['linkedin'],
              githubLink = value['github'],
              twitterLink = value['twitter'],
              instagramLink = value['instagram'],
            });

    // Getting Certificates
    await FirebaseFirestore.instance
        .collection('certificates')
        .doc('mE67titxiKNYdNEAPdC7')
        .get()
        .then((value) => {certificates = value['certificateList']});

    // Getting Projects
    await FirebaseFirestore.instance
        .collection('projects')
        .get()
        .then((QuerySnapshot value) => {
              value.docs.forEach((QueryDocumentSnapshot doc) {
                Map<String, dynamic> projectData =
                    doc.data() as Map<String, dynamic>;
                projects.add(projectData);
              })
            });

    // Getting Technology Stacks
    await FirebaseFirestore.instance
        .collection('technology_stack')
        .get()
        .then((QuerySnapshot value) => {
      value.docs.forEach((QueryDocumentSnapshot doc) {
        Map<String, dynamic> projectData =
        doc.data() as Map<String, dynamic>;
        technologyStack.add(projectData);
      })
    });

    if (kDebugMode) {
      print(certificates);
      print(projects);
      print(technologyStack);
    }
    return "";
  }
}
