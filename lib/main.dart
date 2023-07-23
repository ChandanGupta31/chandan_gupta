import 'package:chandan_gupta/screens/certificate.dart';
import 'package:chandan_gupta/screens/contact.dart';
import 'package:chandan_gupta/screens/container.dart';
import 'package:chandan_gupta/screens/home.dart';
import 'package:chandan_gupta/screens/project.dart';
import 'package:chandan_gupta/services/easy_loading.dart';
import 'package:chandan_gupta/services/firebase.dart';
import 'package:chandan_gupta/services/firebase_data.dart';
import 'package:chandan_gupta/widgets/contact_column.dart';
import 'package:chandan_gupta/widgets/contact_row.dart';
import 'package:chandan_gupta/widgets/home_column.dart';
import 'package:chandan_gupta/widgets/home_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

Future<void> main() async {

  EasyLoadingService.initialize();
  await FirebaseServices.initialize();
  await FirebaseData.getData();

  runApp(MaterialApp(

    debugShowCheckedModeBanner: false,
    initialRoute: 'container',

    routes: {
      'container' : (context) => ContainerScreen(),
      'home' : (context) => HomeScreen(),
      'project' : (context) => ProjectScreen(),
      'certificate' : (context) => CertificateScreen(),
      'contact' : (context) => ContactScreen(),
      'home_row' : (context) => HomeRow(),
      'home_column' : (context) => HomeColumn(),
      'contact_row' : (context) => ContactRow(),
      'contact_column' : (context) => ContactColumn(),
    },

    theme: ThemeData(
      fontFamily: 'Poppins',
      primaryColor: Color(0xFFF0A04B),
    ),

    builder: EasyLoading.init(),
  ));

}

