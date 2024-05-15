import 'package:chandan_gupta/app/home/home.dart';
import 'package:chandan_gupta/services/firebasse/firebase_options.dart';
import 'package:chandan_gupta/utils/colors.dart';
import 'package:chandan_gupta/utils/easy_loading.dart';
import 'package:chandan_gupta/utils/firebase_data.dart';
import 'package:chandan_gupta/utils/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

Future<void> main() async {

  // Widget Initialization
  WidgetsFlutterBinding.ensureInitialized();

  // Initializing Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Calling functions to fetch data
  await FirebaseData.getDataFromFirebase();

  // Initializing EasyLoading
  EasyLoadingService.initialize();

  // App Configuration
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: route,
    themeMode: ThemeMode.light,
    theme: ThemeData(
      useMaterial3: true,
      primaryColor: const Color(0xFF1CBDD2),                // Main Colour
      secondaryHeaderColor: const Color(0xFFC6EEF4),        // For background Purpose
      fontFamily: 'Poppins',
    ),

    // theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
    // darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),


    builder: EasyLoading.init(),
  ),);

}