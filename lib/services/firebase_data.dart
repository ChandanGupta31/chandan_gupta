import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class FirebaseData {
  static var certificateList = [];
  static var name = 'Chandan Gupta';
  static var email = '';
  static var phone = '';
  static var introduction = [];
  static var age = '';
  static var experience = '';
  static var profession = '';
  static var qualification = '';
  static var profilePhoto = '';
  static var resumeURL = '';
  static var linkedin = '';
  static var github = '';

  static Future<void> getData() async {
    // EasyLoading.show();

    await FirebaseFirestore.instance
        .collection('certificates')
        .doc('mE67titxiKNYdNEAPdC7')
        .get()
        .then((value) => certificateList = value.get('certificateList'));

    await FirebaseFirestore.instance
        .collection('details')
        .doc('fantEMpvwAc8b3glDT8x')
        .get()
        .then((value) => {
              email = value.get('e-mail'),
              phone = value.get('number'),
              introduction = value.get('introduction'),
              age = value.get('age'),
              experience = value.get('experience'),
              profession = value.get('profession'),
              qualification = value.get('qualification'),
              profilePhoto = value.get('profile-photo'),
              resumeURL = value.get('resume-url'),
              linkedin = value.get('linkedin'),
              github = value.get('github'),
    });

    // EasyLoading.dismiss();

    print(certificateList.toString());
    print(name);
    print(introduction);
    print(profession);
    print(qualification);
    print(age);
    print(phone);
    print(email);
    print(experience);
    print(profilePhoto);
    print(resumeURL);
    print(linkedin);
    print(github);

  }
}
